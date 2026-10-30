import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatanku',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      builder: (context, child) => ColoredBox(
        color: AppTheme.background,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

const List<String> noteCategories = ['Pribadi', 'Kerja', 'Kuliah'];
const List<Color> noteColors = [
  Color(0xFFFFE8B8),
  Color(0xFFD8F1E8),
  Color(0xFFE7DDF8),
  Color(0xFFFFDDE2),
  Color(0xFFDCEBFA),
];

class NoteItem {
  const NoteItem({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.color,
    required this.priority,
    required this.createdAt,
    this.isArchived = false,
  });

  final String id;
  final String title;
  final String content;
  final String category;
  final Color color;
  final String priority;
  final DateTime createdAt;
  final bool isArchived;

  NoteItem copyWith({
    String? title,
    String? content,
    String? category,
    Color? color,
    String? priority,
    bool? isArchived,
  }) {
    return NoteItem(
      id: id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      color: color ?? this.color,
      priority: priority ?? this.priority,
      createdAt: createdAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _timer = Timer(const Duration(seconds: 2), _openLogin);
  }

  void _openLogin() {
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFF0F1), Color(0xFFFCF7F8), Color(0xFFF6E5EA)],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: _controller,
              curve: Curves.easeOut,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BrandMark(size: 96),
                const SizedBox(height: 20),
                Text(
                  'Catatanku',
                  style: GoogleFonts.manrope(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 7),
                const Text('Simpan ide, rencana, dan cerita harianmu.'),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(minHeight: 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController(
    text: 'dina@example.test',
  );
  final TextEditingController _password = TextEditingController();
  bool _obscurePassword = true;

  void _enter() {
    final email = _email.text.trim();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => MainShell(
          name: _displayNameFromEmail(email),
          email: email,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 380),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(child: BrandMark(size: 78)),
                  const SizedBox(height: 18),
                  Text(
                    'Catatanku',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Masuk dan lanjutkan ceritamu',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppTheme.muted),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline_rounded),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: _password,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        tooltip: _obscurePassword
                            ? 'Tampilkan password'
                            : 'Sembunyikan password',
                        onPressed: () => setState(() {
                          _obscurePassword = !_obscurePassword;
                        }),
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: _enter,
                    child: const Text('Masuk'),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Aplikasi catatan pribadi untuk Dina',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: AppTheme.muted),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _displayNameFromEmail(String email) {
  final localPart = email.trim().split('@').first;
  final words =
      localPart.replaceAll(RegExp(r'[._-]+'), ' ').trim().split(RegExp(r'\s+'));
  if (words.isEmpty || words.first.isEmpty) return 'Dina';
  return words
      .map((word) =>
          '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}')
      .join(' ');
}

class MainShell extends StatefulWidget {
  const MainShell({
    this.name = 'Dina',
    this.email = 'dina@example.test',
    super.key,
  });

  final String name;
  final String email;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _selectedTab = 0;
  late final List<NoteItem> _notes;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _notes = [
      NoteItem(
        id: '1',
        title: 'Ide Aplikasi',
        content:
            'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas. Cocok untuk mencatat ide, rencana, dan hal penting sehari-hari.',
        category: 'Pribadi',
        color: noteColors[0],
        priority: 'Sedang',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      NoteItem(
        id: '2',
        title: 'Rencana Mingguan',
        content:
            'Rapikan meja belajar, selesaikan tugas, dan luangkan waktu untuk membaca buku baru.',
        category: 'Pribadi',
        color: noteColors[1],
        priority: 'Tinggi',
        createdAt: now.subtract(const Duration(days: 1)),
      ),
      NoteItem(
        id: '3',
        title: 'Catatan Kuliah',
        content:
            'Review materi desain antarmuka dan siapkan rangkuman untuk pertemuan berikutnya.',
        category: 'Kuliah',
        color: noteColors[2],
        priority: 'Sedang',
        createdAt: now.subtract(const Duration(days: 2)),
      ),
      NoteItem(
        id: '4',
        title: 'Daftar Belanja',
        content: 'Susu, buah, roti, dan teh melati.',
        category: 'Pribadi',
        color: noteColors[3],
        priority: 'Rendah',
        createdAt: now.subtract(const Duration(days: 3)),
        isArchived: true,
      ),
    ];
  }

  List<NoteItem> get _activeNotes =>
      _notes.where((note) => !note.isArchived).toList();

  List<NoteItem> get _archivedNotes =>
      _notes.where((note) => note.isArchived).toList();

  Future<void> _openForm({NoteItem? note}) async {
    final result = await Navigator.of(context).push<NoteItem>(
      MaterialPageRoute<NoteItem>(
        builder: (_) => NoteFormScreen(note: note),
      ),
    );
    if (result == null || !mounted) return;
    setState(() {
      final index = _notes.indexWhere((item) => item.id == result.id);
      if (index == -1) {
        _notes.insert(0, result);
      } else {
        _notes[index] = result;
      }
    });
  }

  Future<void> _openDetail(NoteItem note) async {
    await Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => NoteDetailScreen(
          note: note,
          onUpdate: (updated) => setState(() {
            final index = _notes.indexWhere((item) => item.id == updated.id);
            if (index != -1) _notes[index] = updated;
          }),
          onDelete: () {
            setState(() => _notes.removeWhere((item) => item.id == note.id));
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        name: widget.name,
        notes: _activeNotes,
        onOpenNote: _openDetail,
        onAddNote: _openForm,
        onShowArchive: () => setState(() => _selectedTab = 1),
      ),
      ArchiveScreen(notes: _archivedNotes, onOpenNote: _openDetail),
      ProfileScreen(name: widget.name, email: widget.email),
    ];
    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _selectedTab, children: pages)),
      floatingActionButton: _selectedTab < 2
          ? FloatingActionButton(
              onPressed: () => _openForm(),
              tooltip: 'Tambah catatan',
              child: const Icon(Icons.add_rounded),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedTab,
        onDestinationSelected: (index) => setState(() => _selectedTab = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.archive_outlined),
            selectedIcon: Icon(Icons.archive_rounded),
            label: 'Arsip',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.name,
    required this.notes,
    required this.onOpenNote,
    required this.onAddNote,
    required this.onShowArchive,
    super.key,
  });

  final String name;
  final List<NoteItem> notes;
  final ValueChanged<NoteItem> onOpenNote;
  final VoidCallback onAddNote;
  final VoidCallback onShowArchive;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _search = TextEditingController();
  String _selectedCategory = 'Semua';

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _search.text.trim().toLowerCase();
    final notes = widget.notes.where((note) {
      final matchesCategory =
          _selectedCategory == 'Semua' || note.category == _selectedCategory;
      final matchesQuery = query.isEmpty ||
          note.title.toLowerCase().contains(query) ||
          note.content.toLowerCase().contains(query);
      return matchesCategory && matchesQuery;
    }).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 100),
      children: [
        Row(
          children: [
            const BrandMark(size: 44),
            const SizedBox(width: 11),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CATATANKU',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const Text(
                    'ruang kecil untuk ide besarmu',
                    style: TextStyle(color: AppTheme.muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Arsip',
              onPressed: widget.onShowArchive,
              icon: const Icon(Icons.archive_outlined),
            ),
            CircleAvatar(
              backgroundColor: AppTheme.primary.withAlpha(30),
              foregroundColor: AppTheme.primary,
              child: Text(widget.name.isEmpty ? 'D' : widget.name[0]),
            ),
          ],
        ),
        const SizedBox(height: 26),
        Text(
          'Halo, ${widget.name} 👋',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
        const SizedBox(height: 4),
        const Text('Apa yang ingin kamu catat hari ini?'),
        const SizedBox(height: 18),
        _NoteCountPanel(
          count: widget.notes.length,
          onTap: widget.onAddNote,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            const Expanded(child: SectionHeading(title: 'Catatanmu')),
            TextButton(
              onPressed: widget.onShowArchive,
              child: const Text('Lihat arsip'),
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _search,
          onChanged: (_) => setState(() {}),
          decoration: const InputDecoration(
            hintText: 'Cari catatan...',
            prefixIcon: Icon(Icons.search_rounded),
            isDense: true,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['Semua', ...noteCategories].map((category) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (_) =>
                      setState(() => _selectedCategory = category),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 10),
        if (notes.isEmpty)
          EmptyMessage(
            icon: Icons.sticky_note_2_outlined,
            title: query.isEmpty ? 'Belum ada catatan' : 'Catatan tak ditemukan',
            subtitle: query.isEmpty
                ? 'Tekan tombol + untuk menulis catatan pertamamu.'
                : 'Coba kata kunci atau kategori yang berbeda.',
          )
        else
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: NoteTile(note: note, onTap: () => widget.onOpenNote(note)),
            ),
          ),
      ],
    );
  }
}

class NoteFormScreen extends StatefulWidget {
  const NoteFormScreen({this.note, super.key});

