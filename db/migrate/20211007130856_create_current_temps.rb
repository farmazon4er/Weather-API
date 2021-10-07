class CreateCurrentTemps < ActiveRecord::Migration[6.1]
  def change
    create_table :current_temps do |t|
      t.float :temp

      t.timestamps
    end
  end
end
