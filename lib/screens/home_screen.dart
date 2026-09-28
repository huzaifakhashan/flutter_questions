import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'practice_screen.dart';
import 'question_list_screen.dart';
import 'track_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final theme = Theme.of(context);
    final known = state.knownCount(allQuestions);

    return Scaffold(
      appBar: AppBar(
        title: const Text('أسئلة المقابلات'),
        actions: [
          IconButton(
            tooltip: 'الوضع الليلي',
            icon: Icon(theme.brightness == Brightness.dark
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () => state.toggleTheme(theme.brightness),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ProgressHeader(
                title: 'جاهز للمقابلة؟',
                known: known,
                total: allQuestions.length,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.icon(
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.shuffle),
                      label: const Text('تدريب شامل'),
                      onPressed: () => showPracticePicker(context),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      icon: const Icon(Icons.star_outline),
                      label: Text('المفضلة (${state.favorites.length})'),
                      onPressed: () => openScreen(
                        context,
                        const QuestionListScreen(favoritesOnly: true),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const SectionTitle('المسارات'),
              for (final track in Track.values) _TrackCard(track),
              const SizedBox(height: 8),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.search),
                title: const Text('ابحث في كل الأسئلة'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => openScreen(context, const QuestionListScreen()),
              ),
              if (known > 0)
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.restart_alt),
                  title: const Text('تصفير التقدم'),
                  onTap: () => _confirmReset(context, state),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _confirmReset(BuildContext context, AppState state) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تصفير التقدم؟'),
        content: const Text('سيتم إلغاء علامة "حفظتها" من كل الأسئلة.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('إلغاء'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('تصفير'),
          ),
        ],
      ),
    );
    if (ok ?? false) state.resetProgress();
  }
}

class _TrackCard extends StatelessWidget {
  const _TrackCard(this.track);

  final Track track;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final questions = questionsOf(track);
    final total = questions.length;
    final known = state.knownCount(questions);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),
      color: track.color.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: track.color.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => openScreen(context, TrackScreen(track: track)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: track.color,
                foregroundColor: Colors.white,
                child: Icon(track.icon),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.label,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      track.subtitle,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 8),
                    ProgressBar(
                      value: total == 0 ? 0 : known / total,
                      color: track.color,
                    ),
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
