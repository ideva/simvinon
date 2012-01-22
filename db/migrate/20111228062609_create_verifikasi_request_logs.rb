class CreateVerifikasiRequestLogs < ActiveRecord::Migration
  def self.up
    create_table :verifikasi_request_logs do |t|
      t.text :request_in
      t.text :request_out

      t.timestamps
    end
  end

  def self.down
    drop_table :verifikasi_request_logs
  end
end
