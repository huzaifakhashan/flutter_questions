import 'package:flutter/material.dart';

import '../models/question.dart';
import '../state/app_state.dart';
import '../widgets/common.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({
    super.key,
    required this.questions,
    required this.initialIndex,
  });

  final List<Question> questions;
  final int initialIndex;

  @override
  State<QuestionDetailScreen> createState() => _QuestionDetailScreenState();
}

class _QuestionDetailScreenState extends State<QuestionDetailScreen> {
  late final PageController _controller =
      PageController(initialPage: widget.initialIndex);
  late int _index = widget.initialIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goTo(int page) => _controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );

  @override
  Widget build(BuildContext context) {
    final state = AppScope.of(context);
    final current = widget.questions[_index];
    final known = state.isKnown(current);
    final fav = state.isFavorite(current);

    return Scaffold(
      appBar: AppBar(
        title: Text('${_index + 1} / ${widget.questions.length}'),
        actions: [
          IconButton(
            tooltip: 'مفضلة',
            icon: Icon(
              fav ? Icons.star : Icons.star_border,
              color: fav ? Colors.amber : null,
            ),
            onPressed: () => state.toggleFavorite(current),
          ),
        ],
      ),
      body: PageView.builder(
        controller: _controller,
        itemCount: widget.questions.length,
        onPageChanged: (i) => setState(() => _index = i),
        itemBuilder: (context, i) => _QuestionPage(widget.questions[i]),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
          child: Row(
            children: [
              IconButton.filledTonal(
                tooltip: 'السابق',
                icon: const Icon(Icons.arrow_back),
                onPressed: _index > 0 ? () => _goTo(_index - 1) : null,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: known
                    ? FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: Colors.green,
                          foregroundColor: Colors.white,
                        ),
                        icon: const Icon(Icons.check_circle),
                        label: const Text('حفظتها'),
                        onPressed: () => state.setKnown(current, false),
                      )
                    : OutlinedButton.icon(
                        icon: const Icon(Icons.check_circle_outline),
                        label: const Text('علّمها كمحفوظة'),
                        onPressed: () {
                          state.setKnown(current, true);
                          if (_index < widget.questions.length - 1) {
                            _goTo(_index + 1);
                          }
                        },
                      ),
              ),
              const SizedBox(width: 8),
              IconButton.filledTonal(
                tooltip: 'التالي',
                icon: const Icon(Icons.arrow_forward),
                onPressed: _index < widget.questions.length - 1
                    ? () => _goTo(_index + 1)
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionPage extends StatelessWidget {
  const _QuestionPage(this.question);

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 720),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                TrackBadge(question.track),
                LevelBadge(question.level),
                CategoryBadge(question.category),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    height: 1.4,
                  ),
            ),
            const SizedBox(height: 16),
            InfoSection(
              title: 'الجواب',
              icon: Icons.lightbulb_outline,
              color: Colors.green,
              child: BodyText(question.answer),
            ),
            const SizedBox(height: 12),
            InfoSection(
              title: 'الشرح',
              icon: Icons.menu_book_outlined,
              child: BodyText(question.explanation),
            ),
            if (question.code != null) ...[
              const SizedBox(height: 12),
              CodeBlock(question.code!),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
