class User < ActiveRecord::Base
  has_secure_password validations: false
  
  has_many :subscriptions, dependent: :destroy
  has_many :lists, :through => :subscriptions
  
  validates :first_name, :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}
  validates_format_of :email, :with => /@/
  validates :password,
      :length => { :minimum => 8, :if => :validate_password? },
      :confirmation => { :if => :validate_password? }
      
  after_initialize :init
  
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
  
  private
  
  def init
    self.role ||= 'listener'
  end
  
  def validate_password?
    password.present? || password_confirmation.present?
  end

end
