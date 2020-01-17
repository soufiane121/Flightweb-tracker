class UsersController < ApplicationController

    def index
        users = User.all 
        render json: users, status: 200
    end

    def new
        user =User.find_by_id(params[:id])
        render json: user, status: :found
    end

    def show
        user = User.find_by_id(params[:id])
        render json: user, status: 200
    end

    def create
        @user = User.create(filtered_params)
        if @user.valid?
            render json: { user: UserSerializer.new(@user) }, status: :created
        else
           render json: {error: @user.errors.full_messages} , status: :not_created
        end
    end
    

    private 

    def filtered_params
        params.require(:user).permit(:user_name, :first_name, :last_name, :password_digest, :bio)
    end

end
