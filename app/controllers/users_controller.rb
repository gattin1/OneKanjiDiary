# frozen_string_literal: true

# 通知機能に関するクラス
class UsersController < ApplicationController
  before_action :authenticate_user!

  def reminder_settings
    @user = current_user
  end

  def update_reminder_time
    @user = current_user
    if @user.update(user_params)
      message = @user.reminder_enabled ? '通知がオンになりました' : '通知がオフになりました'
      redirect_to user_diaries_path(current_user), notice: message
    else
      render :reminder_settings
    end
  end

  private

  def user_params
    params.require(:user).permit(:reminder_time, :reminder_enabled)
  end
end
