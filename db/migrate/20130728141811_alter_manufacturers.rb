class AlterManufacturers < ActiveRecord::Migration
  def up
  	add_column("manufacturers", "country", :string)
  	add_column("manufacturers", "city", :string)
  	add_column("manufacturers", "postal_code", :string)
  	add_column("manufacturers", "fax", :string)
  	add_column("manufacturers", "mobile", :string)
  end

  def down
  	remove_column("manufacturers", "country")
  	remove_column("manufacturers", "city")
  	remove_column("manufacturers", "postal_code")
  	remove_column("manufacturers", "fax")
  	remove_column("manufacturers", "mobile")
  end
end
