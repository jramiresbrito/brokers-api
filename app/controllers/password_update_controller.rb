class PasswordUpdateController < ApplicationController
  skip_before_action :authorized
  before_action :set_broker, only: %i[create]

  def create
    @broker.update!(password_update_params)
    @broker.clear_password_token!
    head :no_content
  rescue Mongoid::Errors::Validations
    render_error(fields: @broker, status: :bad_request)
  end

  private

  def password_update_params
    params.permit(:password, :password_confirmation, :reset_password_token)
  end

  def set_broker
    @broker = Broker.find_by(reset_password_token: params[:reset_password_token])
    raise ResetPasswordError unless @broker.reset_password_token_expires_at > Time.now
  rescue Mongoid::Errors::DocumentNotFound
    raise ResetPasswordError
  end
end
