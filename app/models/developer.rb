# frozen_string_literal: true

# Store the developers information and handle operations
class Developer < ApplicationRecord
  validates_presence_of :first_name, :last_name, :email, :company_name

  # @return [Integer] define the per page count
  PAGINATION = 10.freeze

  #
  # Prepare a fake developer data before save
  #
  # @return [Hash]
  #
  def self.prepare_fake_data
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      email: Faker::Internet.email,
      company_name: Faker::Company.name,
      address: Faker::Address.full_address,
      dob: Faker::Date.between(from: '1980-09-23', to: '1990-09-25'),
      description: "#{Faker::Hobby.activity}, #{Faker::Food.dish}, #{Faker::ProgrammingLanguage.name}"
    }
  end

  #
  # Save the fake developer in the database
  #
  # @param [Integer] num number of developers created
  #
  # @return [nil]
  #
  def self.insert_fake_data(num = 10)
    attrs_arr = []

    1.upto(num) do |_|
      attrs_arr << Developer.prepare_fake_data
    end

    Developer.insert_all(attrs_arr)
  end
end
