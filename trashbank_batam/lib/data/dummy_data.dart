import 'package:flutter/material.dart';
import '../models/setoran.dart';

/// Data contoh (dummy), bukan data resmi.
class DummyData {
  static const Map<String, int> koinPerKg = {
    'Plastik': 150,
    'Kardus': 100,
    'Botol': 120,
    'Logam': 250,
  };

  static const Map<String, Color> warnaKategori = {
    'Plastik': Color(0xFF42A5F5),
    'Kardus': Color(0xFFA1887F),
    'Botol': Color(0xFF26A69A),
    'Logam': Color(0xFF90A4AE),
  };

  static const Map<String, IconData> ikonKategori = {
    'Plastik': Icons.local_drink,
    'Kardus': Icons.inventory_2,
    'Botol': Icons.liquor,
    'Logam': Icons.hardware,
  };

  static const List<String> lokasi = [
    'Bank Sampah Batam Centre',
    'Bank Sampah Sekupang',
    'Bank Sampah Nagoya',
    'Bank Sampah Batu Aji',
  ];

  /// Daftar setoran awal. Boleh ditambah dari halaman Tambah.
  static final List<Setoran> setoranList = [
    Setoran(
      id: 1,
      jenis: 'Plastik',
      berat: 2.5,
      tanggal: DateTime(2026, 10, 19),
      lokasi: 'Bank Sampah Batam Centre',
      catatan: 'Botol plastik sudah dibersihkan.',
    ),
    Setoran(
      id: 2,
      jenis: 'Kardus',
      berat: 4,
      tanggal: DateTime(2026, 10, 18),
      lokasi: 'Bank Sampah Sekupang',
      catatan: 'Kardus sudah dipipihkan.',
    ),
    Setoran(
      id: 3,
      jenis: 'Botol',
      berat: 1.8,
      tanggal: DateTime(2026, 10, 17),
      lokasi: 'Bank Sampah Nagoya',
    ),
    Setoran(
      id: 4,
      jenis: 'Logam',
      berat: 1,
      tanggal: DateTime(2026, 10, 15),
      lokasi: 'Bank Sampah Batu Aji',
      catatan: 'Kaleng minuman.',
    ),
  ];
}
