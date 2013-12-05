class AddNoOfRecipientsToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :recipients, :integer
  end
end
