class CreateDiscussions < ActiveRecord::Migration[7.0]
  def change
    create_table :discussions do |t|
      t.string :name
      t.references :user, null: false, foreign_key: true
      t.boolean :opened , default: false
      t.boolean :closed , default: false
      

      t.timestamps
    end
  end
end
