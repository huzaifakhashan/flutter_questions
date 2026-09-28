import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'practice_screen.dart';
import 'question_list_screen.dart';

class TrackScreen extends StatelessWidget {
  const TrackScreen({super.key, required this.track});

  final Track track;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final questions = questionsOf(track);

    return Scaffold(
      appBar: AppBar(title: Text(track.label)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProgressHeader(
                title: track.label,
                known: state.knownCount(questions),
                total: questions.length,
                color: track.color,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: track.color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.style),
                      label: const Text('وضع التدريب'),
                      onPressed: () => showPracticePicker(context, track: track),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.list_alt),
                      label: Text('كل الأسئلة (${questions.length})'),
                      onPressed: () =>
                          openScreen(context, QuestionListScreen(track: track)),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SectionTitle('حسب المستوى'),
              for (final level in Level.values)
                _LevelCard(
                  track: track,
                  level: level,
                  questions: questions.where((q) => q.level == level),
                ),
              const SizedBox(height: 16),
              const SectionTitle('حسب الموضوع'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final c in track.categories)
                    ActionChip(
                      avatar: Icon(c.icon, size: 18),
                      label: Text(
                        '${c.label} (${questions.where((q) => q.category == c).length})',
                      ),
                      onPressed: () =>
                          openScreen(context, QuestionListScreen(category: c)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  const _LevelCard({
    required this.track,
    required this.level,
    required this.questions,
  });

  final Track track;
  final Level level;
  final Iterable<Question> questions;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final total = questions.length;
    final known = state.knownCount(questions);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: level.color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: level.color.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openScreen(
          context,
          QuestionListScreen(track: track, level: level),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: level.color,
                foregroundColor: Colors.white,
                child: Icon(level.icon),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أسئلة ${level.label}ة',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    ProgressBar(value: total == 0 ? 0 : known / total, color: level.color),
                    const SizedBox(height: 4),
                    Text(
                      '$known / $total',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}
