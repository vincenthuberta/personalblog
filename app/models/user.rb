class User < ActiveRecord::Base
    has_many :posts
    attr_accessor :remember_token
    
    before_save { self.email = email.downcase }
    validates(:name, presence: true, length: {maximum: 20})
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, length: {maximum: 35}, format: {with: VALID_EMAIL_REGEX},
               uniqueness: {case_sensitive: false})
    has_secure_password #It's a rails method to ensure user has secure password
    # has_secure_password enforces
    # validations on the virtual password and password_confirmation attributes
    validates :password, length: { minimum: 6 }
    
    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
        BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Remembers a user in the database for use in persistent sessions.
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
# Having created a working user.remember method, we’re now in a position
# to create a persistent session by storing a user’s (encrypted) id and remember
# token as permanent cookies on the browser.
# The way to do this is with the
# cookies method, which (as with session) we can treat as a hash. A cookie
# consists of two pieces of information, a value and an optional expires date.

    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end
# To allow users to log out, we’ll define methods to forget users in analogy with
# the ones to remember them. The resulting user.forget method just undoes
# user.remember by updating the remember digest with nil.

    # Returns true if the given token matches the digest.
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
end
