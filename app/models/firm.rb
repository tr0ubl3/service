class Firm < ActiveRecord::Base
  attr_accessible :name, :country, :city, :address, :postal_code,
                  :fax, :office_tel, :office_mail, :mobile, :type
  
  has_many :users

  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  NUMBERS = /[0-9]/i
  NAME = /[a-z0-9]/i

  # class nodbspaces < ActiveModel::Validator
  #   def validate(record)
  #     if record.length == nil
  #       elseif record.presence = true
  #       elseif record = ''    
  #     end
  #   end
  # end

  validates :name, :presence => true,
  				   :length => { :within => 3..255, message: 'missing required length' },
             :format => { with: NAME, message: 'must be formated correctly' },
             :uniqueness => true

  validates :country, :presence => true,
  				      :length => { :within => 3..255, message: 'missing required length' }

  validates :city, :presence => true,
  				      :length => { :within => 3..255, message: 'missing required length' }

  validates :address, :presence => true,
  				      :length => { :within => 3..255, message: 'missing required length' }

  validates :postal_code, :presence => true,
  				      :length => { :within => 3..255, message: 'missing required length' }

  validates :office_tel, :presence => true,
  				      :length => { :within => 3..255, message: 'missing required length' }

  validates :fax, :length => { :within => 3..255,
                               message: 'length must be: 255 >= string > 3' },
                  format: { with: NUMBERS, 
                            message: 'manufacturer should contain only numbers' }, 
                  allow_blank: true

  # def verifyfax
  #   if :fax == nil
  #     validates :fax, :presence => false
  #   else
  #     validates :fax, :presence => true
  #   end
  # end

  validates :office_mail, :presence => true,
  				          :length => { :within => 3..255, message: '255 >= length > 3' },
  				          :format => { with: EMAIL_REGEX, 
                                 message: 'must be formated correctly'},
                    :uniqueness => true            

  validates :mobile, :length => { :within => 4..20, message: 'missing required length' },
                     :format => { with: NUMBERS,
                                  message: 'not correct format' },
                     allow_blank: true
  def machines_structure
    machines = self.machines
    machine_groups = self.machines.collect(&:machine_group).uniq
    structure = Hash.new
    manufacturers = machine_groups.collect(&:manufacturer).uniq
    
    manufacturers.each do |manufacturer|
      structure[manufacturer.name] = { }
      filtered_machines = machines.joins(:machine_group).merge MachineGroup.where(:manufacturer_id => manufacturer.id)
      machine_groups = filtered_machines.collect(&:machine_group).uniq
      machine_groups.each do |group|
        structure[manufacturer.name][group.machining_type] = { }
        filtered_machines = machines.joins(:machine_group).merge MachineGroup.where(:machining_type => group.machining_type)
        group_machine_types = filtered_machines.collect(&:machine_group).collect(&:machine_type).uniq
        group_machine_types.each do |type|
          structure[manufacturer.name][group.machining_type][type] = { }
          rafined_machines = filtered_machines.joins(:machine_group).merge MachineGroup.where(:machine_type => type)
          machine_versions = rafined_machines.collect(&:machine_group).collect(&:version).uniq
          machine_versions.each do |version|
            final_rafination = rafined_machines.joins(:machine_group).merge MachineGroup.where(:version => version)
            structure[manufacturer.name][group.machining_type][type][version] = final_rafination
          end
        end
      end
    end

    return structure
  end
end