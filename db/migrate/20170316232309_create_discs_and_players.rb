class CreateDiscsAndPlayers < ActiveRecord::Migration
  def change
    create_table :discs do |t|
      t.integer :column
      t.integer :row
      t.references :player
    end

    create_table :players do |t|
      t.string :color
    end
  end
end
