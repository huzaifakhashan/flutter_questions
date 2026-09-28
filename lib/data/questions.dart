import '../models/question.dart';
import 'database_questions.dart';
import 'flutter_questions.dart';
import 'general_questions.dart';
import 'laravel_questions.dart';

const List<Question> allQuestions = [
  ...flutterQuestions,
  ...laravelQuestions,
  ...databaseQuestions,
  ...generalQuestions,
];

List<Question> questionsOf(Track track) =>
    allQuestions.where((q) => q.track == track).toList();
