class CreateEmailLists < ActiveRecord::Migration[4.2]
  def change
    create_table :email_lists do |t|
      t.references :email, index: true
      t.references :list, index: true

      t.timestamps
    end
  end
end
