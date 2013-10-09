class AddBodyFieldsToEmail < ActiveRecord::Migration
  def change
    add_column :emails, :html_part, :text
    add_column :emails, :text_part, :text
  end
end
