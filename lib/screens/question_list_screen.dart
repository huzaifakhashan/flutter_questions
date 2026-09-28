import 'package:flutter/material.dart';

import '../data/questions.dart';
import '../models/question.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';
import 'question_detail_screen.dart';

class QuestionListScreen extends StatefulWidget {
  const QuestionListScreen({
    super.key,
    this.track,
    this.level,
    this.category,
    this.favoritesOnly = false,
  });

  final Track? track;
  final Level? level;
  final Category? category;
  final bool favoritesOnly;

  @override
  State<QuestionListScreen> createState() => _QuestionListScreenState();
}

class _QuestionListScreenState extends State<QuestionListScreen> {
  late Level? _level = widget.level;
  String _query = '';

  String get _title {
    if (widget.favoritesOnly) return 'المفضلة';
    if (widget.category != null) return widget.category!.label;
    if (widget.track != null) return widget.track!.label;
    return 'كل الأسئلة';
  }

  List<Question> _filter(AppState state) {
    final q = _query.trim().toLowerCase();
    final source = widget.favoritesOnly ? state.favorites : allQuestions;
    return source.where((x) {
      if (widget.track != null && x.track != widget.track) return false;
      if (_level != null && x.level != _level) return false;
      if (widget.category != null && x.category != widget.category) {
        return false;
      }
      if (q.isEmpty) return true;
      return x.question.toLowerCase().contains(q) ||
          x.answer.toLowerCase().contains(q) ||
          x.explanation.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final items = _filter(state);

    return Scaffold(
      appBar: AppBar(title: Text(_title)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                child: SearchBar(
                  hintText: 'ابحث في الأسئلة...',
                  leading: const Icon(Icons.search),
                  elevation: const WidgetStatePropertyAll(0),
                  onChanged: (v) => setState(() => _query = v),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  children: [
                    ChoiceChip(
                      label: const Text('الكل'),
                      selected: _level == null,
                      onSelected: (_) => setState(() => _level = null),
                    ),
                    for (final l in Level.values) ...[
                      const SizedBox(width: 8),
                      ChoiceChip(
                        avatar: Icon(l.icon, size: 16, color: l.color),
                        label: Text(l.label),
                        selected: _level == l,
                        onSelected: (_) => setState(() => _level = l),
                      ),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: items.isEmpty
                    ? _EmptyView(favorites: widget.favoritesOnly)
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        itemCount: items.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 8),
                        itemBuilder: (context, i) => _QuestionTile(
                          question: items[i],
                          index: i,
                          showTrack: widget.track == null &&
                              widget.category == null,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => QuestionDetailScreen(
                                questions: items,
                                initialIndex: i,
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionTile extends StatelessWidget {
  const _QuestionTile({
    required this.question,
    required this.index,
    required this.onTap,
    this.showTrack = false,
  });

  final Question question;
  final int index;
  final bool showTrack;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final scheme = Theme.of(context).colorScheme;
    final known = state.isKnown(question);

    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor:
                    known ? Colors.green : question.level.color.withValues(alpha: 0.15),
                foregroundColor: known ? Colors.white : question.level.color,
                child: known
                    ? const Icon(Icons.check, size: 18)
                    : Text(
                        '${index + 1}',
                        style: const TextStyle(fontSize: 13),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question.question,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: [
                        if (showTrack) TrackBadge(question.track),
                        LevelBadge(question.level),
                        CategoryBadge(question.category),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'مفضلة',
                icon: Icon(
                  state.isFavorite(question) ? Icons.star : Icons.star_border,
                  color: state.isFavorite(question) ? Colors.amber : null,
                ),
                onPressed: () => state.toggleFavorite(question),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView({required this.favorites});

  final bool favorites;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              favorites ? Icons.star_border : Icons.search_off,
              size: 56,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              favorites
                  ? 'لا توجد أسئلة مفضلة بعد.\nاضغط على النجمة بجانب أي سؤال لإضافته.'
                  : 'لا توجد نتائج',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
