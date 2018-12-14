class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i(google)

  def self.find_for_google(auth)
    return nil unless auth.info.email.split("@").last == "innova-jp.com"

    user = User.find_by(email: auth.info.email)

    unless user
      user = User.create(
        email: auth.info.email,
        name: auth.info.name,
        provider: auth.provider,
        uid: auth.uid,
        token: auth.credentials.token,
        password: Devise.friendly_token(length = 8),
        meta: auth.to_yaml
      )
    end
    user
  end

end
