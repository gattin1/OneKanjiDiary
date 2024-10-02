# frozen_string_literal: true

# DiariesControllerは、日記に関する操作を管理するコントローラです。
# 日記の作成、表示、編集、削除などのアクションを提供します。
class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_diary, only: %i[show edit update destroy]
  helper_method :prepare_meta_tags

  def index
    @start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    end_date = @start_date.end_of_month
    # 現在の月、前月、来月の日記を取得する
    @diaries = current_user.diaries.where(date: @start_date.prev_month.beginning_of_month..end_date.next_month.end_of_month).order(date: :asc)
    @todays_diary = current_user.diaries.find_by(date: Date.today)
    @closest_diary = @todays_diary || current_user.diaries.where('date < ?', Date.today).order(date: :desc).first
  end


  def show
    prepare_meta_tags(@diary)
  end

  def new
    date = params[:date] ? Date.parse(params[:date]) : Date.today
    @diary = current_user.diaries.build(date: date)
  end

  def create
    @diary = current_user.diaries.build(diary_params)
    if @diary.save
      redirect_to user_diaries_path(current_user, month: @diary.date.month, year: @diary.date.year), notice: t('.success')
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

  def mood_statistics
    start_date = params[:start_date] ? Date.parse(params[:start_date]) : Date.today.beginning_of_month
    desired_order = ["嬉しい", "幸せ", "怒り", "哀しみ", "無"]
    @mood_data = Diary.mood_statistics_for_month(start_date)
    @mood_colors = Mood.colors_by_name
    @month_name = start_date.strftime("%-m月")
    @mood_data = @mood_data.sort_by { |mood, _| desired_order.index(mood) || desired_order.length }.to_h
  end



  private

  def set_diary
    @diary = current_user.diaries.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:title, :memo, :date, :mood_id)
  end

  def prepare_meta_tags(diary)
    image_url = "#{request.base_url}/images/ogp.png?text=#{CGI.escape(diary.title)}"
    meta_tags = {
      site: '一文字日記',
      title: diary.title,
      description: '今日の日記',
      type: 'website',
      url: request.original_url,
      image: image_url,
      locale: 'ja-JP'
    }

    set_meta_tags og: meta_tags, twitter: meta_tags.merge(card: 'summary_large_image')
  end

end
