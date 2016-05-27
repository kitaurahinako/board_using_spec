class CreateMyComments < ActiveRecord::Migration
  def change
    create_table :my_comments do |t|
      t.integer :user_id
      t.text :content
      t.integer :my_thread_id

      t.timestamps null: false
    end
  end
end
