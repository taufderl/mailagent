class User < ActiveRecord::Base
  has_secure_password
  
  has_many :subscriptions, dependent: :destroy
  has_many :lists, :through => :subscriptions
  
  validates :first_name, :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  
  ROLES = ['admin', 'listener']
  
  #TODO: delete first_name and use only name 
  
  def roles
    ROLES
  end
  
  def admin?
    role == 'admin'
  end
  
end