  final NoteItem? note;

  @override
  State<NoteFormScreen> createState() => _NoteFormScreenState();
}

class _NoteFormScreenState extends State<NoteFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _title;
  late final TextEditingController _content;
  late String _category;
  late String _priority;
  late Color _color;

  @override
  void initState() {
    super.initState();
    final note = widget.note;
    _title = TextEditingController(text: note?.title ?? '');
    _content = TextEditingController(text: note?.content ?? '');
    _category = note?.category ?? noteCategories.first;
    _priority = note?.priority ?? 'Sedang';
    _color = note?.color ?? noteColors.first;
  }

  @override
  void dispose() {
    _title.dispose();
    _content.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    final now = DateTime.now();
    final note = widget.note;
    Navigator.of(context).pop(
      NoteItem(
        id: note?.id ?? now.microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        content: _content.text.trim(),
        category: _category,
        color: _color,
        priority: _priority,
        createdAt: note?.createdAt ?? now,
        isArchived: note?.isArchived ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? 'Tambah Catatan' : 'Edit Catatan'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Judul Catatan',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _title,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: 'Apa judulnya?'),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Judul catatan perlu diisi.'
                  : null,
            ),
            const SizedBox(height: 20),
            const Text(
              'Isi Catatan',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _content,
              minLines: 5,
              maxLines: 9,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                hintText: 'Tulis catatanmu di sini...',
                alignLabelWithHint: true,
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'Isi catatan perlu diisi.'
                  : null,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              initialValue: _category,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                prefixIcon: Icon(Icons.folder_outlined),
              ),
              items: noteCategories
                  .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) setState(() => _category = value);
              },
            ),
            const SizedBox(height: 20),
            const Text('Warna', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 10),
            Wrap(
              spacing: 12,
              children: noteColors.map((color) {
                final selected = _color == color;
                return InkWell(
                  onTap: () => setState(() => _color = color),
                  customBorder: const CircleBorder(),
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: selected ? AppTheme.primary : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: selected
                        ? const Icon(Icons.check_rounded, size: 19)
                        : null,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Prioritas',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            SegmentedButton<String>(
              segments: const [
                ButtonSegment(value: 'Rendah', label: Text('Rendah')),
                ButtonSegment(value: 'Sedang', label: Text('Sedang')),
                ButtonSegment(value: 'Tinggi', label: Text('Tinggi')),
              ],
              selected: {_priority},
              onSelectionChanged: (value) =>
                  setState(() => _priority = value.first),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: _save,
              icon: const Icon(Icons.check_rounded),
              label: const Text('Simpan Catatan'),
            ),
          ],
        ),
      ),
    );
  }
}

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({
    required this.note,
    required this.onUpdate,
    required this.onDelete,
    super.key,
  });

  final NoteItem note;
  final ValueChanged<NoteItem> onUpdate;
  final VoidCallback onDelete;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late NoteItem _note = widget.note;

  Future<void> _edit() async {
    final updated = await Navigator.of(context).push<NoteItem>(
      MaterialPageRoute<NoteItem>(
        builder: (_) => NoteFormScreen(note: _note),
      ),
    );
    if (updated == null || !mounted) return;
    widget.onUpdate(updated);
    setState(() => _note = updated);
  }

  void _toggleArchive() {
    final updated = _note.copyWith(isArchived: !_note.isArchived);
    widget.onUpdate(updated);
    setState(() => _note = updated);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          updated.isArchived ? 'Catatan dipindahkan ke arsip.' : 'Catatan dipulihkan.',
        ),
      ),
    );
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus catatan?'),
        content: const Text('Catatan ini akan dihapus dari perangkat.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    widget.onDelete();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final date = _formatNoteDate(_note.createdAt, showTime: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Catatan'),
        actions: [
          IconButton(
            tooltip: 'Edit catatan',
            onPressed: _edit,
            icon: const Icon(Icons.edit_outlined),
          ),
          IconButton(
            tooltip: 'Hapus catatan',
            onPressed: _delete,
            icon: const Icon(Icons.delete_outline_rounded),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _note.color,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CategoryBadge(category: _note.category),
                    const Spacer(),
                    PriorityBadge(priority: _note.priority),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  _note.title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  date,
                  style: const TextStyle(color: AppTheme.muted, fontSize: 13),
                ),
                const Divider(height: 30),
                Text(
                  _note.content,
                  style: const TextStyle(fontSize: 16, height: 1.65),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _toggleArchive,
            icon: Icon(
              _note.isArchived ? Icons.unarchive_outlined : Icons.archive_outlined,
            ),
            label: Text(
              _note.isArchived ? 'Pulihkan dari Arsip' : 'Pindahkan ke Arsip',
            ),
          ),
        ],
      ),
    );
  }
}

