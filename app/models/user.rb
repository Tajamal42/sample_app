# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord
	attr_accessor :password

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50 }
	validates :email, :presence => true, :uniqueness => true, :format => email_regex
	validates :password, :presence => true, :confirmation => true, :length => { :in => 6..40 }

	before_save :encrypt_password

	def has_password?(submitted_password)
    	encrypted_password == encrypt(submitted_password)
  	end

  	#class method that authenticates a user, used to create a session cookie
	def self.authenticate(email, password)
	    user = User.find_by_email(email)

	    return nil if user.nil?
	    return user if user.has_password?(password)
    end 

    # used to authenticate a signed user from a signed cookie 
    def self.authenticate_with_salt(id, cookie_salt)
	    user = User.find_by_id(id)
	    return nil if user.nil?
	    return user if user.salt == cookie_salt
	end  

	# Encrypting process for new user's password
    private
	    def encrypt_password
	    	self.salt = Digest::SHA2.hexdigest("#{Time.now.utc}--#{password}")
	        self.encrypted_password = encrypt(password)
	    end
      	def encrypt(pass)
      		Digest::SHA2.hexdigest("#{self.salt}--#{pass}")
      	end
end
