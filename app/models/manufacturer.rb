class Manufacturer < ActiveRecord::Base
  attr_accessible :name, :country, :city, :address, :postal_code, :fax, :office_tel, :office_mail, :mobile
  has_many :machines
end
