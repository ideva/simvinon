# Change globals to match the proper value for your site

DELETE_CONFIRM = "Apakah Anda Yakin Akan Menghapus?\nProses Ini Tidak Bisa Diulang."
SEARCH_LIMIT = 25
SITE_NAME = 'Verifikasi E-JKBM - SIM RS'
SITE = Rails.env == 'production' ? 'www.z4comp.com' : 'localhost:3000'
ADMINEMAIL = 'hisamuddin.riza@gmail.com'
INFOEMAIL = 'info@bookatonline.com'

DEFAULT_TITLE = SITE_NAME
DEFAULT_META_DESCRIPTION = "Verifikasi E-JKBM - SIM RS"
DEFAULT_META_KEYWORDS = ""

FAILURE_MESSAGE = "Telah Terjadi Kesalahan"

PIC_PHONE_SIZE = "100x100>"
PIC_THUMB_SIZE_SMALL = "70x70>"
PIC_THUMB_SIZE = "300x300>"
PIC_THUMB_SIZE_BIG = "300x300>"
PIC_FULL_SIZE = "800x800>"

PAGINATION = 50
HOLD_TIME = 20

AWALAN_KODE = "VI"

ODD_COLOR = "#DAE8F3"
EVEN_COLOR = "white"

NEW_MSG = "Inputkan data lalu tekan tombol Simpan untuk menyimpan"
CREATE_MSG = "Data telah disimpan"
EDIT_MSG = "Ubah data lalu tekan tombol Simpan untuk menyimpan"
UPDATE_MSG = "Data telah diperbaharui"
DELETE_MSG = "Data berhasil dihapus"
DELETE_CASCADE_ERROR_MSG = "Data tidak bisa dihapus karena masih digunakan oleh data lain"
SEARCHING_MSG = "Isikan kriteria pencarian anda kemudian tekan tombol temukan"
SEARCHING_ERROR_MSG = "Data tidak ditemukan, ubah kriteria pencarian anda"
SEARCHING_SUCCESS_EDIT_MSG = "Data ditemukan, ubah data jika diperlukan"
SEARCHING_SUCCESS_MSG = "Data ditemukan, ubah data jika diperlukan"
SHOW_MSG = "Pilih salah satu data untuk melihat data selengkapnya"
ERROR_MSG = "Terjadi kesalahan, kemungkinan data tidak lengkap atau data sedang dikunci oleh transaksi lain<br/> Silahkan ulangi proses ini."
LOCK_ERROR_MSG = "Data sedang digunakan, cobalah beberapa saat lagi"
TIME_OUT_MSG = "Sesi anda sudah diakhiri"
AJAX_ERROR = "Telah terjadi kesalahan pada pengiriman data, periksa koneksi lalu ulangi proses. Hubungi administrator jika masalah masih berlanjut."

COUNTER_TO_TIME_OUT = 15
TIME_OUT = 30 # detik
PERIODIC_REQUEST = 20000 # milidetik

Time::DATE_FORMATS[:my_format] = "%d-%m-%Y"
DIR_IN = "#{Rails.root}/CSV/"