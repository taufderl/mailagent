class RemoveContentAgainFromEmails < ActiveRecord::Migration[4.2]
  def change
    remove_column :emails, :content, :string
  end
end
