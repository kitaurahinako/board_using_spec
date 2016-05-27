class MyThreadsController < ApplicationController

  before_action :set_my_thread, only: [:show, :edit, :update, :destroy]

  def index
    @my_threads = MyThread.all
  end

  def show
    @my_comments = @my_thread.my_comments
    @my_comment = MyComment.new
  end

  def new
    @my_thread = MyThread.new
  end

  def edit
    if @my_thread.user_id == current_user.id
       @my_thread.destroy
    end
  end

  def create
    @my_thread = MyThread.new(my_thread_params)
    @my_thread.user_id = current_user.id
    if @my_thread.save
      redirect_to my_threads_path
    else
      render 'new'
    end
  end

  def update
    if @my_thread.update(my_thread_params)
      redirect_to my_threads_path
    else
      render 'edit'
    end
  end

  def destroy
    if @my_thread.user_id == current_user.id
       @my_thread.destroy
    end
    redirect_to my_threads_path
  end

  private

    def set_my_thread
      @my_thread = MyThread.find(params[:id])
    end

    def my_thread_params
      params.require(:my_thread).permit(:title, :overview, :user_id)
    end

end