class ArchiveScreen extends StatelessWidget {
  const ArchiveScreen({
    required this.notes,
    required this.onOpenNote,
    super.key,
  });

  final List<NoteItem> notes;
  final ValueChanged<NoteItem> onOpenNote;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
      children: [
        Text(
          'Arsip Catatan',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        const Text('Catatan yang disimpan untuk nanti.'),
        const SizedBox(height: 18),
        if (notes.isEmpty)
          const EmptyMessage(
            icon: Icons.archive_outlined,
            title: 'Arsip masih kosong',
            subtitle: 'Catatan yang kamu arsipkan akan muncul di sini.',
          )
        else
          ...notes.map(
            (note) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: NoteTile(note: note, onTap: () => onOpenNote(note)),
            ),
          ),
      ],
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({required this.name, required this.email, super.key});

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        const SizedBox(height: 24),
        const Center(child: BrandMark(size: 76)),
        const SizedBox(height: 18),
        Text(
          name,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 5),
        Text(
          email,
          textAlign: TextAlign.center,
          style: const TextStyle(color: AppTheme.muted),
        ),
        const SizedBox(height: 26),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: surfaceDecoration(),
          child: const Row(
            children: [
              Icon(Icons.lightbulb_outline_rounded, color: AppTheme.primary),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Catat ide kecil hari ini, temukan inspirasi besar esok hari.',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        const Center(
          child: Text(
            'Catatanku · ruang pribadi milikmu',
            style: TextStyle(color: AppTheme.muted, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class NoteTile extends StatelessWidget {
  const NoteTile({required this.note, required this.onTap, super.key});

  final NoteItem note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final date = _formatNoteDate(note.createdAt);
    return Material(
      color: note.color,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(180),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.sticky_note_2_outlined,
                  color: AppTheme.primary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      note.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note.content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: AppTheme.muted, height: 1.3),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CategoryBadge(category: note.category),
                        const Spacer(),
                        Text(
                          date,
                          style: const TextStyle(
                            color: AppTheme.muted,
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              const Icon(Icons.chevron_right_rounded, color: AppTheme.muted),
            ],
          ),
        ),
      ),
    );
  }
}

String _formatNoteDate(DateTime date, {bool showTime = false}) {
  const months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];
  final formatted = '${date.day} ${months[date.month - 1]} ${date.year}';
  if (!showTime) return formatted;
  final hour = date.hour.toString().padLeft(2, '0');
  final minute = date.minute.toString().padLeft(2, '0');
  return '$formatted · $hour.$minute';
}

