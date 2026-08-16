class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  def new
    if current_user
      redirect_to dashboard_path
    end
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path
    else
      render plain: "invalid email or password"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
