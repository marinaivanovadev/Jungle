
class User < ApplicationRecord
  has_secure_password
  
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: { case_sensitive: false }, presence: true
  validates :password, presence: true, length: { minimum: 8 }

  def self.authenticate_with_credentials(email, password)
    stripped_email = email.strip.downcase
    user = self.find_by(email: stripped_email)
    user && user.authenticate(password) ? user : nil
  end
end
