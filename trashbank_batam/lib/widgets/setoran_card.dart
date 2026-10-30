import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_data.dart';
import '../models/setoran.dart';
import '../theme/app_theme.dart';

/// Kartu satu setoran di daftar Beranda
class SetoranCard extends StatelessWidget {
  final Setoran setoran;
  final VoidCallback onTap;

  const SetoranCard({super.key, required this.setoran, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final warna = DummyData.warnaKategori[setoran.jenis] ?? Colors.grey;
    final ikon = DummyData.ikonKategori[setoran.jenis] ?? Icons.recycling;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(color: Color(0x14000000), blurRadius: 8, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: warna.withAlpha(40),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(ikon, color: warna),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(setoran.jenis,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '${DateFormat('d MMM y').format(setoran.tanggal)} • ${setoran.berat} kg',
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ),
            Text('+${setoran.totalKoin}',
                style: const TextStyle(
                    color: AppColors.coin, fontWeight: FontWeight.bold)),
            const SizedBox(width: 4),
            const Icon(Icons.monetization_on, color: AppColors.coin, size: 18),
          ],
        ),
      ),
    );
  }
}
