class AddColumnToItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :items, :budget, null: true, foreign_key: true
  end
end
