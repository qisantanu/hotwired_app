class Developer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :company_name
end
