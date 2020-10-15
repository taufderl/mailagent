class AddNoOfRecipientsToEmail < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :recipients, :integer
  end
end
