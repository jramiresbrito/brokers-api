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

  def owned_asset_updated
    @broker = Broker.find(params[:broker_id])
    @owned_asset = OwnedAsset.find(params[:owned_asset_id])
    @asset = Asset.find(@owned_asset.asset.id)

    mail(to: @broker.email, subject: 'Transação efetuada')
  end
end
