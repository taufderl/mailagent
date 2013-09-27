class List < ActiveRecord::Base
  has_many :subscriptions, dependent: :destroy
  has_many :users, :through => :subscriptions
  
  validates :name, presence: true, uniqueness: {case_sensitive: false}
  
  def to_s
    name
  end
end
