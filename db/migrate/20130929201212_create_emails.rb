class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.references :user, index: true
      t.string :subject
      t.text :content

      t.timestamps
    end
  end
end
