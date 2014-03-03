FactoryGirl.define do
	factory :user do
		first_name "Bud"
		last_name "Spencer"
		email "bud.spencer@mail.com"
		phone_number 0740123123
		admin false
		firm_id 1
		password 'securepassword'
		login_count 0
		approved_at Time.now.to_date.to_time
		auth_token nil
		confirmed true
		password_reset_token "KEL8tw01cIvD9pLmJ7BA_1"
		password_reset_sent_at Time.now
		association :firm, factory: :machine_owner
	end

	factory :user2, class: User do
		first_name "Daenarys"
		last_name "Targaryen"
		email "daenarys.targaryen@mail.com"
		phone_number 0740123124
		admin false
		firm_id 1
		password 'securepassword'
		login_count 0
		auth_token nil
		confirmed false
		password_reset_token "KEL8tw01cIvD9pLmJ7BA_2"
		password_reset_sent_at Time.now
		association :firm, factory: :manufacturer_with_machines
	end

	factory :admin, class: User do
		first_name "Jon"
		last_name "Snow"
		email "jon.snow@mail.com"
		phone_number 0740223223
		admin true
		firm_id 301
		password "securepassword"
		approved_at Time.now
		auth_token nil
		confirmed true
		password_reset_token "KEL8tw01cIvD9pLmJ7BA_3"
		password_reset_sent_at Time.now
		association :firm, factory: :authorized_reseller
	end

	factory :admin_2, class: User do
		first_name "Edard"
		last_name "Stark"
		email "edard.stark@mail.com"
		phone_number 0740323323
		admin true
		firm_id 301
		password "securepassword"
		approved_at Time.now
		auth_token nil
		confirmed true
		password_reset_token "KEL8tw01cIvD9pLmJ7BA_4"
		password_reset_sent_at Time.now
		association :firm, factory: :authorized_reseller_with_machines
	end
end