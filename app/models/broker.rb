class Broker
  include ActiveModel::SecurePassword
  include Mongoid::Document
  include Mongoid::Timestamps
  include LikeSearchable

  before_save { self.email = email.downcase }

  field :name, type: String
  field :email, type: String
  field :password_digest, type: String
  field :reset_password_token, type: String, default: nil
  field :reset_password_token_expires_at, type: Date, default: nil

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    uniqueness: { case_sensitive: false },
                    format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 128 }

  def generate_password_token!
    loop do
      self.reset_password_token = SecureRandom.urlsafe_base64
      break unless Broker.where(reset_password_token: reset_password_token).exists?
    end
    self.reset_password_token_expires_at = 1.day.from_now
    save(validate: false)
  end

  def clear_password_token!
    self.reset_password_token = nil
    self.reset_password_token_expires_at = nil
    save!
  end
end
