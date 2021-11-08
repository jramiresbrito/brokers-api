# This consumer consumes the topic 'transaction.created' from
# *bolsadevalores* exchange. Then it creates or increment the amount of the
# related {OwnedAsset}.
#
# @author Joao Victor Ramires Guimaraes Brito
class TransactionCreatedConsumer
  include Hutch::Consumer

  consume 'transaction.created'

  def process(message)
    event = message.delivery_info.routing_key

    payload = JSON.parse(message.payload).deep_symbolize_keys
    transaction = payload[:transaction]

    broker = set_resource(transaction, :broker_id, Broker)
    asset = set_resource(transaction, :asset_id, Asset)
    amount = transaction[:amount].to_i
    OwnedAsset.where(broker_id: broker.id.to_s, asset_id: asset.id.to_s)
              .find_one_and_update(
                {
                  :$inc => { amount: amount }
                },
                upsert: true, # create a new record if it does not exist
                return_document: :after
              )
  end

  private

  def set_resource(transaction, key, model)
    resource_id = transaction[key]
    resource = model.find(resource_id)

    return resource
  end
end
