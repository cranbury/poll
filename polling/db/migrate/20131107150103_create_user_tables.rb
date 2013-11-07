class CreateUserTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text "user_name"

      t.timestamps
    end
  end
end
