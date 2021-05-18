class AddDefaultValueToIsDone < ActiveRecord::Migration
  def up
    change_column_default :todos, :is_done, false
    change_column_default :todos, :is_public, false
	end

	def down
	  change_column_default :todos, :is_done, nil
	  change_column_default :todos, :is_public, nil
	end
end
