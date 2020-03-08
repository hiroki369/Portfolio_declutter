class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :best_answer_count, :integer, default: 0
  end
end
