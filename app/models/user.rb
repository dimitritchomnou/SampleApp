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
	#attr_accessor :nom, :email

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :nom, :presence => true, #validation de la présence nom
					:length => { :maximum => 50} #validation de longueur
	validates :email, :presence => true, #validation de la présence email
					  :format => { :with => email_regex }, 
					  :uniqueness => { :case_sensitive => false } #valider unicité des adresse mail en ignorant la case
end
