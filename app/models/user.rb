# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  nom        :string
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base

	attr_accessor :password

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :nom, :presence => true, #validation de la présence nom
					:length => { :maximum => 50} #validation de longueur

	validates :email, :presence => true, #validation de la présence email
					  :format => { :with => email_regex }, 
					  :uniqueness => { :case_sensitive => false } #valider unicité des adresse mail en ignorant la case

	validates :password, :presence     => true,
						 :confirmation => true,
						 :length       => { :within => 6..40 }

	#Callback 
	before_save :encrypt_password

	private 

		def encrypt_password
			self.encrypted_password = encrypt(password)
		end

		def encrypt(string)
			string # à revoir
		end

end


