class AddPrivateFlagToEvents < ActiveRecord::Migration[8.0]
  def change
    add_column :events, :private_flag, :boolean
  end
end
