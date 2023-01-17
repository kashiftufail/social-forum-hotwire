class CreateSubscriptions < ActiveRecord::Migration[7.0]
  def change
    create_table :subscriptions do |t|
      t.string :subscription_type
      t.references :user, null: false, foreign_key: true
      t.references :discussion, null: false, foreign_key: true

      t.timestamps
    end
  end
end
