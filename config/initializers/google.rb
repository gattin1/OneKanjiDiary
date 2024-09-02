google_client_id = Rails.application.credentials.google[:google_client_id] || ENV['GOOGLE_CLIENT_ID']
google_client_secret = Rails.application.credentials.google[:google_client_secret] || ENV['GOOGLE_CLIENT_SECRET']
# 認証の設定やAPIクライアントの初期化を行う
