import '../data/dummy_data.dart';

/// Model satu data setoran sampah
class Setoran {
  final int id;
  final String jenis; // Plastik, Kardus, Botol, Logam
  final double berat; // dalam kg
  final DateTime tanggal;
  final String lokasi;
  final String catatan;

  const Setoran({
    required this.id,
    required this.jenis,
    required this.berat,
    required this.tanggal,
    required this.lokasi,
    this.catatan = '',
  });

  /// Koin per kg sesuai jenis (data dummy)
  int get koinPerKg => DummyData.koinPerKg[jenis] ?? 0;

  /// Total koin yang didapat
  int get totalKoin => (berat * koinPerKg).round();
}
