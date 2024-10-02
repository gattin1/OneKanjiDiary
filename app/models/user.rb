# frozen_string_literal: true

# Userモデルは、アプリケーションのユーザーを管理する。
class User < ApplicationRecord
  has_many :sns_credentials, dependent: :destroy
  has_many :diaries, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line]

  class << self
    # SnsCredentialsテーブルにデータがないとき
    def without_sns_data(auth)
      email = auth.info.email || "temp-email-#{auth.uid}@example.com" # 仮のメールアドレスを生成
      user = User.where(email: auth.info.email).first

      if user.present?
        sns = SnsCredential.create(
          uid: auth.uid,
          provider: auth.provider,
          user_id: user.id
        )
      else
        user = User.create(
          name: auth.info.name,
          email: email,
          password: Devise.friendly_token(10)
        )

        user.update(line_id: auth.uid) if auth.provider == 'line'

        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user: user, sns: sns }
    end

    # SNSデータがある場合の処理
    def with_sns_data(auth, snscredential)
      user = find_user_by_sns(snscredential)

      if user.blank?
        user = create_user_from_auth(auth)
      elsif auth.provider == 'line' && user.line_id.blank?
        update_line_id(user, auth)
      end

      { user: user }
    end

    # Googleアカウントの情報をそれぞれの変数に格納して上記のメソッドに振り分ける処理
    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid: uid, provider: provider).first

      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        data = without_sns_data(auth)
        user = data[:user]
        sns = data[:sns]
      end

      { user: user, sns: sns }
    end

    private

    def find_user_by_sns(snscredential)
      User.where(id: snscredential.user_id).first
    end

    def create_user_from_auth(auth)
      user = User.create(
        name: auth.info.name,
        email: auth.info.email,
        profile_image: auth.info.image,
        password: Devise.friendly_token(10)
      )
      update_line_id(user, auth) if auth.provider == 'line'
      user
    end

    def update_line_id(user, auth)
      user.update(line_id: auth.uid)
    end
  end

  # LINE通知が受け取れるかどうかのチェック
  def can_receive_line_notification?
    reminder_time.present? && line_id.present?
  end

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
end
