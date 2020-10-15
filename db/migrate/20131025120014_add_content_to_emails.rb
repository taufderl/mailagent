class AddContentToEmails < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :content, :text
  end
end
