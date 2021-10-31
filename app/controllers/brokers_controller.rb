class BrokersController < ApplicationController
  skip_before_action :authorized, only: %i[create show]
  before_action :load_broker, only: %i[show]

  def create
    broker = Broker.create(broker_params)

    if broker.valid?
      token = encode_token(broker)
      send_welcome_email(broker.id.to_s)
      render json: { token: token }, status: :created
    else
      render_error(fields: broker.errors.messages, status: :bad_request)
    end
  end

  def show
    render json: @broker
  end

  def me
    render json: set_broker
  end

  private

  def load_broker
    @broker = Broker.find(params[:id])
  end

  def broker_params
    params.require(:broker).permit(:name, :email, :password)
  end

  def searchable_params
    params.permit({ search: {} }, { page: {} }, :include)
  end

  def send_welcome_email(broker_id)
    broadcast(:new_broker_registered, broker_id)
  end
end
