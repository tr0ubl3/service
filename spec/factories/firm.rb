FactoryGirl.define do
	factory :firm do
		id 1
		name "Test"
		address "Str. Test, No 1"
		office_tel "01234567891"
		office_mail "office@test.com"
		country "Test"
		city "Test"
		postal_code "0079"
		fax "0123456789"
		mobile "0123456789"
		type "Manufacturer"
	end
end