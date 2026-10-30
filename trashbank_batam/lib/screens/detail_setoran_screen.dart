import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_data.dart';
import '../models/setoran.dart';
import '../theme/app_theme.dart';

/// Halaman 5: Detail Setoran
class DetailSetoranScreen extends StatelessWidget {
  final Setoran setoran;

  const DetailSetoranScreen({super.key, required this.setoran});

  @override
  Widget build(BuildContext context) {
    final warna = DummyData.warnaKategori[setoran.jenis] ?? Colors.grey;
    final ikon = DummyData.ikonKategori[setoran.jenis] ?? Icons.recycling;

    // Tahapan status (tampilan saja)
    const tahap = ['Diajukan', 'Diantar', 'Ditimbang', 'Koin Masuk'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Setoran'),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Kartu header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: warna.withAlpha(40),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(ikon, size: 48, color: warna),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(setoran.jenis,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(DateFormat('d MMMM y').format(setoran.tanggal),
                        style: const TextStyle(
                            color: AppColors.textSecondary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Koin didapat (menonjol)
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const Text('Koin Didapat',
                    style: TextStyle(color: Colors.white70)),
                Text('+${setoran.totalKoin}',
                    style: const TextStyle(
                        color: AppColors.coin,
                        fontSize: 36,
                        fontWeight: FontWeight.bold)),
                Text(
                    '${setoran.berat} kg x ${setoran.koinPerKg} koin/kg',
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 16),

          _baris(Icons.scale, 'Berat', '${setoran.berat} kg'),
          _baris(Icons.location_on, 'Lokasi', setoran.lokasi),
          _baris(Icons.notes, 'Catatan',
              setoran.catatan.isEmpty ? '-' : setoran.catatan),
          const SizedBox(height: 16),

          const Text('Status',
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...tahap.map((t) => ListTile(
                dense: true,
                leading:
                    const Icon(Icons.check_circle, color: AppColors.primary),
                title: Text(t),
              )),
        ],
      ),
    );
  }

  Widget _baris(IconData ikon, String label, String nilai) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(ikon, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(label,
              style: const TextStyle(color: AppColors.textSecondary)),
          const Spacer(),
          Flexible(
            child: Text(nilai,
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
