class Machine < ActiveRecord::Base
  attr_accessible :machine_owner_id, :machine_number, :delivery_date,
                  :waranty_period, :display_name, :machine_group_id,
                  :machine_manufacturer_id
  
  belongs_to :machine_group
  has_one :manufacturer, through: :machine_group
  belongs_to :machine_owner
  belongs_to :authorized_reseller
  has_many :service_events, dependent: :destroy
  has_one :hour_counter, dependent: :destroy

  before_create :set_reseller
  
  validates :display_name, :presence => true,
    				   :length => { :within => 3..255 },
    				   :uniqueness => true
  validates :machine_number, :presence => true,
    				      :length => { :within => 3..255 },
    				      :uniqueness => true

  # validates :machine_type, :presence => true,
  # 				      :length => { :within => 3..255 }

  validates :delivery_date, :presence => true,
  				      :length => { :within => 3..255 }

  validates :waranty_period, :presence => true,
  				      :length => { :within => 3..255 }
  

  def waranty_boolean
    delivery_date + waranty_period.days > DateTime.now ? 'yes' : 'no'
  end

  def waranty_date
    delivery_date + waranty_period.days
  end


  private

  def set_reseller
    self.authorized_reseller_id = AuthorizedReseller.first.id
  end
end
