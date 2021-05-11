class TodoPresenter
  def initialize(todo)
    @todo = todo
  end

  def todo_category
    return @todo.categories.map(&:titleize).join(',') if @todo.categories.present?
  end
end
