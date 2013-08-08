class Manufacturer < Firm
  attr_accessible :name, :country, :city, :address, :postal_code, :fax, :office_tel, :office_mail, :mobile
  has_many :machines
  # validates_presence_of :name
  # validates_length_of :name, :within => 3..255
  # validates_uniqueness_of :name
end
