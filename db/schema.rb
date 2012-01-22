# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120103220851) do

  create_table "alasan_verifikasis", :force => true do |t|
    t.string   "kode"
    t.string   "alasan"
    t.integer  "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "functions", :force => true do |t|
    t.string   "name"
    t.string   "action_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "controller_name"
  end

  create_table "jenis_pelayanans", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "jenis_pelayanans", ["kode"], :name => "NewIndex1"

  create_table "kabupatens", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "kabupatens", ["kode"], :name => "NewIndex1"

  create_table "kategori_obats", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "kategori_obats", ["kode"], :name => "NewIndex1", :unique => true

  create_table "kategori_tindakan_medis", :force => true do |t|
    t.string   "kode",       :null => false
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "kategori_tindakan_medis", ["kode"], :name => "NewIndex1"

  create_table "kategori_tindakan_penunjangs", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "kategori_tindakan_penunjangs", ["kode"], :name => "NewIndex1"

  create_table "lock_tables", :force => true do |t|
    t.string   "model"
    t.integer  "iduser_access"
    t.string   "session_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "id_to_lock"
    t.integer  "counter",         :default => 0
    t.string   "controller_name"
    t.string   "action_name"
  end

  create_table "mapping_data_obats", :force => true do |t|
    t.string   "kode_rs"
    t.string   "kode_ejkbm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  create_table "mapping_data_pemeriksaans", :force => true do |t|
    t.string   "kode_tm_rs"
    t.string   "kode_tm_ejkbm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
    t.string   "kode_pemeriksaan"
    t.integer  "jenis_pelayanan"
    t.string   "kode_pemeriksaan_ejkbm"
    t.string   "kode_pemeriksaan_rs"
  end

  create_table "mapping_data_tindakan_medis", :force => true do |t|
    t.string   "kode_rs"
    t.string   "kode_ejkbm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  create_table "mapping_data_tindakan_penunjangs", :force => true do |t|
    t.string   "kode_rs"
    t.string   "kode_ejkbm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  create_table "mapping_pelayanan_lains", :force => true do |t|
    t.string   "kode_pelayanan_lain_rs"
    t.string   "kode_pelayanan_lain_ejkbm"
    t.integer  "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "obats", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.string   "kode_kategori"
    t.string   "bentuk_kekuatan_kemasan"
    t.integer  "jumlah",                  :default => 0
    t.string   "satuan"
    t.float    "het_satuan",              :default => 0.0
    t.float    "het_pack",                :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "obats", ["iduser"], :name => "IndexUser1"
  add_index "obats", ["kode_kategori"], :name => "NewIndex1"

  create_table "pelayanan_lains", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.string   "tarif"
    t.string   "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pemeriksaans", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.float    "tarif",                :default => 0.0
    t.integer  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
    t.string   "kode_jenis_pelayanan", :default => ""
  end

  add_index "pemeriksaans", ["iduser"], :name => "NewIndex1"

  create_table "ru_pusks", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_kecamatan"
    t.string   "kode_kabupaten"
  end

  create_table "settings", :force => true do |t|
    t.string   "name"
    t.string   "string_value"
    t.integer  "integer_value"
    t.boolean  "boolean_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_plants", :force => true do |t|
    t.string   "tanggal"
    t.string   "menu"
    t.string   "url"
    t.text     "skenario"
    t.boolean  "hasil"
    t.text     "deskripsi_hasil"
    t.text     "komentar"
    t.string   "image"
    t.integer  "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tindakan_medis", :force => true do |t|
    t.string   "kode"
    t.string   "kode_kategori_tindakan_medis"
    t.string   "nama"
    t.float    "tarif",                        :default => 0.0
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "tindakan_medis", ["kode_kategori_tindakan_medis"], :name => "NewIndex1"

  create_table "tindakan_penunjangs", :force => true do |t|
    t.string   "kode"
    t.string   "kode_kategori_tindakan_penunjang"
    t.string   "nama"
    t.float    "tarif",                            :default => 0.0
    t.string   "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "iduser"
  end

  add_index "tindakan_penunjangs", ["kode_kategori_tindakan_penunjang"], :name => "NewIndex1"

  create_table "user_type_functions", :force => true do |t|
    t.integer  "iduser_type"
    t.integer  "idfunction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_type_functions", ["iduser_type"], :name => "NewIndex1"

  create_table "user_types", :force => true do |t|
    t.string   "kode"
    t.string   "nama"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_types", ["kode"], :name => "NewIndex1"

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "super_admin",                              :default => false
    t.integer  "iduser_type"
  end

  add_index "users", ["id"], :name => "IndexUser1", :unique => true
  add_index "users", ["id"], :name => "NewIndex1"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

  create_table "verifikasi_logs", :force => true do |t|
    t.integer  "status_verifikasi_verifikator_sebelum"
    t.integer  "status_verifikasi_verifikator_sesudah"
    t.integer  "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_verifikasi"
  end

  create_table "verifikasi_obats", :force => true do |t|
    t.string   "kode",                                             :null => false
    t.string   "kode_verifikasi"
    t.string   "kode_obat_rs"
    t.integer  "jumlah_obat_rs"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_obat_ejkbm"
    t.float    "satuan_tarif_ejkbm",            :default => 0.0
    t.float    "sub_total_tarif_ejkbm",         :default => 0.0
    t.integer  "iduser"
    t.integer  "flag"
    t.string   "nama_obat_rs"
    t.string   "tgl_obat"
    t.boolean  "status_verifikasi_sistem",      :default => false
    t.integer  "status_verifikasi_verifikator", :default => 0
    t.string   "kode_alasan_verifikasi"
    t.string   "komentar"
    t.string   "no_transaksi"
  end

  add_index "verifikasi_obats", ["iduser"], :name => "NewIndex1"

  create_table "verifikasi_pelayanan_lains", :force => true do |t|
    t.string   "kode"
    t.string   "kode_verifikasi"
    t.string   "kode_pelayanan_lain_ejkbm"
    t.string   "kode_pelayanan_lain_rs"
    t.integer  "jumlah_pelayanan_lain_rs"
    t.string   "nama_pelayanan_lain_rs"
    t.string   "tgl_pelayanan_lain_rs"
    t.integer  "flag"
    t.float    "satuan_tarif",                  :default => 0.0
    t.float    "sub_total_tarif",               :default => 0.0
    t.integer  "iduser"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status_verifikasi_sistem",      :default => false
    t.integer  "status_verifikasi_verifikator", :default => 0
    t.string   "kode_alasan_verifikasi"
    t.string   "komentar"
    t.string   "no_transaksi"
  end

  create_table "verifikasi_pemeriksaans", :force => true do |t|
    t.string   "kode"
    t.string   "kode_verifikasi"
    t.string   "kode_pemeriksaan_ejkbm"
    t.float    "tarif_pemeriksaan",             :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "flag"
    t.integer  "iduser"
    t.float    "sub_total_tarif_ejkbm",         :default => 0.0
    t.integer  "jumlah"
    t.string   "kode_pemeriksaan_rs"
    t.boolean  "status_verifikasi_sistem",      :default => false
    t.integer  "status_verifikasi_verifikator", :default => 0
    t.string   "kode_alasan_verifikasi"
    t.string   "komentar"
    t.string   "no_transaksi"
  end

  create_table "verifikasi_request_logs", :force => true do |t|
    t.text     "request_in"
    t.text     "request_out"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verifikasi_tindakans", :force => true do |t|
    t.string   "kode",                                             :null => false
    t.string   "kode_verifikasi"
    t.string   "kode_t_medis_rs"
    t.integer  "jumlah_t_medis_rs"
    t.integer  "flag"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_t_medis_ejkbm"
    t.float    "satuan_tarif_ejkbm",            :default => 0.0
    t.float    "sub_total_tarif_ejkbm",         :default => 0.0
    t.integer  "iduser"
    t.string   "nama_t_medis_rs"
    t.integer  "jenis_pelayanan",               :default => 1
    t.string   "tgl_t_medis_rs"
    t.boolean  "status_verifikasi_sistem",      :default => false
    t.integer  "status_verifikasi_verifikator", :default => 0
    t.string   "kode_alasan_verifikasi"
    t.string   "komentar"
    t.string   "no_transaksi"
  end

  add_index "verifikasi_tindakans", ["iduser"], :name => "NewIndex1"

  create_table "verifikasi_to_ejkbm_firsts", :force => true do |t|
    t.text     "post_param"
    t.boolean  "sent_to_ejkbm"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_verifikasi"
  end

  create_table "verifikasis", :force => true do |t|
    t.string   "kode",                                             :null => false
    t.string   "no_reg"
    t.string   "no_klaim_rs"
    t.string   "no_pelayanan",                  :default => ""
    t.string   "tgl_masuk",                     :default => ""
    t.string   "tgl_keluar",                    :default => ""
    t.integer  "lama_dirawat",                  :default => 0
    t.string   "no_kk",                         :default => ""
    t.string   "nik",                           :default => ""
    t.string   "ktp",                           :default => ""
    t.string   "norm"
    t.string   "nama_pasien"
    t.string   "dokter",                        :default => ""
    t.string   "poli",                          :default => ""
    t.string   "keluhan",                       :default => ""
    t.string   "diagnosa_icd",                  :default => ""
    t.text     "nama_diagnosa_icd"
    t.float    "total_tarif",                   :default => 0.0
    t.string   "kode_alasan_verifikasi"
    t.string   "no_ejkbm"
    t.integer  "iduser"
    t.integer  "kode_jenis_pelayanan"
    t.string   "kode_kabupaten"
    t.string   "nama_t_medis"
    t.string   "nama_obat"
    t.string   "alamat"
    t.boolean  "status_verifikasi_sistem",      :default => false
    t.integer  "status_verifikasi_verifikator", :default => 0
    t.integer  "status_pengiriman",             :default => 0
    t.boolean  "sent_to_ejkbm",                 :default => false
    t.boolean  "sent_to_rs",                    :default => false
    t.string   "no_skp_ejkbm"
    t.text     "komentar"
    t.string   "no_daftar_rs"
    t.string   "kode_instalasi_layanan"
    t.string   "nama_instalasi_layanan"
    t.integer  "counter",                       :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "kode_ru_pusk"
  end

  add_index "verifikasis", ["no_pelayanan"], :name => "NewIndex1"

end
