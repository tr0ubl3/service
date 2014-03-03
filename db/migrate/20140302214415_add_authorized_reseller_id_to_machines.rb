class AddAuthorizedResellerIdToMachines < ActiveRecord::Migration
  def change
    add_column :machines, :authorized_reseller_id, :integer
  end
end
