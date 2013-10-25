class AddMailIdToEmails < ActiveRecord::Migration
  def change
    add_column :emails, :mail_id, :string
  end
end
