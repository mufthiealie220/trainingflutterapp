# Penjelasan

Kode ini membuat tampilan aplikasi Flutter yang terdiri dari halaman login, halaman utama, dan menu bawah (bottom navigation). Pada bagian login, username dan password yang diinput dicek secara sederhana, dan jika benar maka username akan disimpan menggunakan SharedPreferences agar bisa diakses kembali setelah login. Setelah login berhasil, pengguna akan diarahkan ke halaman utama yang menampilkan menu navigasi bawah.

Di halaman utama, pengguna bisa melihat tiga tab: Home, Input, dan Data. Tab Home menampilkan sapaan selamat datang dan jumlah data yang tersimpan. Tab Input menyediakan form untuk menambahkan data baru yang kemudian disimpan ke SharedPreferences, sedangkan tab Data menampilkan daftar data yang sudah disimpan dengan opsi untuk menghapusnya. Menu bawah dibuat lebih modern dengan gradien, sudut membulat, dan ikon yang diperbesar. Tombol logout ditempatkan di AppBar, dan ketika ditekan, aplikasi akan menghapus data username lalu kembali ke halaman login. Secara keseluruhan, kode ini mengatur alur login sederhana, penyimpanan data lokal, dan navigasi antar halaman dengan tampilan UI yang lebih rapi dan bersih.

# ScreenShoot

<img width="1905" height="1027" alt="image" src="https://github.com/user-attachments/assets/3201145b-e052-42e8-8ab7-a9af7db868b3" />

<img width="494" height="1023" alt="image" src="https://github.com/user-attachments/assets/bab7be78-15bf-436c-bb20-92dbdcfda419" />



