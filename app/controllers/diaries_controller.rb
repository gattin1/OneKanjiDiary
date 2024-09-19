# frozen_string_literal: true

# DiariesControllerは、日記に関する操作を管理するコントローラです。
# 日記の作成、表示、編集、削除などのアクションを提供します。
class DiariesController < ApplicationController
  before_action :!
  before_action :set_diary, only: %i[show edit update destroy]

  def index
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month

    @diaries = current_user.diaries.where(date: start_date..start_date.end_of_month).order(date: :asc)
    @start_date = start_date
  end

  def show; end

  def new
    @diary = current_user.diaries.build(date: Date.today)
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to user_diaries_path(current_user), notice: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @diary.update(diary_params)
      redirect_to user_diary_path(current_user, @diary), notice: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @diary.destroy
    redirect_to user_diaries_path(current_user), notice: t('.success')
  end

  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :memo, :date, :mood_id)
  end
end
