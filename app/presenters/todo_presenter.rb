class TodoPresenter
  def initialize(todo)
    @todo = todo
  end

  def todo_category
  	if @todo.categories.present?
  		return @todo.categories.map(&:titleize).join(",")
  	end
  end
end