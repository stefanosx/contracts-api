class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  validates_presence_of :full_name, message: "should not be empty"
  validates_presence_of :email, message: "should not be empty"
  validates_uniqueness_of :email, message: "is already taken"
  validates_presence_of :password, message: "should not be empty"

  has_many :contracts
end
