class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.string :description, null: false
      t.integer :rating, null: false
      t.integer :user_id, null: false
      t.integer :actor_id, null: false
    end
  end
end
