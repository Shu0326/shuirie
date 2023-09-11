class RemoveAreaFromGourmets < ActiveRecord::Migration[6.1]
  def change
    remove_column :gourmets, :area, :string
  end
end
