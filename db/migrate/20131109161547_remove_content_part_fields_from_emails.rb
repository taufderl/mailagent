class RemoveContentPartFieldsFromEmails < ActiveRecord::Migration[4.2]
  def change
    remove_column :emails, :html_part, :text
    remove_column :emails, :text_part, :text
  end
end
