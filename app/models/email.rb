class Email < ActiveRecord::Base
  belongs_to :user
  has_many :email_lists, :dependent => :destroy
  has_many :lists, :through => :email_lists
  
  def content_cutted
    "#{content[0..30]}..." if content 
  end
  
end
