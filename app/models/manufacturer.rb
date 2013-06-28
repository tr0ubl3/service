class Manufacturer < ActiveRecord::Base
  attr_accessible :name, :address, :office_tel, :office_mail
  has_many :machines
end
