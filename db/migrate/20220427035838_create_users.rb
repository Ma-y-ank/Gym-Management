class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.integer :trainer_id
      t.string :role, default: 'Trainee'

      t.timestamps
    end

    add_index :users, :trainer_id
  end
end
