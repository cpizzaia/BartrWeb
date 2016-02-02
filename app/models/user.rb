class User < ActiveRecord::Base
  validates :username, :session_token, :password_digest, :session_token, :location, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  has_attached_file :image, default_url: "missing.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  after_initialize :generate_session_token

  has_many(
    :items,
    class_name: "Item",
    foreign_key: :owner_id,
    primary_key: :id
  )

  attr_reader :password

  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
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
