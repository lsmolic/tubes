class AddTraceCaches < ActiveRecord::Migration
  def self.up
    self.transaction do
      create_table :trace_caches do |t|
        t.integer     :id
        t.text        :json_blob
        t.column     :source_ip, 'bigint unsigned'
        t.column     :destination_ip, 'bigint unsigned'
        t.timestamps
      end
    end
    add_index :trace_caches, [:source_ip, :destination_ip], :unique => true
  end

  def self.down
    self.transaction do
      drop_table :trace_caches
    end
  end
end



