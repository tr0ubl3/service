class MachineOwner < Firm
  attr_accessible :name, :country, :city, :address, :postal_code, :fax, :office_tel, :office_mail, :mobile
  has_many :machines
  has_many :users
  #validarile sunt preluate din firm
end

