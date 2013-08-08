class Firm < ActiveRecord::Base
  attr_accessible :name, :country, :city, :address, :postal_code, :fax, :office_tel, :office_mail, :mobile, :type
  has_many :machines
  validates :name, :presence => true,
  				   :length => { :within => 3..255 },
  				   :uniqueness => true

  validates :country, :presence => true,
  				      :length => { :within => 3..255 }

  validates :city, :presence => true,
  				      :length => { :within => 3..255 }

  validates :address, :presence => true,
  				      :length => { :within => 3..255 }

  validates :postal_code, :presence => true,
  				      :length => { :within => 3..255 }

  validates :office_tel, :presence => true,
  				      :length => { :within => 3..255 }

  validates :fax, :length => { :within => 3..255 }

  validates :office_mail, :presence => true,
  				          :length => { :within => 3..255 }
  validates :mobile, :length => { :within => 8..255 }
end
