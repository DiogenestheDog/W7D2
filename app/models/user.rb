# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  email           :string           not null
#  session_token   :string           not null
#  password_digest :string           not null
#

class User < ApplicationRecord
    validates :email, :session_token, presence: true, uniqueness: true
    validates :password_digest, presence: true
    validates :password, length: { minimum: 8, allow_nil: true }
    attr_reader :password
    after_initialize :ensure_session_token

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_token!
        self.session_token = User::generate_session_token
    end

    def ensure_session_token
        self.session_token ||= self.reset_token!
    end

    def password=(pw)
        self.password_digest = BCrypt::Password.create(pw)
    end

    def is_password?(pw)
       BCrypt::Password.new(self.password_digest).is_password?(pw)
    end

    def self.find_by_credentials(email, password)
        found_user = User.find_by(email: email)
        return found_user if found_user.is_password?(password)           
    end

end
