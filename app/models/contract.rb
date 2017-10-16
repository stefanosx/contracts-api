class Contract < ApplicationRecord
  belongs_to :user

  include ActiveModel::Validations
  validates_with ContractValidator
  validates_presence_of :vendor, message: "should not be empty"
  validates_presence_of :starts_on, message: "should not be empty"
  validates_presence_of :ends_on, message: "should not be empty"
end
