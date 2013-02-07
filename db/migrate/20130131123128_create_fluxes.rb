class CreateFluxes < ActiveRecord::Migration
  def change
    create_table :fluxes do |t|
      t.string :titre
      t.string :url

      t.timestamps
    end
  end
end
