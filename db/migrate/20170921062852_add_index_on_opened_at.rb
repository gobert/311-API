class AddIndexOnOpenedAt < ActiveRecord::Migration
  def up
    add_index :cases, :opened_at
  end

  def down
    remove_index :cases, :opened_at
  end
end
