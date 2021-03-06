class Manufacturer < Firm
  attr_accessible :name, :country, :city, :address, :postal_code,
  				  :fax, :office_tel, :office_mail, :mobile
  has_many :machine_groups, dependent: :destroy
  has_many :machines, through: :machine_groups

  # validarile sunt preluate din firm
  # validates_presence_of :name
  # validates_length_of :name, :within => 3..255
  # validates_uniqueness_of :name
end
