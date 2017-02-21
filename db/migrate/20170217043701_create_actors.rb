class CreateActors < ActiveRecord::Migration[5.0]
  def change
    create_table :actors do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :description
      t.string :movie
      t.string :book_title
      t.integer :year
      t.integer :user_id, null: false
    end
  end
end
