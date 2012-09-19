class AddDownloads < ActiveRecord::Migration
  def self.up
    create_table :downloads do |t|
      t.integer     :id
      t.text        :json_blob
      t.timestamps
    end
  end

  def self.down
    drop_table :downloads
  end
end

