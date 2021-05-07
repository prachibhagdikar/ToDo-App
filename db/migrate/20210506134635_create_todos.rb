class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.string :date
      t.boolean :is_done
      t.boolean :reminder
      t.string :reminder_date
      t.boolean :is_public
      t.integer :user_id
      t.string :categories, array: true, default: []
      t.string :todo_attachment

      t.timestamps null: false
    end
  end
end
