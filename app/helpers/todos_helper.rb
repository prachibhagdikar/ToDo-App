module TodosHelper
  def self.search(params, current_user)
    case params[:search_category]
    when 'Datewise'
      current_user.todos.between_dates(params[:from_date], params[:to_date])
    when 'Categories'
      current_user.todos.where('categories = ?', params[:categories].to_yaml)
    when 'Completed'
      current_user.todos.completed
    else
      current_user.todos.pending
    end
  end
end
