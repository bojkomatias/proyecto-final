class CreateItems < ActiveRecord::Migration[6.1]
  def change

    create_table :items do |t|
      t.string :name
      t.string :description
      t.float :amount
      t.references :category, null: false, foreign_key: true
      t.references :transfer, null: true, foreign_key: true

      t.timestamps
    end
  end
end
