class CreateDevelopers < ActiveRecord::Migration[7.0]
  def change
    create_table :developers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :company_name, null: false
      t.text :address
      t.text :description
      t.date :dob

      t.timestamps
    end
  end
end
