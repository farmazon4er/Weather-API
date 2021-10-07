class CreateHistoricals < ActiveRecord::Migration[6.1]
  def change
    create_table :historicals do |t|
      t.float :temp, array: true, default: []

      t.timestamps
    end
  end
end
