FactoryGirl.define do
	factory :authorized_reseller do
		id 1
		name "International G&T"
		address "Str. Test, No 1"
		office_tel "01234567891"
		office_mail "office@test.com"
		country "Test"
		city "Test"
		postal_code "123456"
		fax "1234567890"
		mobile "1234567890"
		type "AuthorizedReseller"
	end
end