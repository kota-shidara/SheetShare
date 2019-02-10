class User < ApplicationRecord
    has_secure_password

		validates :name, presence: true, length: {maximum: 50}
		# まだ正しいフォーマットであるかの検証はしていない
		validates :email, presence: true,
											uniqueness: {case_sensitive: false},
											length: {maximum: 255}
		before_save {email.downcase!}
		# まだパスワードの文字数制限はかけていない
		validates :password, length: {minimum: 3}

		def User.digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
																									BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end
end
