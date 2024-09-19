class UsersController < ApplicationController
  before_action :authenticate_user!

  def reminder_settings
    @user = current_user
  end

  def update_reminder_time
    @user = current_user

    # 通知を無効化する
    if params[:user][:disable_reminder] == "1"
      if @user.update(reminder_time: nil)
        return redirect_to user_diaries_path(current_user), notice: "通知が無効化されました"
      else
        return render :reminder_settings
      end
    end

      # 通知時間を更新する
    if @user.update(user_params)
      redirect_to user_diaries_path(current_user), notice: "通知時間が更新されました"
    else
      render :reminder_settings
    end
  end

  private

  def user_params
    params.require(:user).permit(:reminder_time)
  end
end
