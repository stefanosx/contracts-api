class CreateContracts < ActiveRecord::Migration[5.1]
  def change
    create_table :contracts do |t|
      t.string :vendor
      t.timestamp :starts_on
      t.timestamp :ends_on
      t.float :price

      t.timestamps
    end
  end
end
