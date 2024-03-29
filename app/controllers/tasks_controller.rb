class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ index new create]

  def index
    @tasks = Task.joins(:user).select('tasks.*').where(users: { id: @user.id })
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = @user
    if @task.save
      redirect_to tasks_path, notice: t('.created')
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('.updated')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('.destroyed')
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :content)
    end

    def set_user
      @user = current_user
    end
end
