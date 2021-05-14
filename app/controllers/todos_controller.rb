class TodosController < ApplicationController
  include TodosHelper
  before_action :authenticate_user!

  def index
    @todos = current_user.todos
  end

  def search
    @todos = TodosHelper.search(params, current_user)
  end

  def new
    @todo = current_user.todos.build
  end

  def create
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      flash[:notice] = 'Todo created successfully.'
      redirect_to todos_path
    else
      flash[:alert] = 'Something went wrong.'
      render :new
    end
  end

  def show
    @todo = current_user.todos.find(params[:id])
  end

  def edit
    @todo = current_user.todos.find(params[:id])
  end

  def update
    @todo = current_user.todos.find(params[:id])
    if @todo.update todo_params
      flash[:notice] = 'Todo updated successfully.'
      redirect_to todo_path(@todo)
    else
      flash[:alert] = 'Something went wrong.'
      render :edit
    end
  end

  def destroy
    if current_user.todos.find(params[:id]).destroy
      flash[:notice] = 'Todo Deleted successfully.'
    else
      flash[:alert] = 'Something went wrong.'
    end
    redirect_to todos_path
  end

  def destroy_selected
    todos = current_user.todos.where(id: params[:todo_ids])
    todos.destroy_all
    redirect_to todos_path
  end

  private

  def todo_params
    params.require(:todo).permit(:name, :date, :is_done, :reminder,
                                 :reminder_date, :is_public, :user_id, :todo_attachment, categories: [])
  end
end
