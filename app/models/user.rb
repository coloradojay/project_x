class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :user_name, type: String
  field :name, type: String
  field :email, type: String
  mount_uploader :avatar, AvatarUploader
  field :password_digest, type: String
  attr_reader :password

  #setter method
  def password=(unencrypted_password)
    unless unencrypted_password.empty?
      @password = unencrypted_password
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def authenticate(unencrypted_password)
    if BCrypt::Password.new(self.password_digest) == unencrypted_password
      return self
    else
      return false
    end
  end

  # Validating name, email and password
  validates :user_name, presence: true, uniqueness: true, on: :create
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, presence: true, length: { :within => 6..40 }, confirmation: true, :allow_blank => false, :on => :create
  validates :password, presence: true, length: { :within => 6..40 }, confirmation: true, :allow_blank => true, :on => :update
  

  has_many :posts, dependent: :destroy
end
