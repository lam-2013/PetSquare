class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation

  has_many :pets, :dependent => :destroy

  has_many :followed_pets, through: :relationships, source: :followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  has_many :reviews
  has_many :checkins

  has_secure_password

  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 50 };
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def follow!(pet)
    relationships.create!(followed_id: pet.id, follower_id: id)
  end

  def unfollow!(pet)
    relationships.find_by_followed_id(pet).destroy
  end

  def following?(pet)
    followed_pets.include?(pet)
  end

  def feed
    Checkin.from_pets_followed_by(self)
  end

  # private methods
  private
  def create_remember_token
    # create a random string, safe for use in URIs and cookies, for the user remember token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
