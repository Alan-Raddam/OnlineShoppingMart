class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :password
      t.boolean :isadmin
      t.text :email
      t.text :phone

      t.timestamps
    end
  end
end
