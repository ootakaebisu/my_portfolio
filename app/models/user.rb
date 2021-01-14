class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :my_id, uniqueness: true
  has_many :sns_credentials, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2]

  has_many :missions, dependent: :destroy
  accepts_nested_attributes_for :missions

  attachment :profile_image

  has_many :calendars #カレンダー内データを指す

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  has_many :following_users, through: :follower, source: :followed # 自分がフォローしている人
  has_many :follower_users, through: :followed, source: :follower # 自分をフォローしている人

  # ユーザーをフォローする
  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_users.include?(user)
  end



  def self.without_sns_data(auth)
    # すでに認証済みか否か（DBにデータがあるか探している）
    user = where(email: auth.info.email).first

      if user.present? #2回目以降の認証
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else #初めてSNS認証する時
        # パスワードがないとバリデーションに引っかかるので自動生成して与える
        password = Devise.friendly_token.first(7)
        user = new(
          name: auth.info.name,
          email: auth.info.email,
          password: password
        )
        user.save
        sns = SnsCredential.new(
          uid: auth.uid,
          provider: auth.provider
        )
      end
      return { user: user ,sns: sns}
  end

   def self.with_sns_data(auth, snscredential)
    user = where(id: snscredential.user_id).first
    unless user.present?
      user = new(
        nickname: auth.info.name,
        email: auth.info.email,
      )
    end
    return {user: user}
   end

  def self.find_oauth(auth)
    uid = auth.uid
    provider = auth.provider
    snscredential = SnsCredential.where(uid: uid, provider: provider).first
    if snscredential.present?
      user = with_sns_data(auth, snscredential)[:user]
      sns = snscredential
    else
      user = without_sns_data(auth)[:user]
      sns = without_sns_data(auth)[:sns]
    end
    return { user: user ,sns: sns}
  end

end
