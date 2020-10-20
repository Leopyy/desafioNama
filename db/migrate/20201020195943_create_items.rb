class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :buyer
      t.string :description
      t.float :price
      t.float :quantity
      t.string :adress
      t.string :supplyer
      t.references :report, foreign_key: true

      t.timestamps
    end
  end
end
