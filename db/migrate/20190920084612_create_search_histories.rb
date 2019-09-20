class CreateSearchHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :search_histories do |t|

      t.string :history
      t.timestamps
    end
  end
end
