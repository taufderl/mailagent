class AddFirstNameToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :first_name, :string
  end
end
