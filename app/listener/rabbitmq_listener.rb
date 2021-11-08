# The RabbitmqListener class is responsible for publishing messages to
# RabbitMQ through
# {https://www.rabbitmq.com/tutorials/tutorial-five-ruby.html topic exchanging}.
#
# It uses the *BOLSADEVALORES* exchange to publish the payloads about events
# related to the brokers actions, such as asset buying or selling.
# Each event has a related routing key that follows this structure:
# - *buy.asset_code.amount.value*
# - *sell.asset_code.amount.value*
#
# The list of possible routing keys are described in the documentation of
# each method of this class.
#
# @author Joao Victor Ramires Guimaraes Brito
class RabbitmqListener
  # Publish in *BOLSADEVALORES* exchange a request to buy a specific asset.
  # This will be consumed by the Exchange-API in order to generate a bid of type
  # buy. If there is matching bid of type sell, a transaction will happen and
  # it will become an {OwnedAsset}.
  #
  # * routing key: bid.operation.asset_code.amount.value
  #
  # @param bid_id [String]
  # @!scope class
  def self.bid_asset(bid_id)
    bid = Bid.find(bid_id)
    operation = bid.operation

    publish_resource(bid, "bid.#{operation}")
  end

  # Utility method to find and serialize the resource, and publish the proper
  # message to RabbitMQ
  #
  # @param object
  #   the object to be broadcasted
  # @param routing_key [String]
  # @!scope class
  def self.publish_resource(object, routing_key)
    broker = object.broker
    payload = resource_as_json(object, scope: broker, scope_name: :current_user)
    publish(routing_key, payload)
  end

  # @param resource
  #   the resource to be serialized
  # @param options
  #   serializer options for the resource's serializer class
  # @!scope class
  def self.resource_as_json(resource, options = {})
    serializer_klass = ActiveModel::Serializer.serializer_for(resource)
    serializer = serializer_klass.new(resource, options)
    adapter = ActiveModelSerializers::Adapter::Json.new(serializer, options)
    adapter.as_json
  end

  # Utility method that encapsulates the communication with the Hutch module
  #
  # @param routing_key [String]
  # @param payload [Hash]
  # @!scope class
  def self.publish(routing_key, payload)
    Hutch.connect
    Hutch.publish(routing_key, payload)
  end
end
