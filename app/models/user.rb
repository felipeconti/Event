class User < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable

	devise  :database_authenticatable, #:registerable,
			:recoverable, :rememberable, :trackable, :validatable,
			:omniauthable,
	 		:omniauth_providers => [:facebook, :github]

	has_many :authentications, :dependent => :delete_all
  has_many :notifications, :dependent => :delete_all
  
  has_and_belongs_to_many :events
  before_destroy {|user| user.events.clear}

	validates_presence_of :name
	validates_format_of :email, with: /\A.+@.+\..{2,4}\z/
	validates_uniqueness_of :email

	acts_as_voter

	# def self.new_with_session(params, session)
	# 	super.tap do |user|
	# 		if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
	# 			user.email = data["email"] if user.email.blank?
	# 		end
	# 	end
	# end

	def self.find_for_oauth(auth, signed_in_resource=nil)
		# require "pry"; binding.pry

		authentication = Authentication.find_by_provider_and_uid(auth.provider, auth.uid)
		if authentication && authentication.user
			authentication.user
		else
			if auth.info.email.blank?
				email = ""
			else
				email = auth.info.email
			end

			if auth.info.name.blank?
				name = auth.info.nickname
			else
				name = auth.info.name
			end

			user = User.find_by_email(email)

			unless user
				user = User.create!(name: name,
				                    email: email,
				                    password: Devise.friendly_token[0,20])
			end

			user.authentications.create!(:provider => auth.provider, :uid => auth.uid)
			user.save
			user
		end
	end

end
