class CreateCalcs < ActiveRecord::Migration[5.1]
  def change
    create_table :calcs do |t|

      t.timestamps
    end
  end
end
