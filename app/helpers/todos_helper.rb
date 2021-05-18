module TodosHelper
  def self.search(params, current_user)
  	todos = current_user.todos

  	if params[:from_date].present? && !params[:to_date].present?
  		todos = todos.where("date >=?", params[:from_date])
  	elsif !params[:from_date].present? && params[:to_date].present?
  		todos = todos.where("date <=?", params[:to_date])
  	elsif params[:from_date].present? && params[:to_date].present?
  		todos = todos.between_dates(params[:from_date], params[:to_date])
  	end
  	if params[:categories].present?
  		ids = []
     	todos.each {|a| ids << a.id if !(a.categories & params[:categories]).empty? }
     	todos = todos.where(id: ids.uniq)
  	end
  	if params[:completed].present?
  		todos = todos.completed
  	end
  	if params[:pending].present?
  		todos = todos.pending
  	end
  	return todos
  end
end
