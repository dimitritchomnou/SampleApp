class User < ActiveRecord::Base

	attr_accessor :password

  has_many :microposts, :dependent => :destroy #Un user possède plusieurs , dependent... detruit un message et son auteur

  #relation User/relations
  has_many :relationships, :foreign_key => "follower_id",
                           :class_name => "Relationship", 
                           :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  #has_many :followers, :through => :relationships, :source => :follower

  has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  

  


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
    #Micropost.where("user_id = ?", id)    
    Micropost.from_users_followed_by(self)
  end

  #Alimentation
  def self.from_users_followed_by(user)
    followed_ids = user.following.map(&:id).join(", ")
    where("user_id IN (#{followed_ids}) OR user_id = ?", user)
  end


  def following?(followed)
    relationships.find_by_followed_id(followed)
  end

  def follow!(followed)#methode appelantcreate via relationships
    relationships.create!(:followed_id => followed_id)
  end

  #arrete le suivi d'un user
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end

end
