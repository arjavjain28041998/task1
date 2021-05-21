class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook linkedin spotify google_oauth2]

  def self.from_omniauth(auth)
  if self.where(email: auth.info.email).exists?
    return_user = self.where(email: auth.info.email).first
    return_user.provider = auth.provider
    return_user.uid = auth.uid
  else
    return_user = self.create do |user|
       user.provider = auth.provider
       user.uid = auth.uid
       user.name = auth.info.name
       user.username = auth.info.username
       user.email = auth.info.email
       
    end
  end
  return_user
end


 def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
 end

 def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.linkedin_data"] && session["devise.linkedin_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
 end
 def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.spotify_data"] && session["devise.spotify_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
 end

 def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.google_data"] && session["devise.google_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
 end

 
end
