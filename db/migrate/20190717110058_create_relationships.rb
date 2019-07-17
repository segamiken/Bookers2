class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|

      t.timestamps
      t.integer :following_id
      t.integer :follower_id
    end
  end
end
