# TrashBank Batam

Bank sampah digital (UI saja, data dummy) - tugas Flutter, 5 halaman:
Splash, Login Statis, Beranda, Tambah Setoran, Detail Setoran.

## Cara menjalankan
1. Pastikan Flutter terpasang: `flutter doctor`
2. Di folder ini jalankan (membuat folder android/ios/web otomatis):
   `flutter create . --project-name trashbank_batam`
3. `flutter pub get`
4. `flutter run` (pilih emulator / HP / Chrome)

## Struktur
lib/
  main.dart
  theme/app_theme.dart
  models/setoran.dart
  data/dummy_data.dart
  screens/ (splash, login, home, add_setoran, detail_setoran)
  widgets/setoran_card.dart
