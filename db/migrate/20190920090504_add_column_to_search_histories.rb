class AddColumnToSearchHistories < ActiveRecord::Migration[5.2]
  def change
    add_column :search_histories, :user_id, :integer
  end
end
