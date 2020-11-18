class AddColumnToFollowship < ActiveRecord::Migration[6.0]
  def change
    add_column :followships,:user_id,:integer
    add_column :followships,:following_user_id,:integer
  end
end
