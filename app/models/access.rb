class Access < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  include UUIDHelper
  belongs_to :verification
  belongs_to :actor, autosave: true

  validates_presence_of :username
  validates :username, uniqueness: true
  validates_length_of :username, maximum: 64
  validates_length_of :username, minimum: 3

  # Returns the hash digest of the given string. Used for SEEDS FILE
  def Access.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

end
