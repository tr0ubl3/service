# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
firms = Firm.create([
	{
		#manufacturer
		name: "Posalux"
		address: "Str. Test, No. 1"
		office_tel: "0123456789"
		office_mail: "office@posalux.com"
		country: "Swiss"
		city: "Biel"
		postal_code: "123123"
		fax: "123123123"
		mobile: "01234567891"
		type: "Manufacturer"
	},

	{
		#machine_owner
		name: "Delphi"
		address: "Str. Bratuleni, Nr. 1"
		office_tel: "0123456789"
		office_mail: "office@delphi.com"
		country: "Romania"
		city: "Iasi"
		postal_code: "700123"
		fax: "123123123"
		mobile: "01234567891"
		type: "MachineOwner"
	}
	])