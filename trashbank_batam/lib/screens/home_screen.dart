import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/setoran.dart';
import '../theme/app_theme.dart';
import '../widgets/setoran_card.dart';
import 'add_setoran_screen.dart';
import 'detail_setoran_screen.dart';

/// Halaman 3: Beranda (daftar setoran)
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _filter = 'Semua';
  String _cari = '';
  int _tab = 0; // BottomNavigation hanya tampilan

  List<Setoran> get _daftar {
    return DummyData.setoranList.where((s) {
      final cocokKategori = _filter == 'Semua' || s.jenis == _filter;
      final cocokCari = s.jenis.toLowerCase().contains(_cari.toLowerCase());
      return cocokKategori && cocokCari;
    }).toList();
  }

  int get _totalKoin =>
      DummyData.setoranList.fold(0, (sum, s) => sum + s.totalKoin);

  double get _totalBerat =>
      DummyData.setoranList.fold(0.0, (sum, s) => sum + s.berat);

  Future<void> _keTambah() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddSetoranScreen()),
    );
    setState(() {}); // refresh daftar setelah kembali
  }

  @override
  Widget build(BuildContext context) {
    final kategori = ['Semua', ...DummyData.koinPerKg.keys];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _keTambah,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (i) => setState(() => _tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Beranda'),
          NavigationDestination(icon: Icon(Icons.history), label: 'Riwayat'),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Halo, Ahmadi 👋',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text('Sudah pilah sampah hari ini?',
                style: TextStyle(color: AppColors.textSecondary)),
            const SizedBox(height: 16),

            // Kartu ringkasan koin & berat
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Total Koin',
                          style: TextStyle(color: Colors.white70)),
                      Text('$_totalKoin',
                          style: const TextStyle(
                              color: AppColors.coin,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Total Berat',
                          style: TextStyle(color: Colors.white70)),
                      Text('${_totalBerat.toStringAsFixed(1)} kg',
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Pencarian
            TextField(
              onChanged: (v) => setState(() => _cari = v),
              decoration: const InputDecoration(
                hintText: 'Cari setoran...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 12),

            // Chip filter kategori
            SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: kategori
                    .map((k) => Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(k),
                            selected: _filter == k,
                            onSelected: (_) => setState(() => _filter = k),
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 16),

            // Daftar setoran
            ..._daftar.map((s) => SetoranCard(
                  setoran: s,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => DetailSetoranScreen(setoran: s)),
                  ),
                )),
            if (_daftar.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('Belum ada setoran')),
              ),
          ],
        ),
      ),
    );
  }
}
