class AddBodyFieldsToEmail < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :html_part, :text
    add_column :emails, :text_part, :text
  end
end
