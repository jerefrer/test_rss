class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :id_flux
      t.string :titre
      t.text :contenu
      t.date :date
      t.string :status

      t.timestamps
    end
  end
end
