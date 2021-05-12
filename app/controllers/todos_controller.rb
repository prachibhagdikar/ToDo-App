class TodosController < ApplicationController
  before_action :authenticate_user!

  def index
    @todos = current_user.todos
  end

  def search
    @todos = case params[:search_category]
             when 'Datewise'
               current_user.todos.where('date between ? and ?', params[:from_date], params[:to_date])
             when 'Categories'
               current_user.todos.where('categories = ?', params[:categories].to_yaml)
             when 'Completed'
               current_user.todos.where(is_done: true)
             else
               current_user.todos.where('date > ?', Date.today)
             end
  end

  def new
    @todo = current_user.todos.build
  end

  def create
  	@todo = Todo.new(todo_params)
  	@todo.user_id = current_user.id
    if @todo.save
      flash[:notice] = 'Todo created successfully.'
      redirect_to todos_path
    else
      flash[:alert] = 'Something went wrong.'
      render :new
    end
  end

  def show
    @todo = Todo.find(params[:id])
  end

  def edit
    @todo = Todo.find(params[:id])
  end

  def update
    @todo = Todo.find(params[:id])
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
