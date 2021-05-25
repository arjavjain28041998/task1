class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook linkedin spotify google_oauth2]

 def self.from_omniauth(auth)
     user.email = auth.info.email
     user.password = Devise.friendly_token[0, 20]
     user.name = auth.info.name   
     user.image = auth.info.image
    
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
