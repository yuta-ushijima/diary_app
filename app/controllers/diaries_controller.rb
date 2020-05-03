class DiariesController < ApplicationController
  before_action :login_required

  def index
    @diaries = current_user.diaries
  end

  def show
    @diary = current_user.diaries.find(params[:id])
  end

  def new
    @diary = Diary.new
  end

  def create
    @diary = current_user.diaries.new(diary_params)

    if @diary.save
      redirect_to root_path, notice: "日記「#{@diary.title}」を登録しました。"
    else
      render :new
    end
  end

  def edit
    @diary = current_user.diaries.find(params[:id])
  end

  def update
    diary = Diary.find(params[:id])
    diary.update!(diary_params)
    redirect_to root_path, notice: "日記「#{diary.title}」を編集しました。"
  end

  def destroy
    diary = Diary.find(params[:id])
    diary.destroy
    redirect_to root_path, notice: "日記「#{diary.title}」を削除しました。"
  end

  private

  def diary_params
    params.require(:diary).permit(:title, :description)
  end

  def login_required
    redirect_to login_path unless current_user
  end

end
