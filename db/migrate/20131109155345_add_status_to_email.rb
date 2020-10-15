class AddStatusToEmail < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :status, :string
  end
end
