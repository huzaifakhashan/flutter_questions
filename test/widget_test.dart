import 'package:flutter_questions/data/questions.dart';
import 'package:flutter_questions/main.dart';
import 'package:flutter_questions/models/question.dart';
import 'package:flutter_questions/state/app_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('question ids are unique', () {
    final ids = allQuestions.map((q) => q.id).toSet();
    expect(ids.length, allQuestions.length);
  });

  test('every track has questions at every level', () {
    for (final track in Track.values) {
      for (final level in Level.values) {
        expect(
          questionsOf(track).where((q) => q.level == level),
          isNotEmpty,
          reason: '${track.label} / ${level.label}',
        );
      }
    }
  });

  test('every category has at least one question', () {
    for (final c in Category.values) {
      expect(allQuestions.where((q) => q.category == c), isNotEmpty,
          reason: c.name);
    }
  });

  testWidgets('opens a track, a level and a question detail', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(FlutterQuestionsApp(state: AppState(prefs)));

    expect(find.text('أسئلة المقابلات'), findsOneWidget);

    await tester.tap(find.text('Laravel'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('أسئلة سهلة'));
    await tester.pumpAndSettle();

    final first =
        questionsOf(Track.laravel).firstWhere((q) => q.level == Level.easy);
    await tester.tap(find.text(first.question));
    await tester.pumpAndSettle();

    expect(find.text('الجواب'), findsOneWidget);
    expect(find.text(first.answer), findsOneWidget);
  });

  test('known and favorite questions persist', () async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    final state = AppState(prefs);
    final q = allQuestions.first;

    state.setKnown(q, true);
    expect(AppState(prefs).isKnown(q), isTrue);

    state.toggleFavorite(q);
    expect(AppState(prefs).isFavorite(q), isTrue);
  });
}
