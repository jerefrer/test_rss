class ChangeColNom < ActiveRecord::Migration
  def change
    rename_column :items, :id_flux, :flux_id
  end
end
