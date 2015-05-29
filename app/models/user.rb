
#for secur password
require 'digest'

class User < ActiveRecord::Base

	attr_accessor :password

  has_many :microposts, :dependent => :destroy #Un user possède plusieurs , dependent... detruit un message et son auteur

  #Association following(tab user) sur le modèle user avec Has_many:trough
  has_many :relationships, :class_name => "Relationship",
                           :foreign_key => "follower_id", 
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed

  # has_many :relationships, :foreign_key => "follower_id", 
  #                          :dependent => :destroy
  # has_many :following, :through => :relationships, :source => :followed

  #relations inverse utilisant followed_id coe PK
  has_many :reverse_relationships, :class_name => "Relationship",
                                   :foreign_key => "followed_id",
                                   :dependent => :destroy
 has_many :followers, :through => :reverse_relationships, :source => :follower
 has_many :following, :through => :relationships, :source => :followed
  


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




  #callback
  before_save :encrypt_password

  #Retourne true si le mot de passe correspond
  def has_password?(password_soumis)
    #comparaison avec la version encrypté du password
    #password_soumis
    encrypted_password == encrypt(password_soumis)
  end



  #signin
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
    #Methode qui marche
    #return user.nil? ? nil : user
  end

  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end

  #alimentation 
  def feed
    #Micropost.where("user_id = ?", id)    
    Micropost.from_users_followed_by(self)
  end

  #Alimentation
  def self.from_users_followed_by(user)
    followed_ids = user.following.map(&:id).join(", ")
    where("user_id IN (#{followed_ids}) OR user_id = ?", user)
  end


  def following?(followed)
    relationships.find_by(:followed_id => followed.id)
    #relationships.include?(followed)
  end

  #methode appelant create via relationships
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end

  #arrete le suivi d'un user
  def unfollow!(followed)
    relationships.find_by(:followed_id => followed.id).destroy
  end


  private 
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end
