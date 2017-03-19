class CreateDiscsAndPlayers < ActiveRecord::Migration
  def change
    create_table :boards do |t|
    end

    create_table :discs do |t|
      t.integer :column
      t.integer :row
      t.belongs_to :player, index: true
    end

    create_table :players do |t|
      t.string :color
      t.belongs_to :board, index: true
    end
  end
end
