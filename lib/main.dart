import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'state/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(FlutterQuestionsApp(state: AppState(prefs)));
}

class FlutterQuestionsApp extends StatelessWidget {
  const FlutterQuestionsApp({super.key, required this.state});

  final AppState state;

  static const _seed = Color(0xFF0175C2);

  ThemeData _theme(Brightness brightness) => ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _seed,
          brightness: brightness,
        ),
        appBarTheme: const AppBarTheme(centerTitle: true),
      );

  @override
  Widget build(BuildContext context) {
    return AppScope(
      state: state,
      child: ListenableBuilder(
        listenable: state,
        builder: (context, _) => MaterialApp(
          title: 'أسئلة المقابلات',
          debugShowCheckedModeBanner: false,
          theme: _theme(Brightness.light),
          darkTheme: _theme(Brightness.dark),
          themeMode: state.themeMode,
          builder: (context, child) => Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
