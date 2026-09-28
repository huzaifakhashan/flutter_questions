import 'package:flutter/material.dart';

enum Level {
  easy('سهل', Color(0xFF2E7D32), Icons.sentiment_satisfied_alt),
  medium('متوسط', Color(0xFFEF6C00), Icons.trending_up),
  hard('صعب', Color(0xFFC62828), Icons.local_fire_department);

  const Level(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;
}

/// A big subject area the user can study on its own (Flutter, Laravel...).
enum Track {
  flutter('Flutter', 'Dart و Widgets وإدارة الحالة والأداء', Color(0xFF0175C2),
      Icons.flutter_dash),
  laravel('Laravel', 'PHP و Eloquent والـ API والأمان', Color(0xFFE53935),
      Icons.local_fire_department_outlined),
  database('قواعد البيانات', 'SQL والتصميم والفهارس والمعاملات',
      Color(0xFF6A1B9A), Icons.storage),
  general('أسئلة عامة', 'Git و GitHub و OOP و HTTP والأمان', Color(0xFF00897B),
      Icons.lightbulb_outline);

  const Track(this.label, this.subtitle, this.color, this.icon);

  final String label;
  final String subtitle;
  final Color color;
  final IconData icon;

  List<Category> get categories =>
      Category.values.where((c) => c.track == this).toList();
}

enum Category {
  // Flutter
  dart(Track.flutter, 'Dart', Icons.code),
  widgets(Track.flutter, 'Widgets', Icons.widgets_outlined),
  state(Track.flutter, 'إدارة الحالة', Icons.sync_alt),
  async(Track.flutter, 'Async', Icons.hourglass_bottom),
  navigation(Track.flutter, 'التنقل', Icons.alt_route),
  performance(Track.flutter, 'الأداء', Icons.speed),
  architecture(Track.flutter, 'المعمارية', Icons.account_tree_outlined),
  internals(Track.flutter, 'آلية العمل الداخلية', Icons.memory),
  testing(Track.flutter, 'الاختبار', Icons.bug_report_outlined),
  platform(Track.flutter, 'المنصات والنشر', Icons.devices_other),

  // Laravel
  php(Track.laravel, 'PHP', Icons.data_object),
  laravelBasics(Track.laravel, 'أساسيات Laravel', Icons.school_outlined),
  eloquent(Track.laravel, 'Eloquent', Icons.table_chart_outlined),
  laravelApi(Track.laravel, 'API والمصادقة', Icons.api),
  laravelSecurity(Track.laravel, 'الأمان', Icons.shield_outlined),
  laravelAdvanced(Track.laravel, 'Queues و Cache ومتقدم', Icons.bolt),
  laravelTesting(Track.laravel, 'الاختبار', Icons.fact_check_outlined),

  // Databases
  sql(Track.database, 'SQL', Icons.terminal),
  joins(Track.database, 'Joins والاستعلامات', Icons.join_inner),
  dbDesign(Track.database, 'التصميم والتطبيع', Icons.schema_outlined),
  indexes(Track.database, 'الفهارس والأداء', Icons.speed),
  transactions(Track.database, 'المعاملات والتزامن', Icons.lock_outline),
  nosql(Track.database, 'NoSQL والتوسع', Icons.hub_outlined),

  // General
  git(Track.general, 'Git و GitHub', Icons.merge_type),
  oop(Track.general, 'OOP و SOLID', Icons.category_outlined),
  patterns(Track.general, 'Design Patterns', Icons.extension_outlined),
  web(Track.general, 'HTTP والويب', Icons.language),
  security(Track.general, 'الأمان', Icons.security),
  dsa(Track.general, 'هياكل البيانات والخوارزميات', Icons.account_tree),
  practices(Track.general, 'ممارسات وأدوات', Icons.handyman_outlined),
  soft(Track.general, 'أسئلة شخصية', Icons.record_voice_over_outlined);

  const Category(this.track, this.label, this.icon);

  final Track track;
  final String label;
  final IconData icon;
}

class Question {
  const Question({
    required this.id,
    required this.level,
    required this.category,
    required this.question,
    required this.answer,
    required this.explanation,
    this.code,
  });

  final int id;
  final Level level;
  final Category category;
  final String question;

  /// Short answer you can say in the interview.
  final String answer;

  /// A bit more detail to actually understand it.
  final String explanation;

  final String? code;

  Track get track => category.track;
}