class _NoteCountPanel extends StatelessWidget {
  const _NoteCountPanel({required this.count, required this.onTap});

  final int count;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppTheme.primary,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(38),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.edit_note_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$count catatan aktif',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      'Ide-idemu tersimpan rapi',
                      style: TextStyle(color: Color(0xFFECE7F4)),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.add_circle_outline, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFA33B57), Color(0xFF800020)],
        ),
        borderRadius: BorderRadius.circular(size * 0.31),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primary.withAlpha(45),
            blurRadius: size * 0.22,
            offset: Offset(0, size * 0.09),
          ),
        ],
      ),
      child: Icon(
        Icons.auto_awesome_mosaic_rounded,
        color: Colors.white,
        size: size * 0.52,
      ),
    );
  }
}

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({required this.category, super.key});

  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(180),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        category,
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class PriorityBadge extends StatelessWidget {
  const PriorityBadge({required this.priority, super.key});

  final String priority;

  @override
  Widget build(BuildContext context) {
    final color = switch (priority) {
      'Tinggi' => const Color(0xFFB94755),
      'Rendah' => const Color(0xFF3B8067),
      _ => const Color(0xFF876A2D),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(190),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  const SectionHeading({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.w800),
    );
  }
}

class EmptyMessage extends StatelessWidget {
  const EmptyMessage({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 38, horizontal: 12),
      child: Column(
        children: [
          Icon(icon, size: 42, color: AppTheme.muted),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppTheme.muted),
          ),
        ],
      ),
    );
  }
}

BoxDecoration surfaceDecoration() {
  return BoxDecoration(
    color: AppTheme.surface,
    borderRadius: BorderRadius.circular(18),
    border: Border.all(color: const Color(0xFFEDE2E5)),
    boxShadow: const [
      BoxShadow(
        color: Color(0x0C2F2344),
        blurRadius: 16,
        offset: Offset(0, 5),
      ),
    ],
  );
}
