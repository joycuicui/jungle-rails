class User < ApplicationRecord
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  def self.authenticate_with_credentials(email, password)
    user = find_by_email(email.strip.downcase)
    user if user&.authenticate(password)
  end

end
