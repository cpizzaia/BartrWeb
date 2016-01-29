class User < ActiveRecord::Base
  validates :name, :session_token, :password_digest, :session_token, :location, presence: true
  validates :name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }

  after_initialize :generate_session_token

  has_many(
    :items,
    class_name: "Item",
    foreign_key: :owner_id,
    primary_key: :id
  )

  attr_reader :password

  def self.find_by_credentials(name, password)
    user = User.find_by_name(name)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64
    self.save
    self.session_token
  end

  def generate_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end
end
