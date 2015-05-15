class User < ActiveRecord::Base

	attr_accessor :password

  has_many :microposts, :dependent => :destroy #Un user possède plusieurs , dependent... detruit un message et son auteur


	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  	validates :nom,  :presence => true,
                    :length   => { :maximum => 50 }
  	validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }



    # Crée automatique l'attribut virtuel 'password_confirmation'.
  	validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }



  #signin
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    #return user if user.has_password?(submitted_password)
    return user.nil? ? nil : user
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  #alimentation 
  def feed
    Micropost.where("user_id = ?", id)    
  end

end
