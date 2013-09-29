class EmailList < ActiveRecord::Base
  belongs_to :email
  belongs_to :list
end
