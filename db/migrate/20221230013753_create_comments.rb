class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text  :body
      t.integer :commenter_id
      t.belongs_to :post
      
      t.timestamps
    end
  end
end
