class PasswordResetController < ApplicationController
  skip_before_action :authorized

  def create
    email = password_reset_params[:email]
    broker = Broker.find_by(email: email)

    broker&.generate_password_token!

    send_reset_password_email(broker.id)

    head :no_content
  end

  private

  def password_reset_params
    params.permit(:email)
  end

  def send_reset_password_email(broker_id)
    BrokerMailer.with(broker_id: broker_id).reset_password.deliver_now!
  end
end
