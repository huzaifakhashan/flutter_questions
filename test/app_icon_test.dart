// Renders the app icon sources into assets/icon/.
// Skipped by default; run with:
//   flutter test test/app_icon_test.dart --dart-define=APP_ICON=true
//   dart run flutter_launcher_icons
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

const _enabled = bool.fromEnvironment('APP_ICON');
const _size = 1024.0;
const _outDir = 'assets/icon';

const _gradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFF13B9FD), Color(0xFF0175C2), Color(0xFF02569B)],
);

/// Speech bubble with a question mark and a small `</>` badge.
/// [scale] shrinks the artwork, e.g. to fit Android's adaptive safe zone.
class _Artwork extends StatelessWidget {
  const _Artwork({this.scale = 1});

  final double scale;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox.square(
        dimension: _size * scale,
        child: FittedBox(
          child: SizedBox.square(
            dimension: _size,
            child: Stack(
              children: [
                const Positioned(
                  left: 150,
                  top: 150,
                  child: Icon(
                    Icons.chat_bubble_rounded,
                    size: 700,
                    color: Colors.white,
                  ),
                ),
                const Positioned(
                  left: 290,
                  top: 250,
                  child: _GradientIcon(Icons.question_mark_rounded, 420),
                ),
                Positioned(
                  right: 110,
                  bottom: 110,
                  child: Container(
                    width: 330,
                    height: 330,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFFFFB74D), Color(0xFFF57C00)],
                      ),
                      border: Border.all(color: Colors.white, width: 28),
                    ),
                    child: const Icon(
                      Icons.code_rounded,
                      size: 190,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon(this.icon, this.size);

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => _gradient.createShader(bounds),
      child: Icon(icon, size: size, color: Colors.white),
    );
  }
}

Future<void> _render(
  WidgetTester tester,
  String name,
  Widget child,
) async {
  final key = GlobalKey();
  await tester.pumpWidget(
    Directionality(
      textDirection: TextDirection.ltr,
      child: Center(
        child: RepaintBoundary(
          key: key,
          child: SizedBox.square(dimension: _size, child: child),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  final boundary =
      key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
  await tester.runAsync(() async {
    final image = await boundary.toImage();
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    File('$_outDir/$name.png')
      ..createSync(recursive: true)
      ..writeAsBytesSync(data!.buffer.asUint8List());
  });
}

void main() {
  setUpAll(() async {
    if (!_enabled) return;
    final flutterRoot = Platform.environment['FLUTTER_ROOT']!;
    final bytes = File(
      '$flutterRoot/bin/cache/artifacts/material_fonts/materialicons-regular.otf',
    ).readAsBytesSync();
    await (FontLoader('MaterialIcons')
          ..addFont(Future.value(ByteData.sublistView(bytes))))
        .load();
  });

  testWidgets('app icon', (tester) async {
    tester.view.physicalSize = const Size(_size, _size);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // Full icon with rounded corners: Windows, web, legacy Android.
    await _render(
      tester,
      'icon',
      Container(
        decoration: BoxDecoration(
          gradient: _gradient,
          borderRadius: BorderRadius.circular(_size * 0.22),
        ),
        child: const _Artwork(scale: 0.9),
      ),
    );

    // Android adaptive icon layers. The launcher crops the outer third,
    // so the foreground artwork is kept inside the central safe zone.
    await _render(
      tester,
      'icon_background',
      const DecoratedBox(decoration: BoxDecoration(gradient: _gradient)),
    );
    await _render(tester, 'icon_foreground', const _Artwork(scale: 0.62));
  }, skip: !_enabled);
}
