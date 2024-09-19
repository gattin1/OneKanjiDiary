# frozen_string_literal: true

# Userモデルは、アプリケーションのユーザーを管理します。
# ユーザーの認証やアカウント管理に使用します。
class User < ApplicationRecord
  has_many :sns_credential, dependent: :destroy
  has_many :diaries, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[google_oauth2 line]

  class << self # self.を省略する
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

        user.update(line_id: auth.uid) if auth.provider == "line"

        sns = SnsCredential.create(
          user_id: user.id,
          uid: auth.uid,
          provider: auth.provider
        )
      end
      { user:, sns: }   # ハッシュ形式で呼び出し元に返す
    end

    # SNSデータがある場合の処理
    def with_sns_data(auth, snscredential)
      user = User.where(id: snscredential.user_id).first
      # 変数userの中身が空文字, 空白文字, false, nilの時の処理
      if user.blank?
        user = User.create(
          name: auth.info.name,
          email: auth.info.email,
          profile_image: auth.info.image,
          password: Devise.friendly_token(10)
        )

        user.update(line_id: auth.uid) if auth.provider == "line"
      else
        user.update(line_id: auth.uid) if auth.provider == "line" && user.line_id.blank?

      end
      { user: }
    end

    # Googleアカウントの情報をそれぞれの変数に格納して上記のメソッドに振り分ける処理
    def find_oauth(auth)
      uid = auth.uid
      provider = auth.provider
      snscredential = SnsCredential.where(uid:, provider:).first
      if snscredential.present?
        user = with_sns_data(auth, snscredential)[:user]
        sns = snscredential
      else
        data = without_sns_data(auth)
        user = data[:user]
        sns = data[:sns]
      end
      { user:, sns: }
    end

    def send_line_notifications
      current_time = Time.now.in_time_zone('Asia/Tokyo').strftime("%H:%M")
      users = User.where(reminder_time: current_time)  # 通知時刻と現在の時刻を比較

      users.each do |user|
        if user.reminder_time.present? && user.line_id.present?
          response = line_client.push_message(user.line_id, { type: 'text', text: "今日という日を漢字一文字で。以下のリンクから \nhttps://onekanjidiary.fly.dev/" })

          if response.code == "200"
            Rails.logger.info("Message sent successfully to #{user.name}")
          else
            Rails.logger.error("Failed to send message to #{user.name}: #{response.body}")
          end
        end
      end
    end


    def line_client
      @line_client ||= Line::Bot::Client.new do |config|
        config.channel_secret = ENV['LINE_CHANNEL_SECRET']
        config.channel_token = ENV['LINE_CHANNEL_TOKEN']
      end
    end
  end


  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, uniqueness: true
end
