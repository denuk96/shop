# == Schema Information
#
# Table name: users
#
#  id               :bigint           not null, primary key
#  email            :string           not null
#  crypted_password :string
#  salt             :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  admin            :boolean          default(FALSE)
#

class User < ApplicationRecord
  authenticates_with_sorcery!
  attr_accessor :password, :password_confirmation

  has_many :comments, dependent: :destroy
  has_many :orders
  has_one :cart, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, allow_nil: true
  validate :pass_val

  after_create :send_welcome

  private

  def pass_val
    if password.present?
      if password.count('a-z') <= 0 || password.count('A-Z') <= 0 # || password.count('0-9') <= 0
        errors.add(:password, I18n.t('models.user.password_validation'))
      end
    end
  end

  def send_welcome
    UserMailer.welcome_email(self).deliver!
  end
end
