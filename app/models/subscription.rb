class Subscription < ActiveRecord::Base
  belongs_to :user
  belongs_to :list
  
  #validates_presence_of :user
  validates_presence_of :list
  validates_uniqueness_of :list_id, :scope => :user_id
  
end
