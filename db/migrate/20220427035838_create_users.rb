class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :trainer_id
      t.string :role

      t.timestamps
    end
  end
end
