class AddTabcolorToUser < ActiveRecord::Migration
  def change
    add_column :users, :tabcolor, :string
  end
end