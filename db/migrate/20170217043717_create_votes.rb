class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.boolean :rating, null: false
      t.integer :user_id, null: false
      t.integer :review_id, null: false
    end
  end
end
