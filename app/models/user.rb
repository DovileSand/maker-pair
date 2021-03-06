class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :omniauthable, :omniauth_providers => [:github]

  has_one :profile

  def self.from_omniauth(auth)
    where(provider: auth.provide, uid: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.nickname = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
      user.image = auth.info.image
      user.url = auth.info.urls.GitHub
    end
  end
end
