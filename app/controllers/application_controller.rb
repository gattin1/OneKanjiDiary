# frozen_string_literal: true

# ApplicationControllerは、全てのコントローラの基底クラスです。
# ここに共通の処理やフィルタを追加します。
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
