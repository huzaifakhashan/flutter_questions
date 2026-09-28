import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/questions.dart';
import '../models/question.dart';

class AppState extends ChangeNotifier {
  AppState(this._prefs)
      : _favorites = _load(_prefs, _favoritesKey),
        _known = _load(_prefs, _knownKey),
        _darkMode = _prefs.getBool(_darkKey);

  static const _favoritesKey = 'favorites';
  static const _knownKey = 'known';
  static const _darkKey = 'dark_mode';

  final SharedPreferences _prefs;
  final Set<int> _favorites;
  final Set<int> _known;
  bool? _darkMode;

  static Set<int> _load(SharedPreferences prefs, String key) =>
      (prefs.getStringList(key) ?? []).map(int.parse).toSet();

  ThemeMode get themeMode => switch (_darkMode) {
        null => ThemeMode.system,
        true => ThemeMode.dark,
        false => ThemeMode.light,
      };

  void toggleTheme(Brightness current) {
    _darkMode = current != Brightness.dark;
    _prefs.setBool(_darkKey, _darkMode!);
    notifyListeners();
  }

  bool isFavorite(Question q) => _favorites.contains(q.id);
  bool isKnown(Question q) => _known.contains(q.id);

  List<Question> get favorites =>
      allQuestions.where((q) => _favorites.contains(q.id)).toList();

  void toggleFavorite(Question q) {
    _toggle(_favorites, q.id);
    _save(_favoritesKey, _favorites);
  }

  void setKnown(Question q, bool known) {
    if (known ? !_known.add(q.id) : !_known.remove(q.id)) return;
    _save(_knownKey, _known);
  }

  int knownCount(Iterable<Question> questions) =>
      questions.where(isKnown).length;

  void resetProgress() {
    _known.clear();
    _save(_knownKey, _known);
  }

  void _toggle(Set<int> set, int id) {
    if (!set.remove(id)) set.add(id);
  }

  void _save(String key, Set<int> ids) {
    _prefs.setStringList(key, ids.map((e) => '$e').toList());
    notifyListeners();
  }
}

class AppScope extends InheritedNotifier<AppState> {
  const AppScope({super.key, required AppState state, required super.child})
      : super(notifier: state);

  static AppState of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppScope>()!.notifier!;
}
