class MailerListener
  def self.new_broker_registered(broker_id)
    BrokerMailer.with(broker_id: broker_id).welcome_email.deliver_now!
  end

  def self.send_reset_password_email(broker_id)
    BrokerMailer.with(broker_id: broker_id).reset_password.deliver_now!
  end

  def self.owned_asset_updated(broker_id, owned_asset_id)
    BrokerMailer.with(broker_id: broker_id, owned_asset_id: owned_asset_id).owned_asset_updated.deliver_now!
  end
end
