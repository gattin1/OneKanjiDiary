class DiariesController < ApplicationController
  before_action :authenticate_user!
  def index
  end

  def show
  end

  def new
    @diary = current_user.diaries.build
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to user_diaries_path(current_user), notice: '日記が作成されました。'
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def diary_params
    params.require(:diary).permit(:content, :memo, :date)
  end
end
