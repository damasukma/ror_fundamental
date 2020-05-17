class HomeController < ApplicationController
    
    def index
        @title = 'Home'
        if params[:title]
            @title = params[:title]
        end    
        @users = User.all
    end    
    
    def new
        @user = User.new
    end    

    def create
       @user = User.new(user_params)
    
       if @user.save 
        redirect_to root_path
       else
        render :new
       end 

    end    

    def show
        @user = User.find(params[:id])
    end    

    def edit
        @user = User.find(params[:id])        
    end

    def update

        begin
            @user = User.find(params[:id])
            @user.update!(user_params)
            redirect_to home_path
        rescue => ex
            Rails.logger.error(ex.message)
        end
       
    end

    def destroy
        @user = User.find(params[:id])

        if @user.destroy
            redirect_to root_path
        else
            render :home
        end
    end

    private

    def user_params
        params.require(:user).permit(:firstname, :lastname, :phone)
    end    

end
