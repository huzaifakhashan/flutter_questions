import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/question.dart';

class LevelBadge extends StatelessWidget {
  const LevelBadge(this.level, {super.key});

  final Level level;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      color: level.color,
      icon: level.icon,
      label: level.label,
    );
  }
}

class CategoryBadge extends StatelessWidget {
  const CategoryBadge(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return _Pill(
      color: Theme.of(context).colorScheme.primary,
      icon: category.icon,
      label: category.label,
    );
  }
}

class TrackBadge extends StatelessWidget {
  const TrackBadge(this.track, {super.key});

  final Track track;

  @override
  Widget build(BuildContext context) {
    return _Pill(color: track.color, icon: track.icon, label: track.label);
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.color, required this.icon, required this.label});

  final Color color;
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

/// A titled block used for the answer / explanation sections.
class InfoSection extends StatelessWidget {
  const InfoSection({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.color,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final accent = color ?? scheme.primary;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: accent.withValues(alpha: 0.35)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: accent, size: 20),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

/// Code snippet, always left-to-right, with a copy button.
class CodeBlock extends StatelessWidget {
  const CodeBlock(this.code, {super.key});

  final String code;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 4, 0),
            child: Row(
              children: [
                const Icon(Icons.code, color: Colors.white54, size: 18),
                const SizedBox(width: 6),
                const Text('مثال', style: TextStyle(color: Colors.white70)),
                const Spacer(),
                IconButton(
                  tooltip: 'نسخ',
                  icon: const Icon(Icons.copy, color: Colors.white54, size: 18),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: code));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تم نسخ الكود')),
                    );
                  },
                ),
              ],
            ),
          ),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SelectableText(
                code,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontFamilyFallback: ['Consolas', 'Menlo', 'Courier New'],
                  color: Color(0xFFCDD6F4),
                  fontSize: 13,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyText extends StatelessWidget {
  const BodyText(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectableText(
      text,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.7),
    );
  }
}

void openScreen(BuildContext context, Widget screen) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: value,
        minHeight: 6,
        color: color,
        backgroundColor: color.withValues(alpha: 0.15),
      ),
    );
  }
}

/// Gradient banner with a circular progress indicator.
class ProgressHeader extends StatelessWidget {
  const ProgressHeader({
    super.key,
    required this.title,
    required this.known,
    required this.total,
    this.color,
  });

  final String title;
  final int known;
  final int total;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = color ?? scheme.primary;
    const onBase = Colors.white;
    final percent = total == 0 ? 0 : (known * 100 / total).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [base, Color.lerp(base, Colors.black, 0.35)!],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: onBase,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'حفظت $known من $total سؤال',
                  style: TextStyle(color: onBase.withValues(alpha: 0.9)),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 64,
            height: 64,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CircularProgressIndicator(
                  value: total == 0 ? 0 : known / total,
                  strokeWidth: 6,
                  color: onBase,
                  backgroundColor: onBase.withValues(alpha: 0.25),
                ),
                Center(
                  child: Text(
                    '$percent%',
                    style: const TextStyle(
                      color: onBase,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
