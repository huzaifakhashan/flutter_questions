import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';

/// Bottom sheet to pick which questions to practice.
/// Limited to [track] when given, otherwise covers every track.
Future<void> showPracticePicker(BuildContext context, {Track? track}) {
  final source = track == null ? allQuestions : questionsOf(track);
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      final state = AppScope.of(sheetContext);

      void start(Level? level) {
        final pool =
            source.where((q) => level == null || q.level == level).toList();
        final unknown = pool.where((q) => !state.isKnown(q)).toList();
        Navigator.pop(sheetContext);
        Navigator.push(
          context,
          MaterialPageRoute(
            // Prefer questions not memorised yet; fall back to all of them.
            builder: (_) =>
                PracticeScreen(questions: unknown.isEmpty ? pool : unknown),
          ),
        );
      }

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                track == null ? 'اختر المستوى' : 'تدريب ${track.label}',
                style: Theme.of(sheetContext).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'سيتم عرض الأسئلة التي لم تحفظها بعد بترتيب عشوائي',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.shuffle),
                title: const Text('كل المستويات'),
                onTap: () => start(null),
              ),
              for (final l in Level.values)
                ListTile(
                  leading: Icon(l.icon, color: l.color),
                  title: Text(l.label),
                  trailing: Text(
                    '${state.knownCount(source.where((q) => q.level == l))}'
                    ' / ${source.where((q) => q.level == l).length}',
                  ),
                  onTap: () => start(l),
                ),
            ],
          ),
        ),
      );
    },
  );
}

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key, required this.questions});

  final List<Question> questions;

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  late List<Question> _deck;
  final List<Question> _missed = [];
  int _index = 0;
  int _correct = 0;
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    _startWith(widget.questions);
  }

  void _startWith(List<Question> questions) {
    _deck = [...questions]..shuffle();
    _missed.clear();
    _index = 0;
    _correct = 0;
    _revealed = false;
  }

  void _answer(bool knewIt) {
    final state = AppScope.of(context);
    final q = _deck[_index];
    state.setKnown(q, knewIt);
    setState(() {
      if (knewIt) {
        _correct++;
      } else {
        _missed.add(q);
      }
      _index++;
      _revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final finished = _index >= _deck.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(finished ? 'النتيجة' : 'تدريب ${_index + 1} / ${_deck.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: _deck.isEmpty ? 1 : _index / _deck.length,
          ),
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: finished ? _buildResult() : _buildCard(_deck[_index]),
          ),
        ),
      ),
    );
  }

  Widget _buildCard(Question q) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      key: ValueKey(q.id),
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          elevation: 0,
          color: scheme.primaryContainer,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Wrap(
                  spacing: 8,
                  alignment: WrapAlignment.center,
                  runSpacing: 8,
                  children: [
                    TrackBadge(q.track),
                    LevelBadge(q.level),
                    CategoryBadge(q.category),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  q.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onPrimaryContainer,
                        height: 1.4,
                      ),
                ),
                const SizedBox(height: 12),
                if (!_revealed)
                  Text(
                    'فكّر بالجواب بصوت عالٍ كأنك في المقابلة، ثم اكشفه.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: scheme.onPrimaryContainer.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        if (!_revealed)
          FilledButton.icon(
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            icon: const Icon(Icons.visibility),
            label: const Text('أظهر الجواب'),
            onPressed: () => setState(() => _revealed = true),
          )
        else ...[
          InfoSection(
            title: 'الجواب',
            icon: Icons.lightbulb_outline,
            color: Colors.green,
            child: BodyText(q.answer),
          ),
          const SizedBox(height: 12),
          ExpansionTile(
            title: const Text('عرض الشرح والمثال'),
            leading: const Icon(Icons.menu_book_outlined),
            shape: const Border(),
            childrenPadding: const EdgeInsets.only(bottom: 8),
            children: [
              InfoSection(
                title: 'الشرح',
                icon: Icons.menu_book_outlined,
                child: BodyText(q.explanation),
              ),
              if (q.code != null) ...[
                const SizedBox(height: 12),
                CodeBlock(q.code!),
              ],
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'هل عرفت الجواب؟',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.close),
                  label: const Text('ما عرفته'),
                  onPressed: () => _answer(false),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.check),
                  label: const Text('عرفته'),
                  onPressed: () => _answer(true),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  Widget _buildResult() {
    final total = _deck.length;
    final percent = total == 0 ? 100 : (_correct * 100 / total).round();
    final (emoji, message) = switch (percent) {
      >= 80 => ('🏆', 'ممتاز! أنت جاهز للمقابلة'),
      >= 50 => ('💪', 'جيد جداً، راجع الأسئلة التي فاتتك'),
      _ => ('📚', 'تحتاج لمراجعة أكثر، لا تستسلم!'),
    };

    return ListView(
      key: const ValueKey('result'),
      padding: const EdgeInsets.all(24),
      children: [
        Text(emoji, textAlign: TextAlign.center, style: const TextStyle(fontSize: 64)),
        const SizedBox(height: 12),
        Text(
          '$_correct / $total',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 24),
        if (_missed.isNotEmpty) ...[
          FilledButton.icon(
            icon: const Icon(Icons.replay),
            label: Text('أعد الأسئلة التي فاتتك (${_missed.length})'),
            onPressed: () => setState(() => _startWith([..._missed])),
          ),
          const SizedBox(height: 16),
          Text(
            'الأسئلة التي فاتتك:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          for (final q in _missed)
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(q.level.icon, color: q.level.color),
              title: Text(q.question),
            ),
        ],
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('رجوع للرئيسية'),
        ),
      ],
    );
  }
}
