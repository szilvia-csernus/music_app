class User < ApplicationRecord
    attr_reader :password

    validates :email, :session_token, presence: true
    validates :email, uniqueness: true
    validates :password_digest, presence: {message: "Password can\'t be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}

    has_many :notes, dependent: :destroy

    after_initialize :ensure_session_token 

    def self.find_by_credentials(email, password)
        user = User.find_by(email: email)

        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.generate_token
        SecureRandom::urlsafe_base64
    end

    def set_activation_token
        self.activation_token = self.class.generate_token
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_token
        self.save!
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

    def activate_account!
        self.toggle(:activated)
        self.activation_token = "used!"
        self.save!
    end

    def activated?
        self.activated
    end

    def flip_admin!
        self.toggle(:admin)
        self.save!
    end

    def admin?
        self.admin
    end
end