class Access < ActiveRecord::Base
  include UUIDHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :trackable, :validatable

  belongs_to :verification
  belongs_to :actor, autosave: true

  #has_secure_password
  # Returns the hash digest of the given string.
  def Access.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  validates_presence_of :username
  validates :username, uniqueness: true
  validates_length_of :username, maximum: 64
  validates_length_of :username, minimum: 3

end
