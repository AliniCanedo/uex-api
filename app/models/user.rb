class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :contacts, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  private

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def generate_authentication_token
    loop do

      token = Devise.friendly_token
      break token unless User.exists?(authentication_token: token)

    end
  end
end
