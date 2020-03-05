class CreatePostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :post_comments do |t|
      t.integer :user_id
      t.text :body
      t.boolean :dispose, default:false
      t.boolean :best_answer, default:false

      t.timestamps
    end
  end
end
