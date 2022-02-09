class User < ApplicationRecord
  before_save { self.email.downcase! }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates(:name,  { presence: true, length: { maximum: 50 } })
  validates(:email, { presence: true, 
                      length: { maximum: 255 }, 
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
                    }
           )
  has_secure_password
  # ↑これを追加すると、
  # (1) ハッシュ化したパスワードをデータベース内のpassword_digestという属性に保存できるようになる。
  # (2) 2つの仮想的な属性(passwordとpassword_confirmation)が使え、存在性と値が一致するかのバリデーションも追加される
  # (3) authenticateメソッドが使えるようになる。(引数の文字列がパスワードと一致するとUserを、間違っているとfalseを返すメソッド)
  validates(:password, { presence: true, length: { minimum: 6 } })
end