class ApplicationController < ActionController::API
  rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found
  rescue_from ResetPasswordError, with: :not_authorized
  rescue_from InvalidCredentialsError, with: :broker_not_found

  LEEWAY = 300 # 5 minutes
  EXPIRATION_TIME = 7.days
  API_SECRET = Rails.application.secrets.secret_key_base
  before_action :authorized

  include Wisper::Publisher
  include SimpleErrorRenderable
  self.simple_error_partial = "shared/simple_error"

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  def create_resource(resource_obj)
    if resource_obj.save
      resource_success(resource_obj, :created)
    else
      render_error(fields: resource_obj.errors.messages)
    end
  end

  def destroy_resource(resource_obj)
    resource_obj.destroy!
  rescue StandardError
    render_error(fields: resource_obj.errors.messages)
  end

  def not_found
    render json: { errors: [{ controller_name.classify.underscore => 'not found' }] }, status: :not_found
  end

  def encode_token(payload)
    JWT.encode(token_payload(payload), API_SECRET)
  end

  def auth_header
    request.headers['Authorization']
  end

  def token_present?
    auth_header.present?
  end

  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        options = { exp_leeway: LEEWAY,
                    iss: ENV['JWT_ISS'],
                    verify_iss: true,
                    algorithm: 'HS256' }
        JWT.decode token, API_SECRET, true, options
      rescue JWT::DecodeError, JWT::InvalidIssuerError, JWT::ExpiredSignature
        nil
      end
    end
  end

  def logged_in_broker
    if decoded_token
      broker_id = decoded_token.first['broker_id']
      @broker = Broker.find(broker_id)
    end
  end

  def logged_in?
    !!logged_in_broker
  end

  def authorized
    return render json: { errors: [{ token: 'not found' }] }, status: :unauthorized unless token_present?

    not_authorized unless logged_in?
  end

  def set_broker
    logged_in_broker
  end

  private

  def token_payload(broker)
    iss = ENV['JWT_ISS']
    exp = (Time.now + EXPIRATION_TIME).to_i
    iat = Time.now.to_i
    { broker_id: broker.id.to_str, exp: exp, iat: iat, iss: iss }
  end

  def broker_not_found
    render json: { errors: [{ crendentials: 'are invalid' }] }, status: :bad_request
  end

  def not_authorized
    render json: { errors: [{ token: 'is either invalid or expired' }] }, status: :unauthorized
  end

  def resource_success(resource_obj, status)
    location_value = "#{request.original_url}/#{resource_obj.id}"
    response.set_header("Location", location_value)

    render json: resource_obj, status: status
  end
end
