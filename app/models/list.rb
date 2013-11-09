class List < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, :through => :subscriptions
  has_many :email_lists, dependent: :destroy
  has_many :emails, :through => :email_lists
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  
  def to_s
    name
  end
  
  def number_of_users
    users.count
  end
  
  def number_of_emails
    emails.count
  end
  
end
