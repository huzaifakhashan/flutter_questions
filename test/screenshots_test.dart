// Generates the README screenshots into docs/screenshots/.
// Skipped by default; run with:
//   flutter test test/screenshots_test.dart --dart-define=SCREENSHOTS=true
// Needs Windows (uses Segoe UI for Arabic text).
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_questions/data/questions.dart';
import 'package:flutter_questions/main.dart';
import 'package:flutter_questions/models/question.dart';
import 'package:flutter_questions/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _enabled = bool.fromEnvironment('SCREENSHOTS');
const _outDir = 'docs/screenshots';
final _boundaryKey = GlobalKey();

Future<void> _loadFont(String family, List<String> paths) async {
  final loader = FontLoader(family);
  for (final path in paths) {
    final bytes = File(path).readAsBytesSync();
    loader.addFont(Future.value(ByteData.sublistView(bytes)));
  }
  await loader.load();
}

Future<void> _loadFonts() async {
  const win = r'C:\Windows\Fonts';
  final flutterRoot = Platform.environment['FLUTTER_ROOT']!;
  await _loadFont('Roboto', [
    '$win\\segoeui.ttf',
    '$win\\seguisb.ttf',
    '$win\\segoeuib.ttf',
  ]);
  await _loadFont('monospace', ['$win\\consola.ttf']);
  // Consolas has no Arabic glyphs and the test engine has no system
  // fallback, so serve Arabic code comments through CodeBlock's
  // fontFamilyFallback ('Menlo').
  await _loadFont('Menlo', ['$win\\segoeui.ttf']);
  await _loadFont('MaterialIcons', [
    '$flutterRoot/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
  ]);
}

Future<void> _pumpApp(WidgetTester tester, {bool dark = false}) async {
  tester.view.physicalSize = const Size(1170, 2532);
  tester.view.devicePixelRatio = 3;
  addTearDown(tester.view.reset);

  // Some progress so the bars aren't empty.
  final known = allQuestions
      .where((q) => q.id % 3 == 0 || (q.track == Track.flutter && q.id < 30))
      .map((q) => '${q.id}')
      .toList();
  SharedPreferences.setMockInitialValues({
    'known': known,
    'favorites': ['1020', '2016', '3016', '41'],
    'dark_mode': dark,
  });
  final prefs = await SharedPreferences.getInstance();
  await tester.pumpWidget(
    RepaintBoundary(
      key: _boundaryKey,
      child: FlutterQuestionsApp(state: AppState(prefs)),
    ),
  );
  await tester.pumpAndSettle();
}

Future<void> _shot(WidgetTester tester, String name) async {
  await tester.pumpAndSettle();
  final boundary = _boundaryKey.currentContext!.findRenderObject()!
      as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage(pixelRatio: 3);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$_outDir/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(data!.buffer.asUint8List());
  });
}

Future<void> _tap(WidgetTester tester, String text) async {
  final finder = find.text(text).first;
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  setUpAll(() async {
    if (_enabled) await _loadFonts();
  });

  testWidgets('light screenshots', (tester) async {
    await _pumpApp(tester);
    await _shot(tester, '01_home');

    await _tap(tester, 'Laravel');
    await _shot(tester, '02_track');

    await _tap(tester, 'أسئلة متوسطة');
    await _shot(tester, '03_list');

    final q = allQuestions.firstWhere((q) => q.id == 1019);
    await _tap(tester, q.question);
    await _shot(tester, '04_detail');

    // Back to home, then practice.
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();
    await tester.pageBack();
    await tester.pumpAndSettle();

    await _tap(tester, 'تدريب شامل');
    await _shot(tester, '05_practice_picker');

    await _tap(tester, 'صعب');
    await _tap(tester, 'أظهر الجواب');
    await _shot(tester, '06_practice');
  }, skip: !_enabled);

  testWidgets('dark screenshots', (tester) async {
    await _pumpApp(tester, dark: true);
    await _shot(tester, '07_home_dark');

    await _tap(tester, 'قواعد البيانات');
    await _tap(tester, 'أسئلة صعبة');
    final q = allQuestions.firstWhere((q) => q.id == 2033);
    await _tap(tester, q.question);
    await _shot(tester, '08_detail_dark');
  }, skip: !_enabled);
}
