class TasksController < ApplicationController
  def index
    @tasks = Task.all.page(params[:page])
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = "Taskが正常に保存されました"
      redirect_to @task
    else
      flash.now[:danger] = "Taskが正常に保存されませんでした"
      render :new
    end
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success] = "変更に成功しました"
      redirect_to @task
    else
      flash.now[:danger] = "変更に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = "削除に成功しました"
    
    redirect_to root_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end