class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
    def create
      user = User.create(user_params)
      if user.valid?
        session[:user_id] = user.id # Save user ID in session after successful signup
        render json: user, status: :created
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def show
      if session[:user_id]
        user = User.find(session[:user_id])
        render json: user
      else
        head :unauthorized
      end
    end
  
    private
  
    def record_not_found
      render json: { error: "Invalid username or password" }, status: :not_found
    end
  
    def user_params
      params.permit(:username, :password, :password_confirmation)
    end
  end
  