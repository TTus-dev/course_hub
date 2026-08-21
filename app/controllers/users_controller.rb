class UsersController < ApplicationController
  skip_before_action :require_login, only: [ :new, :create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:user][:name].capitalize,
      email: params[:user][:email],
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation],
      role: "student"
    )

    if @user.save
      redirect_to root_path, notice: "Account successfully created. You can now log in."
    else
      render :new, status: :unprocessable_entity
    end
  end
end
