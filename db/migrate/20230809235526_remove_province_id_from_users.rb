class RemoveProvinceIdFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :province_id, :integer
  end
end
