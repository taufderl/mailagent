class RemoveContentFromEmails < ActiveRecord::Migration
  def change
    remove_column :emails, :content, :string
  end
end
