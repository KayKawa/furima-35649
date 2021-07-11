class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable
  VALID_EMAIL_REGEX = /\A @ \z/
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :nickname, presence: true
  validates :email, { presence: true,
                      format: { with: VALID_EMAIL_REGEX } }
  validates :encrypted_password,  { presence: true, length: { minimum: 6 },
                                    format: { with: VALID_PASSWORD_REGEX } }
  validates :last_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX }
  validates :last_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :first_name_kana, presence: true, format: { with: VALID_KANA_REGEX }
  validates :birthday, presence: true
end
