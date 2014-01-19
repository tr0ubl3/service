FactoryGirl.define do
	factory :user do
		first_name "Bud"
		last_name "Spencer"
		email "bud.spencer@mail.com"
		phone_number 0740123123
		admin false
		machine_owner_id 1
		password_digest "$2a$10$uYvJ7AaOeDJkNkyKavHaj.wE5GYK93z11W24RQj0rPHoNws3mbMlC"
	end

	factory :admin, class: User do
		first_name "Jon"
		last_name "Snow"
		email "john.snow@mail.com"
		phone_number 0740223223
		admin true
		machine_owner_id 1
		password_digest "$2a$10$uYvJ7AaOeDJkNkyKavHaj.wE5GYK93z11W24RQj0rPHoNws3mbMlC"
	end

	factory :admin_2, class: User do
		first_name "Edard"
		last_name "Stark"
		email "edard.stark@mail.com"
		phone_number 0740323323
		admin true
		machine_owner_id 1
		password_digest "$2a$10$uYvJ7AaOeDJkNkyKavHaj.wE5GYK93z11W24RQj0rPHoNws3mbMlC"
	end
end