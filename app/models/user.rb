class User < ActiveRecord::Base
  has_secure_password
  
  has_many :subscriptions, dependent: :destroy
  has_many :lists, :through => :subscriptions
  
  validates :first_name, :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  
  ROLES = ['admin', 'listener']
  
  def full_name
    "#{first_name} #{name}"
  end
  
  def name_with_email
    "#{full_name} <#{email}>"
  end 
  
  def name_with_initial
    "#{first_name.first}. #{name}"
  end 
  
  def self.roles
    ROLES
  end
  
  def admin?
    role == 'admin'
  end
  
end
