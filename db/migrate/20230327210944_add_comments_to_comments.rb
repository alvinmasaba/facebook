class AddCommentsToComments < ActiveRecord::Migration[7.0]
  def change
    change_table :comments do |t|
      t.belongs_to  :parent_comment, null: true
    end
  end
end
