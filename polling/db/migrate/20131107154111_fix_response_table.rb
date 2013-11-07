class FixResponseTable < ActiveRecord::Migration
  def change
    remove_column :responses, :user_id
    add_column :responses, :respondent_id, :integer
  end
end
