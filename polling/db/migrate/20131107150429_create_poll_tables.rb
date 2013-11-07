class CreatePollTables < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.text "title"
      t.integer "author_id"

      t.timestamps
    end
  end
end
