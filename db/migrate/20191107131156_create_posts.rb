class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :name
      t.datetime :dateofbirth
      t.string :current_user_email
      t.string :sex
      
      t.timestamps
    end
  end
end
