class AddMailIdToEmails < ActiveRecord::Migration[4.2]
  def change
    add_column :emails, :mail_id, :string
  end
end
