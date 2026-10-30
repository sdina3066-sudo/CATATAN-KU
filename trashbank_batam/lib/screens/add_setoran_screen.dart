import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../data/dummy_data.dart';
import '../models/setoran.dart';
import '../theme/app_theme.dart';

/// Halaman 4: Tambah Setoran (form input)
class AddSetoranScreen extends StatefulWidget {
  const AddSetoranScreen({super.key});

  @override
  State<AddSetoranScreen> createState() => _AddSetoranScreenState();
}

class _AddSetoranScreenState extends State<AddSetoranScreen> {
  final _formKey = GlobalKey<FormState>();
  final _beratCtrl = TextEditingController();
  final _catatanCtrl = TextEditingController();

  String _jenis = 'Plastik';
  String _lokasi = DummyData.lokasi.first;
  DateTime _tanggal = DateTime.now();

  @override
  void dispose() {
    _beratCtrl.dispose();
    _catatanCtrl.dispose();
    super.dispose();
  }

  // Estimasi koin dihitung otomatis
  int get _estimasiKoin {
    final berat = double.tryParse(_beratCtrl.text.replaceAll(',', '.')) ?? 0;
    return (berat * (DummyData.koinPerKg[_jenis] ?? 0)).round();
  }

  Future<void> _pilihTanggal() async {
    final hasil = await showDatePicker(
      context: context,
      initialDate: _tanggal,
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (hasil != null) setState(() => _tanggal = hasil);
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) return;

    final berat = double.parse(_beratCtrl.text.replaceAll(',', '.'));
    DummyData.setoranList.insert(
      0,
      Setoran(
        id: DateTime.now().millisecondsSinceEpoch,
        jenis: _jenis,
        berat: berat,
        tanggal: _tanggal,
        lokasi: _lokasi,
        catatan: _catatanCtrl.text,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Setoran berhasil disimpan')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Setoran')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Jenis Sampah',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                // ignore: deprecated_member_use
                value: _jenis,
                items: DummyData.koinPerKg.keys
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                onChanged: (v) => setState(() => _jenis = v!),
              ),
              const SizedBox(height: 16),
              const Text('Berat (kg)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _beratCtrl,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(hintText: 'Contoh: 2.5'),
                validator: (v) {
                  final n = double.tryParse((v ?? '').replaceAll(',', '.'));
                  if (n == null || n <= 0) return 'Berat harus lebih dari 0';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              const Text('Tanggal',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              InkWell(
                onTap: _pilihTanggal,
                child: InputDecorator(
                  decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today)),
                  child: Text(DateFormat('d MMMM y').format(_tanggal)),
                ),
              ),
              const SizedBox(height: 16),
              const Text('Lokasi Bank Sampah',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                isExpanded: true,
                // ignore: deprecated_member_use
                value: _lokasi,
                items: DummyData.lokasi
                    .map((k) => DropdownMenuItem(value: k, child: Text(k)))
                    .toList(),
                onChanged: (v) => setState(() => _lokasi = v!),
              ),
              const SizedBox(height: 16),
              const Text('Catatan (opsional)',
                  style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              TextField(
                controller: _catatanCtrl,
                maxLines: 3,
                decoration:
                    const InputDecoration(hintText: 'Tulis catatan di sini...'),
              ),
              const SizedBox(height: 16),

              // Estimasi koin otomatis
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.coin.withAlpha(40),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text('Estimasi koin: $_estimasiKoin',
                    style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 24),
              ElevatedButton(onPressed: _simpan, child: const Text('Simpan')),
            ],
          ),
        ),
      ),
    );
  }
}
