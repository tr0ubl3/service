FactoryGirl.define do
	factory :authorized_reseller do
		sequence :id do |n|
	    	"30#{n}"
	    end
		sequence :name do |n|
	    	"INTGT_#{n}"
	    end
		address "Str. Test, No 1"
		office_tel "01234567891"
		sequence :office_mail do |n|
			"office30#{n}@test.com"
		end
		country "Test"
		city "Test"
		postal_code "123456"
		fax "1234567890"
		mobile "1234567890"
		type "AuthorizedReseller"

		factory :authorized_reseller_with_machines do
			ignore do
				machines_count 5
			end

			after(:create) do |authorized_reseller, evaluator|
				create_list(:machine, evaluator.machines_count, authorized_reseller: authorized_reseller)
			end
		end
	end
end