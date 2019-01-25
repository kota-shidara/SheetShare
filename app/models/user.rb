class User < ApplicationRecord
    has_secure_password

		validates :name, presence: true, length: {maximum: 50}
		# まだ正しいフォーマットであるかの検証はしていない
		validates :email, presence: true,
											uniqueness: {case_sensitive: false},
											length: {maximum: 255}
		before_save {email.downcase!}
		# まだ文字数制限はかけていない
		validates :password, presence: true

end
