require 'test_helper'

class ManufacturerTest < ActiveSupport::TestCase

	test "a manufacturer should have a name" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:name].empty?		
	end

	test "a manufacturer should have a country" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:country].empty?
	end

	test "a manufacturer should have a city" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:city].empty?
	end

	test "a manufacturer should have an address" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:address].empty?
	end

	test "a manufacturer should have an postal code" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:postal_code].empty?
	end

	test "a manufacturer should have an office telephone" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:office_tel].empty?
	end

	test "a manufacturer should have a fax" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:fax].empty?
	end

	test "a manufacturer should have an office_mail" do
		manufacturer = Manufacturer.new
		assert !manufacturer.save
		assert !manufacturer.errors[:office_mail].empty?
	end

	test "a manufacturer name should have a string length between 3 and 255" do
		manufacturer = Manufacturer.new
		manufacturer.name = 'ponny'
		assert !manufacturer.save
		# puts manufacturer.errors.inspect
		assert !manufacturer.errors[:name].empty?
	end
end
