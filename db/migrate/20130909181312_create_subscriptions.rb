class CreateSubscriptions < ActiveRecord::Migration[4.2]
  def change
    create_table :subscriptions do |t|
      t.belongs_to :user, index: true
      t.belongs_to :list, index: true

      t.timestamps
    end
  end
end
