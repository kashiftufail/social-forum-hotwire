class CreateForumDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :forum_discussions do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :archived , default: false
      t.boolean :closed , default: false
        
      t.timestamps
    end
  end
end
