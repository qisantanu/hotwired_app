class CreateDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :developers do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company_name
      t.text :address
      t.text :description
      t.date :dob

      t.timestamps
    end
  end
end
