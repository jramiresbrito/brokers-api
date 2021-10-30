class SignInController < ApplicationController
  skip_before_action :authorized, only: :create

  def create
    email = sign_in_params[:email]
    password = sign_in_params[:password]

    @broker = Broker.find_by(email: email)
    if @broker&.authenticate(password)

      token = encode_token(@broker)
      render json: { token: token }, status: :ok
    else
      render_broker_error(:credentials, 'are invalid', :unauthorized)
    end
  rescue Mongoid::Errors::DocumentNotFound
    raise InvalidCredentialsError
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end

  def set_broker_error(field, message)
    @broker.errors.add(field, message)
  end

  def render_broker_error(field, message, status)
    set_broker_error(field, message)
    render_error(fields: @broker.errors, status: status)
  end
end
