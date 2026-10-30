import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:trashbank_batam/main.dart';

void main() {
  testWidgets('Login continues to the Dina notes home screen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    expect(find.text('Catatanku'), findsOneWidget);
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Dina 👋'), findsOneWidget);
    expect(find.text('Catatanmu'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsOneWidget);
  });

  testWidgets('A new note can be created and opened',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));

    await tester.tap(find.byTooltip('Tambah catatan'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(0), 'Catatan Baru');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Isi catatan untuk hari ini.',
    );
    await tester.scrollUntilVisible(
      find.text('Simpan Catatan'),
      250,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Simpan Catatan'));
    await tester.pumpAndSettle();

    expect(find.text('Catatan Baru'), findsOneWidget);
    await tester.tap(find.text('Catatan Baru'));
    await tester.pumpAndSettle();
    expect(find.text('Isi catatan untuk hari ini.'), findsOneWidget);
  });

  testWidgets('Search filters notes and profile shows Dina',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainShell()));

    await tester.enterText(find.byType(TextField).first, 'kuliah');
    await tester.pumpAndSettle();
    expect(find.text('Catatan Kuliah'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsNothing);

    await tester.tap(find.text('Profil').last);
    await tester.pumpAndSettle();
    expect(find.text('Dina'), findsOneWidget);
    expect(find.text('dina@example.test'), findsOneWidget);
  });
}
