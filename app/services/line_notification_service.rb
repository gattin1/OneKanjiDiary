# frozen_string_literal: true

# LINE通知に関するクラス
class LineNotificationService
  def self.send_notifications
    # ユーザーの中から通知を受け取る設定が有効になっているかチェックする
    users = User.where(reminder_enabled: true)

    # ユーザーがLINE通知を受信可能かチェックする
    users.each do |user|
      next unless user.can_receive_line_notification?

      response = line_client.push_message(user.line_id, message_payload)
      # 送信結果に応じてメッセージをログに送る
      if response.code == '200'
        Rails.logger.info("Message sent successfully to #{user.name}")
      else
        Rails.logger.error("Failed to send message to #{user.name}: #{response.body}")
      end
    end
  end

  # LINE APIクライアントを設定して返す
  def self.line_client
    @line_client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def self.message_payload
    {
      type: 'text',
      text: "今日という日を漢字一文字で。以下のリンクから \nhttps://onekanjidiary.com/"
    }
  end
end
