class BrokerMailer < ApplicationMailer
  default from: 'brokers@api.com'

  def welcome_email
    @broker = Broker.find(params[:broker_id])

    mail(to: @broker.email, subject: 'Bem vindo a Brokers API!')
  end

  def reset_password
    @broker = Broker.find(params[:broker_id])
    @token = @broker.reset_password_token

    mail(to: @broker.email, subject: 'Mudança de senha')
  end
end
