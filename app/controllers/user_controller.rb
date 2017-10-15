class UserController < ApplicationController

  def create
    user = User.create(full_name: params[:full_name], email: params[:email], password: params[:password])
    if user.id.present?
      render json: {message: "User created"}
    else
      render json: {message: "User did not created", error: {messages: user.errors.full_messages}}, status: 422
    end
  end

  def index
    render json: {status: "hey"}
  end
end
