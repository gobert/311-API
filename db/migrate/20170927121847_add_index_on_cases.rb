class AddIndexOnCases < ActiveRecord::Migration
  def up
    add_index :cases, :status
    add_index :cases, :service
    add_index :cases, :lat
    add_index :cases, :lng
  end

  def down
    remove_index :cases, :lng
    remove_index :cases, :lat
    remove_index :cases, :service
    remove_index :cases, :status
  end
end
