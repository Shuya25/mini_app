class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
  before_create :create_activation_digest
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
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  # validates(:password, { presence: true, length: { minimum: 6 } })
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # 渡されたトークンがダイジェストと一致したらtrueを返す
  # def authenticated?(remember_token)
  #   return false if self.remember_digest.nil?
  #   BCrypt::Password.new(self.remember_digest).is_password?(remember_token)
  # end
  
  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  
  # アカウントを有効にする
  def activate
    # self.update_attribute(:activated,    true)
    # self.update_attribute(:activated_at, Time.zone.now)
    self.update_columns(activated: true, activated_at: Time.zone.now)  # データベース問い合わせを１回にまとめる
  end

  # 有効化用のメールを送信する
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  
  
  private

    # メールアドレスをすべて小文字にする
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成および代入する
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
  
end