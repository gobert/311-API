class CreateCase < ActiveRecord::Migration
  def up
    create_table :cases do |t|
      t.integer :remote_id
      t.timestamp :opened_at
      t.timestamp :closed_at
      t.timestamp :remote_updated_at
      t.string :status
      t.text :status_note
      t.string :responsible_agency
      t.string :service
      t.string :service_subtype
      t.string :service_details
      t.string :address
      t.integer :supervisor_district_id
      t.string :neighborhood
      t.string :police_district
      t.string :source
      t.string :media_url

      # 5 digit after, 3 before
      # it shoud be 1m precise according to:
      # https://gis.stackexchange.com/a/8674
      t.decimal :lat, precision: 8, scale: 5
      t.decimal :lng, precision: 8, scale: 5

      t.timestamps
    end
  end

  def down
    drop_table :cases
  end
end
