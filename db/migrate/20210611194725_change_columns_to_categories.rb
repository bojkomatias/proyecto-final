class ChangeColumnsToCategories < ActiveRecord::Migration[6.1]
  def change
    change_column_null :categories, :category_id, true
  end
end
