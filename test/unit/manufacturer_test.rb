require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase

## name validation

	test "a manufacturer should have a name" do
		manufacturer = Manufacturer.new
		manufacturer.name = ''
		assert !manufacturer.save
		assert !manufacturer.errors[:name].empty?, "must not be empty"		
	end

	test "a manufacturer name should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.name = "ab"
		assert !manufacturer.save
		assert !manufacturer.errors[:name].empty?
		assert manufacturer.errors[:name].include?("missing required length")
	end

	test "a manufacturer should have a valid format" do
		manufacturer = Manufacturer.new
		manufacturer.name = '%%%%%'
		assert !manufacturer.save
		assert !manufacturer.errors[:name].empty?
		assert manufacturer.errors[:name].include?('must be formated correctly')
	end

	test "a manufacturer name should be unique" do
		manufacturer = Manufacturer.new
		manufacturer.name = firms(:posalux).name
		assert !manufacturer.save
		# puts manufacturer.name
		# puts manufacturer.errors[:name]
		assert !manufacturer.errors[:name].empty?, "it's not unique"
	end

## country validation

	test "a manufacturer should have a country" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:country].empty?, "must not be empty"
	end

	test "a manufacturer country should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.country = "ab"
		assert !manufacturer.save
		assert !manufacturer.errors[:country].empty?
		assert manufacturer.errors[:country].include?("missing required length")
	end

## city validation

	test "a manufacturer should have a city" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:city].empty?, "must not be empty"
	end

	test "a manufacturer city should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.city = 'bi'
		assert !manufacturer.save
		assert !manufacturer.errors[:city].empty?
		assert manufacturer.errors[:city].include?("missing required length")
	end

## address validation

	test "a manufacturer should have an address" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:address].empty?, "must not be empty"
	end

	test "a manufacturer address should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.address = "st"
		assert !manufacturer.save
		assert !manufacturer.errors[:address].empty?
		assert manufacturer.errors[:address].include?("missing required length")
	end

## postal code validation

	test "a manufacturer should have an postal code" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:postal_code].empty?, "must not be empty"
	end

	test "a manufacturer postal_code should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.postal_code = "12"
		assert !manufacturer.save
		assert !manufacturer.errors[:postal_code].empty?
		assert manufacturer.errors[:postal_code].include?("missing required length")		
	end

## office telephone validation
	test "a manufacturer should have an office telephone" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:office_tel].empty?, "must not be empty"
	end

	test "a manufacturer office_tel should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.office_tel = "12"
		assert !manufacturer.save
		assert !manufacturer.errors[:office_tel].empty?
		assert manufacturer.errors[:office_tel].include?("missing required length")		
	end

## manufacturer fax validations
	
	test "a manufacturer office_fax should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.fax = "12"
		assert !manufacturer.save
		# puts manufacturer.errors[:fax]
		# must have more than 3 characters
		assert !manufacturer.errors[:fax].empty?
		assert manufacturer.errors[:fax].include?("length must be: 255 >= string > 3")
	end

	test "a manufacturer office fax should contain only number" do
		manufacturer = Manufacturer.new
		manufacturer.fax = "aaaa"
		assert !manufacturer.save
		assert !manufacturer.errors[:fax].empty?
		assert manufacturer.errors[:fax].include?("manufacturer should contain only numbers")
	end

	test "a manufacturer office fax should permit empty string" do
		manufacturer = Manufacturer.new
		manufacturer.fax = ""
		assert !manufacturer.save
		puts manufacturer.errors[:fax]
		assert manufacturer.errors[:fax].empty?
		# assert !Manufacturer.create(fax: "").valid?, "should permit empty string"
		# assert !Manufacturer.create(fax: nil).valid?, "should permit nil value"
	end

## manufacturer mail validations
	
	test "a manufacturer should have an office_mail" do
		manufacturer = Manufacturer.new
		manufacturer.office_mail = ""
		assert !manufacturer.save
		assert !manufacturer.errors[:office_mail].empty?, "must not be empty"
	end

	test "a manufacturer office_mail should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.office_mail = "aa"
		assert !manufacturer.save
		assert !manufacturer.errors[:office_mail].empty?
		assert manufacturer.errors[:office_mail].include?("255 >= length > 3")
	end

	test "a manufacturer office_mail should have a format like: mail@server.com" do
		manufacturer = Manufacturer.new
		manufacturer.office_mail = "wqhd"
		assert !manufacturer.save
		assert !manufacturer.errors[:office_mail].empty?
		assert manufacturer.errors[:office_mail].include?("must be formated correctly")
	end

	test "a manufacturer office mail should be unique" do
		manufacturer = Manufacturer.new
		manufacturer.office_mail = firms(:posalux).office_mail
		assert !manufacturer.save
		assert !manufacturer.errors[:office_mail].empty?, "it's not unique"
	end

## mobile validation
	
	test "a manufacturer mobile should have a string length between 4 and 20" do
		manufacturer = Manufacturer.new
		manufacturer.mobile = "12"
		assert !manufacturer.save
		assert !manufacturer.errors[:mobile].empty?
		assert manufacturer.errors[:mobile].include?("missing required length")		
	end

	test "a manufacturer mobile should contain only numbers" do
		manufacturer = Manufacturer.new
		manufacturer.mobile = 'aa'
		assert !manufacturer.save
		assert !manufacturer.errors[:mobile].empty?
		assert manufacturer.errors[:mobile].include?("not correct format")
	end

	test "a manufacturer mobile should be an empty string or nil value" do
		# assert Manufacturer.create(mobile: "").valid?, "should permit empty string"
		# assert Manufacturer.create(mobile: nil).valid?, "should permit nil value"
		manufacturer = Manufacturer.new
		manufacturer.mobile = ''
		assert !manufacturer.save
		# puts manufacturer.errors[:mobile]
		assert manufacturer.errors[:mobile].empty?
	end
end