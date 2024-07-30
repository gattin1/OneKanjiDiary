class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  def index
  end

  def show;end

  def new
    @diary = current_user.diaries.build
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to user_diaries_path(current_user, @diary), notice: '日記が作成されました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit;end

  def update
    if @diary.update(diary_params)
      redirect_to user_diary_path(current_user, @diary), notice: '日記が更新されました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary.destroy
    redirect_to user_diaries_path(current_user), notice: '日記が削除されました。'
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:content, :memo, :date)
  end
end
