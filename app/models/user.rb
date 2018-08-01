class User < ApplicationRecord
    attr_accessor :remember_token, :activation_token, :reset_token
    before_create :create_activation_digest
    before_validation { self.email = email.downcase }
    before_validation { self.phone = phone.gsub(/-/, '')}
    before_validation { self.zipcode = zipcode.gsub(/-/, '')}
    validates :corporate_name, presence: true
    validates :lastname, presence: true
    validates :firstname, presence: true
    VALID_KANA_REGEX = /\A[ァ-ンー－]+\z/
    validates :lastname_phonetic, presence: true, format: { with: VALID_KANA_REGEX }
    validates :firstname_phonetic, presence: true, format: { with: VALID_KANA_REGEX }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence:   true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
    VALID_NUMBER_REGEX = /\A\d+\z/
    validates :phone, presence: true, length: { maximum: 11 }, format: { with: VALID_NUMBER_REGEX}
    validates :zipcode, presence: true, length: { is: 7 }, format: { with: VALID_NUMBER_REGEX}
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    validates :pref, presence:true
    validates :city, presence:true
    validates :street, presence: true
    validates :building, presence: true, allow_blank: true
    has_many :stocks, dependent: :destroy
    has_many :orders
    has_many :postages, dependent: :destroy

    class << self
        def digest(string)
            cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
        end

        def new_token
            SecureRandom.urlsafe_base64
        end
    end

    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end

    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end

    def forget
        update_attribute(:remember_digest, nil)
    end

    def activate
        update_columns(activated: true , activated_at:Time.zone.now)
    end

    def send_activation_email
        UserMailer.account_activation(self).deliver_now
    end

    def prefecture_name
      JpPrefecture::Prefecture.find(code: prefecture_id).try(:name)
    end

    def prefecture_name=(prefecture_name)
      self.prefecture_id = JpPrefecture::Prefecture.find(name: prefecture_name).code
    end

    def create_reset_digest
      self.reset_token = User.new_token
      update_attributes(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now )
    end

    def send_password_reset_email
      UserMailer.password_reset(self).deliver_now
    end

    def password_reset_expired?
        reset_sent_at < 1.hours.ago
    end

    private

    def create_activation_digest
        self.activation_token  = User.new_token
        self.activation_digest = User.digest(activation_token)
    end
end
