import '../models/question.dart';

const List<Question> flutterQuestions = [
  // ─────────────────────────── سهل ───────────────────────────
  Question(
    id: 1,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما هو Flutter؟',
    answer:
        'Flutter هو إطار عمل مفتوح المصدر من Google لبناء تطبيقات لعدة منصات (Android و iOS و Web و Desktop) من كود واحد مكتوب بلغة Dart.',
    explanation:
        '• لا يعتمد على عناصر واجهة النظام الأصلية، بل يرسم كل بكسل بنفسه عبر محرك رسم (Impeller / Skia).\n'
        '• لذلك يكون شكل التطبيق متطابقاً على كل المنصات والأداء قريب من الأصلي.\n'
        '• كل شيء في الواجهة عبارة عن Widget.',
  ),
  Question(
    id: 2,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما الفرق بين StatelessWidget و StatefulWidget؟',
    answer:
        'StatelessWidget لا يملك حالة تتغير، يُبنى مرة حسب المُدخلات. StatefulWidget يملك كائن State يحتفظ ببيانات يمكن أن تتغير، ونستدعي setState لإعادة بنائه.',
    explanation:
        '• Stateless: مثل نص أو أيقونة ثابتة، يعتمد فقط على الخصائص الممررة له.\n'
        '• Stateful: مثل عداد أو Checkbox، الحالة محفوظة في كلاس State منفصل يعيش أطول من الـ Widget نفسه.\n'
        '• القاعدة: ابدأ بـ Stateless ولا تستخدم Stateful إلا عند الحاجة.',
    code: r'''class Counter extends StatefulWidget {
  const Counter({super.key});
  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => setState(() => count++),
      child: Text('$count'),
    );
  }
}''',
  ),
  Question(
    id: 3,
    level: Level.easy,
    category: Category.dart,
    question: 'لماذا يستخدم Flutter لغة Dart؟',
    answer:
        'لأن Dart تدعم الترجمة JIT أثناء التطوير (مما يتيح Hot Reload) و AOT عند الإصدار (مما يعطي أداءً عالياً)، وهي سهلة التعلم وتدعم Null Safety.',
    explanation:
        '• JIT (Just In Time): ترجمة أثناء التشغيل ← تعديلات فورية أثناء التطوير.\n'
        '• AOT (Ahead Of Time): ترجمة مسبقة لكود آلة ← تشغيل سريع بدون مفسّر.\n'
        '• فيها Garbage Collector سريع مناسب لإنشاء كائنات Widgets كثيرة قصيرة العمر.',
  ),
  Question(
    id: 4,
    level: Level.easy,
    category: Category.platform,
    question: 'ما الفرق بين Hot Reload و Hot Restart؟',
    answer:
        'Hot Reload يحقن الكود الجديد ويعيد بناء الواجهة مع الحفاظ على الحالة. Hot Restart يعيد تشغيل التطبيق من البداية ويمسح الحالة، لكنه أسرع من إعادة التشغيل الكاملة.',
    explanation:
        '• Hot Reload لا يعيد تنفيذ main() ولا initState().\n'
        '• تحتاج Hot Restart عند تغيير المتغيرات العامة (global/static) أو main أو تعريفات enum والـ generics.\n'
        '• تغيير الكود الأصلي (Kotlin/Swift) أو إضافة plugin يحتاج إعادة بناء كاملة.',
  ),
  Question(
    id: 5,
    level: Level.easy,
    category: Category.dart,
    question: 'ما الفرق بين final و const؟',
    answer:
        'كلاهما يُسند مرة واحدة فقط. final تُحدد قيمته وقت التشغيل، أما const فيجب أن تكون قيمته معروفة وقت الترجمة (compile-time).',
    explanation:
        '• final now = DateTime.now(); ✔️\n'
        '• const now = DateTime.now(); ❌ لأن القيمة غير معروفة وقت الترجمة.\n'
        '• كائنات const يتم إنشاؤها مرة واحدة ومشاركتها (canonicalized)، لذلك const Widgets لا يعاد بناؤها بلا داعٍ.',
    code: r'''final name = getUserName(); // وقت التشغيل
const pi = 3.14;             // وقت الترجمة
const padding = EdgeInsets.all(8); // نفس الكائن في كل مكان''',
  ),
  Question(
    id: 6,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما هو الـ Widget؟',
    answer:
        'الـ Widget هو وصف غير قابل للتغيير (immutable) لجزء من الواجهة. في Flutter كل شيء Widget: النصوص، الأزرار، الـ Padding، وحتى التطبيق نفسه.',
    explanation:
        '• الـ Widget خفيف جداً، مجرد إعدادات (configuration)، وليس هو ما يُرسم فعلياً.\n'
        '• عند تغيير الحالة يُنشأ Widget جديد ويُقارن مع القديم.\n'
        '• نبني الواجهات بتركيب (composition) Widgets صغيرة داخل بعضها.',
  ),
  Question(
    id: 7,
    level: Level.easy,
    category: Category.state,
    question: 'ماذا تفعل الدالة setState؟',
    answer:
        'تُعلم Flutter بأن حالة الـ State تغيّرت، فتُعلَّم الـ Widget بأنه يحتاج إعادة بناء (dirty) ويُستدعى build في الإطار (frame) التالي.',
    explanation:
        '• يجب تغيير البيانات داخل الدالة الممررة أو قبلها مباشرة.\n'
        '• لا تستدعها بعد dispose (تحقق من mounted).\n'
        '• تعيد بناء هذا الـ Widget وأبنائه فقط، لذلك اجعل الـ Stateful Widget صغيراً قدر الإمكان.',
  ),
  Question(
    id: 8,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما الفرق بين Row و Column؟ وما هو mainAxis و crossAxis؟',
    answer:
        'Row يرتب الأبناء أفقياً و Column عمودياً. mainAxis هو محور الترتيب الأساسي، و crossAxis هو المحور المتعامد عليه.',
    explanation:
        '• في Row: المحور الرئيسي أفقي، والعرضي عمودي.\n'
        '• في Column: المحور الرئيسي عمودي، والعرضي أفقي.\n'
        '• mainAxisAlignment للتوزيع (start, center, spaceBetween...) و crossAxisAlignment للمحاذاة.',
    code: r'''Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [Text('A'), Text('B'), Text('C')],
)''',
  ),
  Question(
    id: 9,
    level: Level.easy,
    category: Category.widgets,
    question: 'متى أستخدم SizedBox ومتى Container؟',
    answer:
        'SizedBox لتحديد حجم أو إضافة مسافة فقط، وهو أخف ويمكن أن يكون const. Container يجمع عدة خصائص (padding, margin, color, decoration, alignment...).',
    explanation:
        '• للمسافات بين العناصر: const SizedBox(height: 16).\n'
        '• Container في الحقيقة مركّب من Widgets أصغر (Padding, DecoratedBox, ConstrainedBox...).\n'
        '• إذا احتجت خاصية واحدة فقط استخدم الـ Widget المخصص لها (Padding, ColoredBox...).',
  ),
  Question(
    id: 10,
    level: Level.easy,
    category: Category.platform,
    question: 'ما هو ملف pubspec.yaml؟',
    answer:
        'ملف إعدادات المشروع: يحتوي اسم التطبيق والإصدار ونسخة الـ SDK والمكتبات (dependencies) والـ assets والخطوط.',
    explanation:
        '• dependencies: مكتبات يحتاجها التطبيق.\n'
        '• dev_dependencies: مكتبات للتطوير فقط (مثل الاختبار و lints).\n'
        '• بعد التعديل ننفذ flutter pub get.\n'
        '• version: 1.2.0+5 ← الجزء الأول versionName و بعد + هو build number.',
  ),
  Question(
    id: 11,
    level: Level.easy,
    category: Category.dart,
    question: 'اشرح Null Safety والرموز ? و ! و ?? و late.',
    answer:
        'Null Safety تعني أن المتغيرات لا تقبل null إلا إذا صرّحنا بذلك بـ ?. الرمز ! يؤكد أن القيمة ليست null، و ?? يعطي قيمة بديلة، و late لتأجيل التهيئة.',
    explanation:
        '• String? name ← يقبل null.\n'
        '• name! ← "أنا متأكد أنه ليس null" وإلا يرمي استثناء، فتجنب استخدامه بكثرة.\n'
        '• name ?? "Guest" ← قيمة بديلة.\n'
        '• user?.name ← وصول آمن.\n'
        '• late ← متغير غير nullable سيُهيأ لاحقاً قبل الاستخدام.',
    code: r'''String? name;
print(name?.length);      // null
print(name ?? 'Guest');   // Guest
late final String token;  // يُهيأ لاحقاً''',
  ),
  Question(
    id: 12,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما الفرق بين Expanded و Flexible؟',
    answer:
        'كلاهما داخل Row/Column/Flex. Expanded يجبر الابن على ملء كل المساحة المتبقية، أما Flexible فيسمح للابن أن يأخذ مساحة أقل حسب حجمه.',
    explanation:
        '• Expanded = Flexible(fit: FlexFit.tight).\n'
        '• Flexible الافتراضي fit: FlexFit.loose.\n'
        '• خاصية flex تحدد نسبة توزيع المساحة بين الأبناء.',
    code: r'''Row(children: [
  Expanded(flex: 2, child: Container(color: Colors.red)),
  Expanded(flex: 1, child: Container(color: Colors.blue)),
])''',
  ),
  Question(
    id: 13,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما هو BuildContext؟',
    answer:
        'هو مرجع لموقع الـ Widget في شجرة الواجهة (هو فعلياً الـ Element). نستخدمه للوصول للأعلى في الشجرة مثل Theme.of(context) و Navigator.of(context).',
    explanation:
        '• كل Widget له context خاص به.\n'
        '• البحث بـ .of(context) يصعد للأعلى فقط، لذلك context الـ Widget الذي أنشأ Scaffold لا يرى هذا الـ Scaffold.\n'
        '• الحل: استخدام Builder أو فصل الـ Widget.',
  ),
  Question(
    id: 14,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما وظيفة MaterialApp و Scaffold؟',
    answer:
        'MaterialApp هو جذر التطبيق ويوفر الثيم والتنقل واللغات. Scaffold يوفر هيكل الصفحة: AppBar و body و FloatingActionButton و Drawer و BottomNavigationBar.',
    explanation:
        '• عادة يوجد MaterialApp واحد، و Scaffold لكل شاشة.\n'
        '• البديل لتصميم iOS هو CupertinoApp و CupertinoPageScaffold.',
  ),
  Question(
    id: 15,
    level: Level.easy,
    category: Category.performance,
    question: 'ما الفرق بين ListView و ListView.builder؟',
    answer:
        'ListView العادي يبني كل العناصر مرة واحدة. ListView.builder يبني العناصر بشكل كسول (lazy) فقط عند ظهورها على الشاشة، لذلك هو الأفضل للقوائم الطويلة.',
    explanation:
        '• للقوائم القصيرة الثابتة: ListView(children: [...]).\n'
        '• للقوائم الطويلة أو من API: ListView.builder.\n'
        '• ListView.separated لإضافة فواصل بين العناصر.',
    code: r'''ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, i) => ListTile(title: Text(items[i])),
)''',
  ),
  Question(
    id: 16,
    level: Level.easy,
    category: Category.dart,
    question: 'ما الفرق بين var و dynamic و Object؟',
    answer:
        'var يستنتج النوع مرة واحدة ولا يتغير. dynamic يلغي فحص الأنواع ويمكن أن يحمل أي نوع. Object يقبل أي نوع لكن مع فحص الأنواع، ويجب التحويل قبل استدعاء دوال خاصة.',
    explanation:
        '• var x = 5; x = "a"; ❌ خطأ ترجمة.\n'
        '• dynamic x = 5; x = "a"; ✔️ لكن الأخطاء تظهر وقت التشغيل فقط.\n'
        '• Object x = "a"; x.length ❌ لازم (x as String).length.\n'
        '• تجنب dynamic إلا للضرورة (مثل JSON).',
  ),
  Question(
    id: 17,
    level: Level.easy,
    category: Category.navigation,
    question: 'كيف أنتقل بين الشاشات في Flutter؟',
    answer:
        'باستخدام Navigator الذي يعمل كـ Stack: push لإضافة شاشة، و pop للرجوع. ويمكن إرجاع قيمة من الشاشة عند pop.',
    explanation:
        '• Navigator.push(context, MaterialPageRoute(builder: ...)).\n'
        '• Navigator.pop(context, result) لإرجاع نتيجة.\n'
        '• pushReplacement لاستبدال الشاشة الحالية (مثل بعد تسجيل الدخول).\n'
        '• في المشاريع الكبيرة نستخدم go_router.',
    code: r'''final result = await Navigator.push<bool>(
  context,
  MaterialPageRoute(builder: (_) => const DetailsPage()),
);

// داخل DetailsPage
Navigator.pop(context, true);''',
  ),
  Question(
    id: 18,
    level: Level.easy,
    category: Category.widgets,
    question: 'متى أستخدم Stack و Positioned؟',
    answer:
        'Stack يضع العناصر فوق بعضها (طبقات). Positioned يحدد مكان عنصر داخل Stack بالنسبة للحواف (top, left, right, bottom).',
    explanation:
        '• مثال: صورة وفوقها نص أو شارة (badge) على أيقونة.\n'
        '• العنصر الأخير في القائمة يظهر في الأعلى.\n'
        '• Positioned.fill لملء الـ Stack بالكامل.',
    code: r'''Stack(children: [
  Image.asset('assets/bg.png'),
  Positioned(
    bottom: 8, right: 8,
    child: Text('عنوان'),
  ),
])''',
  ),
  Question(
    id: 19,
    level: Level.easy,
    category: Category.async,
    question: 'ما هو Future وكيف نستخدم async / await؟',
    answer:
        'Future يمثل قيمة ستتوفر لاحقاً (مثل نتيجة طلب شبكة). async تجعل الدالة تُرجع Future، و await تنتظر النتيجة بدون تجميد الواجهة.',
    explanation:
        '• await لا تحجب الـ UI، بل تسمح للـ event loop بمتابعة العمل.\n'
        '• نلتقط الأخطاء بـ try / catch.\n'
        '• Future.wait لتنفيذ عدة Futures بالتوازي.',
    code: r'''Future<User> loadUser() async {
  try {
    final res = await http.get(Uri.parse(url));
    return User.fromJson(jsonDecode(res.body));
  } catch (e) {
    throw Exception('فشل التحميل');
  }
}''',
  ),
  Question(
    id: 20,
    level: Level.easy,
    category: Category.widgets,
    question: 'ما هي وظيفة main() و runApp()؟',
    answer:
        'main() هي نقطة بداية أي برنامج Dart. runApp() تأخذ الـ Widget الجذر وتجعله يملأ الشاشة وتبدأ عملية الرسم.',
    explanation:
        '• إذا احتجت تنفيذ كود async قبل runApp (مثل Firebase) استدعِ أولاً WidgetsFlutterBinding.ensureInitialized().',
    code: r'''Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}''',
  ),

  // ─────────────────────────── متوسط ───────────────────────────
  Question(
    id: 21,
    level: Level.medium,
    category: Category.widgets,
    question: 'اشرح دورة حياة StatefulWidget.',
    answer:
        'createState ← initState ← didChangeDependencies ← build ← (didUpdateWidget / setState ← build) ← deactivate ← dispose.',
    explanation:
        '• initState: مرة واحدة، للتهيئة (controllers, subscriptions). لا تستخدم فيها context.of.\n'
        '• didChangeDependencies: بعد initState وعند تغير InheritedWidget نعتمد عليه.\n'
        '• didUpdateWidget: عندما يعيد الأب البناء بإعدادات جديدة لنفس الـ Widget.\n'
        '• dispose: للتنظيف وإغلاق الـ controllers والاشتراكات.',
    code: r'''@override
void initState() {
  super.initState();
  _controller = TextEditingController();
}

@override
void dispose() {
  _controller.dispose();
  super.dispose();
}''',
  ),
  Question(
    id: 22,
    level: Level.medium,
    category: Category.async,
    question: 'ما الفرق بين Future و Stream؟',
    answer:
        'Future يُرجع قيمة واحدة (أو خطأ) مرة واحدة. Stream سلسلة من القيم تصل على مدار الوقت، مثل رسائل chat أو موقع GPS.',
    explanation:
        '• Future ← await.\n'
        '• Stream ← listen أو await for أو StreamBuilder.\n'
        '• يجب إلغاء الاشتراك (subscription.cancel) في dispose.',
    code: r'''Stream<int> countDown(int from) async* {
  for (var i = from; i >= 0; i--) {
    await Future.delayed(const Duration(seconds: 1));
    yield i;
  }
}''',
  ),
  Question(
    id: 23,
    level: Level.medium,
    category: Category.async,
    question: 'ما الخطأ الشائع عند استخدام FutureBuilder؟',
    answer:
        'إنشاء الـ Future داخل build مباشرة، فيعاد إنشاؤه وتنفيذ الطلب مع كل إعادة بناء. الحل: إنشاؤه مرة واحدة في initState وتخزينه في متغير.',
    explanation:
        '• build قد يُستدعى عشرات المرات (تغير الثيم، الكيبورد، الأب...).\n'
        '• تحقق دائماً من snapshot.connectionState و snapshot.hasError.',
    code: r'''late final Future<User> _userFuture;

@override
void initState() {
  super.initState();
  _userFuture = api.loadUser(); // ✔️ مرة واحدة
}

@override
Widget build(BuildContext context) {
  return FutureBuilder<User>(
    future: _userFuture, // ❌ لا تكتب api.loadUser() هنا
    builder: (context, snap) {
      if (snap.hasError) return Text('${snap.error}');
      if (!snap.hasData) return const CircularProgressIndicator();
      return Text(snap.data!.name);
    },
  );
}''',
  ),
  Question(
    id: 24,
    level: Level.medium,
    category: Category.widgets,
    question: 'ما هي الـ Keys ومتى نحتاجها؟',
    answer:
        'الـ Key تساعد Flutter على مطابقة الـ Widget القديم مع الجديد. نحتاجها عند إعادة ترتيب أو حذف عناصر Stateful من نفس النوع في قائمة، حتى لا تختلط حالتها.',
    explanation:
        '• ValueKey: مبنية على قيمة فريدة (مثل id).\n'
        '• ObjectKey: مبنية على هوية كائن.\n'
        '• UniqueKey: مختلفة دائماً ← تجبر إعادة الإنشاء.\n'
        '• GlobalKey: فريدة في كل التطبيق، للوصول إلى State من الخارج (مثل FormState).',
    code: r'''ListView(
  children: [
    for (final todo in todos)
      TodoTile(key: ValueKey(todo.id), todo: todo),
  ],
)''',
  ),
  Question(
    id: 25,
    level: Level.medium,
    category: Category.state,
    question: 'ما هو InheritedWidget؟',
    answer:
        'Widget خاص يمرر البيانات للأسفل في الشجرة بكفاءة، ويسمح لأي Widget أسفل منه بالوصول لها عبر context، ويعيد بناء المعتمدين عليه فقط عند التغيير.',
    explanation:
        '• هو الأساس الذي بُنيت عليه Theme و MediaQuery و Provider.\n'
        '• dependOnInheritedWidgetOfExactType يسجل الاعتماد ← إعادة بناء عند التغيير.\n'
        '• updateShouldNotify يحدد متى نُعلم المعتمدين.',
    code: r'''class UserScope extends InheritedWidget {
  const UserScope({super.key, required this.user, required super.child});
  final User user;

  static User of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<UserScope>()!.user;

  @override
  bool updateShouldNotify(UserScope old) => user != old.user;
}''',
  ),
  Question(
    id: 26,
    level: Level.medium,
    category: Category.state,
    question: 'قارن بين Provider و Riverpod و BLoC.',
    answer:
        'Provider: بسيط ومبني على InheritedWidget. Riverpod: تطوير لـ Provider، مستقل عن الشجرة وآمن وقت الترجمة. BLoC: يفصل المنطق عبر Events و States باستخدام Streams، مناسب للمشاريع الكبيرة.',
    explanation:
        '• Provider: سهل للمبتدئين، لكن يعتمد على context وقد يرمي ProviderNotFoundException.\n'
        '• Riverpod: لا يحتاج context، سهل الاختبار، يدعم caching و autoDispose.\n'
        '• BLoC / Cubit: هيكلية صارمة، قابلية تتبع واختبار عالية، لكن كود أكثر.\n'
        '• الجواب الذكي في المقابلة: "الاختيار حسب حجم المشروع والفريق".',
  ),
  Question(
    id: 27,
    level: Level.medium,
    category: Category.dart,
    question: 'ما هو الـ mixin في Dart؟',
    answer:
        'طريقة لإعادة استخدام كود في عدة كلاسات بدون وراثة. نضيفه بالكلمة with، ويمكن للكلاس استخدام أكثر من mixin.',
    explanation:
        '• Dart لا تدعم الوراثة المتعددة، والـ mixin هو البديل.\n'
        '• on لتقييد الـ mixin بنوع معين.\n'
        '• مثال مشهور: SingleTickerProviderStateMixin للأنيميشن.',
    code: r'''mixin Logger {
  void log(String msg) => print('[${runtimeType}] $msg');
}

class ApiService with Logger {
  void fetch() => log('fetching...');
}''',
  ),
  Question(
    id: 28,
    level: Level.medium,
    category: Category.dart,
    question: 'ما هي Extension Methods؟',
    answer:
        'تسمح بإضافة دوال أو getters لكلاس موجود (حتى لو لم تكتبه أنت، مثل String) بدون تعديله أو وراثته.',
    explanation:
        '• مفيدة جداً لتقليل التكرار، مثل context.theme أو string.capitalize.\n'
        '• تُحل وقت الترجمة (static)، لذلك لا تعمل مع dynamic.',
    code: r'''extension StringX on String {
  String get capitalize =>
      isEmpty ? this : this[0].toUpperCase() + substring(1);
}

extension ContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
}

'flutter'.capitalize; // Flutter''',
  ),
  Question(
    id: 29,
    level: Level.medium,
    category: Category.dart,
    question: 'ما هو factory constructor ومتى نستخدمه؟',
    answer:
        'constructor لا يُنشئ بالضرورة كائناً جديداً؛ يمكنه إرجاع كائن موجود (cache / Singleton) أو نوع فرعي، أو تحويل بيانات مثل fromJson.',
    explanation:
        '• لا يمكنه الوصول إلى this.\n'
        '• الاستخدامات: fromJson، Singleton، اختيار implementation حسب المنصة.',
    code: r'''class User {
  User(this.name);
  final String name;

  factory User.fromJson(Map<String, dynamic> json) =>
      User(json['name'] as String);
}

class Config {
  Config._();
  static final _instance = Config._();
  factory Config() => _instance; // Singleton
}''',
  ),
  Question(
    id: 30,
    level: Level.medium,
    category: Category.navigation,
    question: 'لماذا نستخدم go_router بدل Navigator العادي؟',
    answer:
        'go_router مبني على Navigator 2.0 ويوفر تنقل معرّف بالروابط (URLs)، يدعم Deep Linking والويب، والتحويل (redirect) للمصادقة، والتنقل المتداخل (ShellRoute).',
    explanation:
        '• Navigator 1.0 (أوامري): push / pop، بسيط لكن ضعيف مع الروابط.\n'
        '• Navigator 2.0 (تصريحي): قوي لكن معقد، لذلك go_router يبسطه.\n'
        '• redirect مثالي لحماية الصفحات لغير المسجلين.',
    code: r'''final router = GoRouter(
  redirect: (context, state) =>
      auth.isLoggedIn ? null : '/login',
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(
      path: '/product/:id',
      builder: (_, s) => ProductPage(id: s.pathParameters['id']!),
    ),
  ],
);

context.go('/product/42');''',
  ),
  Question(
    id: 31,
    level: Level.medium,
    category: Category.platform,
    question: 'ما هي Platform Channels؟',
    answer:
        'آلية للتواصل بين كود Dart والكود الأصلي (Kotlin/Java أو Swift/ObjC) لاستخدام ميزات غير متوفرة في Flutter مباشرة.',
    explanation:
        '• MethodChannel: استدعاء دالة وانتظار نتيجة.\n'
        '• EventChannel: استقبال Stream من الكود الأصلي (مثل الحساسات).\n'
        '• البيانات تُرسل مُسلسلة (serialized) بشكل غير متزامن.\n'
        '• بديل حديث: Pigeon لتوليد كود type-safe، أو FFI للغة C.',
    code: r'''const channel = MethodChannel('app/battery');

final level = await channel.invokeMethod<int>('getBatteryLevel');''',
  ),
  Question(
    id: 32,
    level: Level.medium,
    category: Category.performance,
    question: 'ماذا يحدث إذا لم تستدعِ dispose للـ Controllers؟',
    answer:
        'تسريب ذاكرة (Memory Leak): الـ Controller يبقى في الذاكرة ويستمر المستمعون (listeners) أو الـ Ticker بالعمل حتى بعد إغلاق الشاشة.',
    explanation:
        '• يجب dispose لـ: TextEditingController, AnimationController, ScrollController, FocusNode, StreamSubscription (cancel), Timer (cancel).\n'
        '• AnimationController غير المُتخلص منه يعطي خطأ Ticker was not disposed.',
  ),
  Question(
    id: 33,
    level: Level.medium,
    category: Category.widgets,
    question: 'كيف تجعل الواجهة متجاوبة (Responsive)؟',
    answer:
        'باستخدام MediaQuery لمعرفة حجم الشاشة، و LayoutBuilder لمعرفة المساحة المتاحة للـ Widget، مع Flexible/Expanded و Wrap و FractionallySizedBox وتجنب الأحجام الثابتة.',
    explanation:
        '• MediaQuery.sizeOf(context) ← حجم الشاشة كاملة (وأفضل من MediaQuery.of لأنه يعيد البناء فقط عند تغير الحجم).\n'
        '• LayoutBuilder ← constraints الأب، أدق للمكونات القابلة لإعادة الاستخدام.\n'
        '• حدد breakpoints (مثلاً 600 و 1200).',
    code: r'''LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return const TwoColumnLayout();
    }
    return const OneColumnLayout();
  },
)''',
  ),
  Question(
    id: 34,
    level: Level.medium,
    category: Category.async,
    question: 'ما هو الـ Isolate ومتى أستخدم compute أو Isolate.run؟',
    answer:
        'Isolate هو خيط تنفيذ مستقل بذاكرة منفصلة. نستخدمه للعمليات الثقيلة (مثل تحليل JSON ضخم أو معالجة صور) حتى لا يتجمد الـ UI.',
    explanation:
        '• async/await لا يعني تعدد خيوط؛ كل شيء على نفس الـ Isolate الرئيسي.\n'
        '• العمليات الحسابية الثقيلة تحجب الإطارات ← jank.\n'
        '• Isolate.run (أو compute) أسهل طريقة لتنفيذ دالة في Isolate منفصل وإرجاع النتيجة.',
    code: r'''final users = await Isolate.run(() {
  final list = jsonDecode(hugeJson) as List;
  return list.map((e) => User.fromJson(e)).toList();
});''',
  ),
  Question(
    id: 35,
    level: Level.medium,
    category: Category.async,
    question: 'ما الفرق بين Single-subscription Stream و Broadcast Stream؟',
    answer:
        'Single-subscription يقبل مستمعاً واحداً فقط ويحتفظ بالأحداث حتى يستمع أحد. Broadcast يقبل عدة مستمعين لكن من يشترك متأخراً يفوته ما سبق.',
    explanation:
        '• ملف أو طلب HTTP ← single.\n'
        '• أحداث عامة مثل تغير حالة الاتصال ← broadcast.\n'
        '• StreamController.broadcast() أو stream.asBroadcastStream().',
  ),
  Question(
    id: 36,
    level: Level.medium,
    category: Category.widgets,
    question: 'متى تستخدم CustomPainter؟',
    answer:
        'عندما تحتاج رسماً مخصصاً لا توفره الـ Widgets الجاهزة، مثل الرسوم البيانية أو الأشكال الخاصة، باستخدام Canvas مباشرة.',
    explanation:
        '• paint(canvas, size): ترسم فيها بـ drawLine, drawCircle, drawPath...\n'
        '• shouldRepaint: أرجع true فقط إذا تغيرت البيانات لتجنب إعادة رسم بلا داعٍ.\n'
        '• نستخدمه داخل CustomPaint.',
    code: r'''class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    canvas.drawCircle(size.center(Offset.zero), 40, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}''',
  ),
  Question(
    id: 37,
    level: Level.medium,
    category: Category.testing,
    question: 'ما أنواع الاختبارات في Flutter؟',
    answer:
        'Unit Test لاختبار دالة أو كلاس منطق. Widget Test لاختبار Widget واحد بمعزل. Integration Test لاختبار التطبيق كاملاً على جهاز حقيقي أو محاكي.',
    explanation:
        '• Unit: سريع جداً ← package:test.\n'
        '• Widget: يستخدم WidgetTester و pumpWidget و find.\n'
        '• Integration: أبطأ لكن الأقرب للمستخدم ← integration_test.\n'
        '• نستخدم mocktail أو mockito لمحاكاة التبعيات.',
    code: r'''testWidgets('counter increments', (tester) async {
  await tester.pumpWidget(const MaterialApp(home: Counter()));
  await tester.tap(find.byType(TextButton));
  await tester.pump();
  expect(find.text('1'), findsOneWidget);
});''',
  ),
  Question(
    id: 38,
    level: Level.medium,
    category: Category.async,
    question: 'لماذا نتحقق من mounted بعد await؟',
    answer:
        'لأن المستخدم قد يغلق الشاشة أثناء انتظار العملية، فيكون الـ State قد أُزيل من الشجرة، واستدعاء setState أو استخدام context بعدها يسبب خطأ.',
    explanation:
        '• الخطأ: setState() called after dispose().\n'
        '• منذ Flutter 3.7 يوجد context.mounted لاستخدامه خارج State.\n'
        '• الـ linter يحذر: use_build_context_synchronously.',
    code: r'''Future<void> _save() async {
  await api.save();
  if (!mounted) return;
  Navigator.pop(context);
}''',
  ),
  Question(
    id: 39,
    level: Level.medium,
    category: Category.dart,
    question: 'ما الجديد في Dart 3: Records و Patterns و Sealed classes؟',
    answer:
        'Records: إرجاع عدة قيم بدون كلاس. Patterns: تفكيك البيانات والمطابقة في switch. Sealed classes: مجموعة مغلقة من الأنواع الفرعية تجعل الـ switch شاملاً (exhaustive) ويتحقق منه المترجم.',
    explanation:
        '• ممتاز لتمثيل حالات الشاشة (Loading / Success / Error).\n'
        '• المترجم يعطي خطأ إن نسيت حالة في switch.',
    code: r'''(String, int) userInfo() => ('Ali', 25);
final (name, age) = userInfo();

sealed class UiState {}
class Loading extends UiState {}
class Success extends UiState { Success(this.data); final String data; }
class Failure extends UiState { Failure(this.msg); final String msg; }

Widget view(UiState s) => switch (s) {
  Loading()          => const CircularProgressIndicator(),
  Success(:final data) => Text(data),
  Failure(:final msg)  => Text('خطأ: $msg'),
};''',
  ),
  Question(
    id: 40,
    level: Level.medium,
    category: Category.performance,
    question: 'لماذا يُنصح باستخدام const Constructors؟',
    answer:
        'لأن الـ const Widget يُنشأ مرة واحدة وقت الترجمة، وعند إعادة بناء الأب يرى Flutter أنه نفس الكائن تماماً فيتخطى إعادة بنائه.',
    explanation:
        '• يقلل استهلاك الذاكرة وعمل الـ Garbage Collector.\n'
        '• فعّل قاعدة prefer_const_constructors في analysis_options.\n'
        '• تقسيم الواجهة إلى Widgets صغيرة const أفضل من دوال تُرجع Widgets.',
  ),

  // ─────────────────────────── صعب ───────────────────────────
  Question(
    id: 41,
    level: Level.hard,
    category: Category.internals,
    question: 'اشرح الأشجار الثلاث: Widget و Element و RenderObject.',
    answer:
        'Widget Tree: إعدادات خفيفة غير قابلة للتغيير. Element Tree: الكائنات الحية التي تربط الـ Widget بمكانه وتحتفظ بالـ State. RenderObject Tree: المسؤولة عن الـ layout والرسم فعلياً.',
    explanation:
        '• الـ Widgets تُنشأ وتُرمى باستمرار (رخيصة).\n'
        '• الـ Elements تبقى وتُحدّث إن كان للـ Widget الجديد نفس النوع والـ Key (canUpdate).\n'
        '• الـ RenderObjects مكلفة، ولذلك يعاد استخدامها بدل إنشائها.\n'
        '• BuildContext هو في الحقيقة الـ Element.',
    code: r'''// المنطق الذي يقرر إعادة الاستخدام:
static bool canUpdate(Widget oldWidget, Widget newWidget) {
  return oldWidget.runtimeType == newWidget.runtimeType
      && oldWidget.key == newWidget.key;
}''',
  ),
  Question(
    id: 42,
    level: Level.hard,
    category: Category.internals,
    question: 'كيف يعمل نظام الـ Layout في Flutter؟',
    answer:
        '"Constraints go down, Sizes go up, Parent sets position": الأب يمرر القيود (min/max width/height) للابن، الابن يختار حجمه ضمنها ويرجعه، ثم الأب يحدد موضع الابن.',
    explanation:
        '• الابن لا يعرف موقعه ولا يستطيع اختيار حجم خارج القيود.\n'
        '• لهذا SizedBox(width: 100) داخل عنصر يفرض tight constraints قد لا يأخذ 100.\n'
        '• خطأ "unbounded height" يحدث عند وضع ListView داخل Column بدون Expanded، لأن الـ Column يعطي ارتفاعاً غير محدود.\n'
        '• الـ layout يتم في مرور واحد (single pass) لذلك سريع O(n).',
  ),
  Question(
    id: 43,
    level: Level.hard,
    category: Category.async,
    question: 'اشرح الـ Event Loop في Dart. ما ناتج الكود التالي؟',
    answer:
        'Dart تعمل على خيط واحد بحلقة أحداث وطابورين: Microtask Queue (أولوية أعلى) و Event Queue. بعد تنفيذ الكود المتزامن تُفرغ كل الـ microtasks ثم تُنفذ event واحد، وهكذا.\nالناتج: 1, 4, 3, 2',
    explanation:
        '• الكود المتزامن أولاً: 1 ثم 4.\n'
        '• scheduleMicrotask و then على Future مكتمل ← Microtask Queue.\n'
        '• Future() و Future.delayed و Timer و I/O ← Event Queue.\n'
        '• microtasks كثيرة جداً قد تجمد الـ UI لأنها تمنع الأحداث.',
    code: r'''void main() {
  print('1');
  Future(() => print('2'));          // event queue
  scheduleMicrotask(() => print('3')); // microtask queue
  print('4');
}
// 1, 4, 3, 2''',
  ),
  Question(
    id: 44,
    level: Level.hard,
    category: Category.async,
    question: 'كيف تتواصل الـ Isolates مع بعضها؟ ولماذا لا تتشارك الذاكرة؟',
    answer:
        'كل Isolate له heap منفصل ولا توجد ذاكرة مشتركة، لذلك لا تحتاج Dart أقفالاً (locks) ولا توجد race conditions على البيانات. التواصل يتم عبر رسائل باستخدام SendPort و ReceivePort.',
    explanation:
        '• الرسائل تُنسخ (copy) عادةً، وبعض الأنواع تُنقل بدون نسخ مثل TransferableTypedData.\n'
        '• Isolate.run للمهام لمرة واحدة، و Isolate.spawn لـ worker طويل العمر.\n'
        '• لا يمكن استخدام معظم الـ plugins داخل Isolate إلا بعد تهيئة BackgroundIsolateBinaryMessenger.',
    code: r'''final receive = ReceivePort();
await Isolate.spawn(worker, receive.sendPort);
receive.listen((msg) => print('from worker: $msg'));

void worker(SendPort send) {
  send.send(heavyComputation());
}''',
  ),
  Question(
    id: 45,
    level: Level.hard,
    category: Category.internals,
    question: 'ماذا يحدث داخلياً عند استدعاء setState؟',
    answer:
        'تُنفذ الدالة الممررة، ثم يُستدعى _element.markNeedsBuild() الذي يعلّم الـ Element كـ dirty ويضيفه لقائمة BuildOwner، ويُطلب frame جديد. في الـ frame التالي يعيد Flutter بناء الـ Elements المعلّمة فقط.',
    explanation:
        '• استدعاء setState عدة مرات في نفس الـ frame يؤدي لبناء واحد فقط.\n'
        '• البناء يتم بترتيب العمق (الأب قبل الابن) لتجنب البناء المكرر.\n'
        '• بعد build تتم مقارنة الأبناء (reconciliation) وتحديث الـ RenderObjects المتأثرة فقط.',
  ),
  Question(
    id: 46,
    level: Level.hard,
    category: Category.internals,
    question: 'اشرح مراحل رسم الـ Frame (Rendering Pipeline).',
    answer:
        'عند إشارة VSync: Animate ← Build ← Layout ← Compositing bits ← Paint ← Compositing (بناء Layer Tree وإرساله للـ Engine) ← Rasterization على Raster Thread.',
    explanation:
        '• 60Hz = 16.6ms لكل frame، و 120Hz = 8.3ms.\n'
        '• UI Thread: ينفذ Dart (build/layout/paint).\n'
        '• Raster Thread: يحول الـ Layer Tree لأوامر GPU.\n'
        '• jank من UI thread ← منطق ثقيل أو builds كثيرة. jank من Raster ← تأثيرات مكلفة (saveLayer, clip, opacity, shadows).',
  ),
  Question(
    id: 47,
    level: Level.hard,
    category: Category.performance,
    question: 'كيف تكتشف مشاكل الأداء وتحلها في تطبيق Flutter؟',
    answer:
        'أقيس أولاً في profile mode باستخدام DevTools (Performance, CPU Profiler, Memory, Rebuild Stats)، ثم أعالج السبب: تقليل الـ rebuilds، الـ lazy lists، نقل العمليات الثقيلة لـ Isolate، وتقليل تأثيرات الرسم المكلفة.',
    explanation:
        '• لا تقيس في debug mode أبداً.\n'
        '• const Widgets وتقسيم الـ Widgets لتقليل نطاق إعادة البناء.\n'
        '• select في Provider/Riverpod للاستماع لجزء من الحالة فقط.\n'
        '• RepaintBoundary للعناصر كثيرة التحديث (مثل الأنيميشن).\n'
        '• تقليل Opacity و ClipRRect و saveLayer، وتحديد cacheWidth للصور الكبيرة.\n'
        '• itemExtent / prototypeItem في القوائم.',
  ),
  Question(
    id: 48,
    level: Level.hard,
    category: Category.internals,
    question: 'ما هو Impeller وما الفرق بينه وبين Skia؟',
    answer:
        'Impeller هو محرك الرسم الجديد في Flutter (الافتراضي على iOS و Android الحديث). يحل مشكلة shader compilation jank لأنه يُجهز الـ shaders مسبقاً وقت البناء بدلاً من ترجمتها وقت التشغيل كما في Skia.',
    explanation:
        '• مع Skia كانت الأنيميشن الأولى تتقطع عند ترجمة shader جديد.\n'
        '• Impeller يستخدم Metal على iOS و Vulkan (أو OpenGL كبديل) على Android.\n'
        '• أداء أكثر ثباتاً وقابلية للتنبؤ.',
  ),
  Question(
    id: 49,
    level: Level.hard,
    category: Category.widgets,
    question: 'لماذا تختلط حالة العناصر عند حذف عنصر من قائمة Stateful Widgets بدون Keys؟',
    answer:
        'لأن Flutter يطابق الـ Elements حسب النوع والموقع فقط. عند حذف العنصر الأول، يطابق الـ Element الأول (بحالته القديمة) مع الـ Widget الثاني، فتنتقل الحالة للعنصر الخطأ ويُحذف آخر Element.',
    explanation:
        '• الحالة محفوظة في الـ Element/State وليس في الـ Widget.\n'
        '• بإضافة ValueKey(item.id) يطابق Flutter حسب الـ Key فتبقى كل حالة مع عنصرها.\n'
        '• الـ Key يجب أن يوضع على الـ Widget الأعلى في العنصر (مباشرة ضمن children).',
  ),
  Question(
    id: 50,
    level: Level.hard,
    category: Category.widgets,
    question: 'ما هي الـ GlobalKey وما تكلفتها؟',
    answer:
        'GlobalKey فريدة على مستوى التطبيق، تسمح بالوصول للـ State أو context أو RenderObject من أي مكان، وبنقل Widget لمكان آخر في الشجرة مع الحفاظ على حالته (reparenting).',
    explanation:
        '• استخدامات: Form validation (GlobalKey<FormState>) و ScaffoldMessenger و Navigator key.\n'
        '• مكلفة: تحتاج تسجيل في سجل عام، والـ reparenting يعني deactivate ثم نقل الـ subtree.\n'
        '• استخدام نفس GlobalKey في مكانين يسبب خطأ Duplicate GlobalKey.\n'
        '• لا تنشئها داخل build.',
  ),
  Question(
    id: 51,
    level: Level.hard,
    category: Category.architecture,
    question: 'اشرح Clean Architecture في مشروع Flutter.',
    answer:
        'تقسيم المشروع لطبقات: Presentation (UI + State) ← Domain (Entities + UseCases + Repository interfaces) ← Data (Repository implementations + DataSources + Models). الاعتماد يتجه للداخل نحو Domain فقط.',
    explanation:
        '• Domain لا يعرف شيئاً عن Flutter أو الـ API أو قاعدة البيانات.\n'
        '• يسهل الاختبار واستبدال المصادر (API ← Cache).\n'
        '• غالباً مع feature-first folders: features/auth/{data,domain,presentation}.\n'
        '• لا تبالغ في المشاريع الصغيرة (over-engineering).',
    code: r'''// domain
abstract interface class UserRepository {
  Future<User> getUser(String id);
}

// data
class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._api);
  final UserApi _api;
  @override
  Future<User> getUser(String id) async =>
      (await _api.fetch(id)).toEntity();
}''',
  ),
  Question(
    id: 52,
    level: Level.hard,
    category: Category.state,
    question: 'ما الفرق بين Bloc و Cubit؟ ومتى أختار كلاً منهما؟',
    answer:
        'Cubit: دوال مباشرة تصدر states (emit)، أبسط وأقل كوداً. Bloc: يستقبل Events عبر Stream ويحولها لـ States، ويتيح event transformers مثل debounce و droppable وتتبع كل الأحداث.',
    explanation:
        '• Cubit مناسب لمعظم الحالات البسيطة والمتوسطة.\n'
        '• Bloc مناسب عند الحاجة للتحكم بتدفق الأحداث (بحث مع debounce، منع الطلبات المكررة) أو تتبعها (logging/analytics).\n'
        '• كلاهما يُختبر بسهولة بـ bloc_test.',
    code: r'''class CounterCubit extends Cubit<int> {
  CounterCubit() : super(0);
  void increment() => emit(state + 1);
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<QueryChanged>(_onQuery, transformer: restartable());
  }
}''',
  ),
  Question(
    id: 53,
    level: Level.hard,
    category: Category.architecture,
    question: 'كيف تطبق Dependency Injection في Flutter؟',
    answer:
        'بتمرير التبعيات من الخارج بدل إنشائها داخل الكلاس. يمكن ذلك يدوياً عبر الـ constructors، أو بـ Service Locator مثل get_it (مع injectable)، أو عبر Riverpod/Provider.',
    explanation:
        '• الهدف: فك الارتباط وسهولة الاختبار (تمرير Mock بدل الحقيقي).\n'
        '• get_it: registerSingleton و registerLazySingleton و registerFactory.\n'
        '• Service Locator يخفي التبعيات، لذلك الأفضل حقنها عبر الـ constructor حتى لو جاءت من get_it.',
    code: r'''final sl = GetIt.instance;

void setup() {
  sl.registerLazySingleton<Dio>(() => Dio());
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(sl()),
  );
  sl.registerFactory(() => UserCubit(sl()));
}''',
  ),
  Question(
    id: 54,
    level: Level.hard,
    category: Category.widgets,
    question: 'ما هي الـ Slivers ومتى تستخدم CustomScrollView؟',
    answer:
        'الـ Slivers أجزاء قابلة للتمرير تُبنى بشكل كسول، وتسمح بدمج أنواع مختلفة (قائمة + شبكة + AppBar قابل للطي) في منطقة تمرير واحدة باستخدام CustomScrollView.',
    explanation:
        '• ListView نفسه مبني داخلياً على SliverList.\n'
        '• Slivers شائعة: SliverAppBar, SliverList, SliverGrid, SliverToBoxAdapter, SliverPersistentHeader.\n'
        '• تجنب ListView بداخل ListView مع shrinkWrap: true لأنه يلغي البناء الكسول.',
    code: r'''CustomScrollView(
  slivers: [
    const SliverAppBar(expandedHeight: 200, pinned: true),
    SliverGrid.count(crossAxisCount: 2, children: cards),
    SliverList.builder(
      itemCount: items.length,
      itemBuilder: (_, i) => ListTile(title: Text(items[i])),
    ),
  ],
)''',
  ),
  Question(
    id: 55,
    level: Level.hard,
    category: Category.internals,
    question: 'متى تحتاج لكتابة RenderObject مخصص؟',
    answer:
        'عندما لا تكفي الـ Widgets الجاهزة ولا CustomPainter ولا CustomMultiChildLayout، وتحتاج تحكماً كاملاً بالـ layout أو hit testing أو الأداء، مثل تخطيط نصوص معقد أو مكون رسم عالي الأداء.',
    explanation:
        '• ننشئ LeafRenderObjectWidget أو SingleChildRenderObjectWidget أو MultiChildRenderObjectWidget.\n'
        '• نطبق createRenderObject و updateRenderObject.\n'
        '• في الـ RenderBox نطبق performLayout و paint و hitTestSelf.\n'
        '• نستدعي markNeedsLayout أو markNeedsPaint عند تغيير الخصائص.',
  ),
  Question(
    id: 56,
    level: Level.hard,
    category: Category.architecture,
    question: 'كيف تلتقط كل الأخطاء غير المعالجة في التطبيق؟',
    answer:
        'FlutterError.onError لأخطاء إطار Flutter (build/layout)، و PlatformDispatcher.instance.onError للأخطاء غير المتزامنة غير الملتقطة، ثم إرسالها لخدمة مثل Crashlytics أو Sentry.',
    explanation:
        '• runZonedGuarded كان الأسلوب القديم ولا يزال صالحاً.\n'
        '• ErrorWidget.builder لتخصيص الشاشة الحمراء في الإصدار.\n'
        '• لا تبتلع الأخطاء بصمت، واعرض رسالة مفهومة للمستخدم.',
    code: r'''void main() {
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    crashReporter.record(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    crashReporter.record(error, stack);
    return true;
  };
  runApp(const MyApp());
}''',
  ),
  Question(
    id: 57,
    level: Level.hard,
    category: Category.platform,
    question: 'كيف تقلل حجم تطبيق Flutter وتحمي الكود؟',
    answer:
        'البناء بـ --split-debug-info و --obfuscate، وإصدار App Bundle (appbundle) لتقسيم الملف حسب المعالج، وضغط الصور، وحذف المكتبات غير المستخدمة، واستخدام deferred loading.',
    explanation:
        '• Tree shaking يحذف الكود غير المستخدم تلقائياً في AOT (حتى الأيقونات غير المستخدمة).\n'
        '• --analyze-size لتحليل ما يأخذ المساحة.\n'
        '• الـ obfuscation يصعّب الهندسة العكسية، لكن لا تضع أسراراً (API keys حساسة) داخل التطبيق أصلاً.',
    code: r'''flutter build appbundle --release \
  --obfuscate --split-debug-info=build/symbols

flutter build apk --analyze-size --target-platform android-arm64''',
  ),
  Question(
    id: 58,
    level: Level.hard,
    category: Category.async,
    question: 'كيف تمنع Race Conditions في الطلبات غير المتزامنة (مثل البحث)؟',
    answer:
        'بتجاهل النتائج القديمة: إما بإلغاء الطلب السابق (CancelToken في Dio أو restartable في Bloc)، أو بتتبع رقم/معرف الطلب الأخير وتجاهل أي استجابة ليست له، مع debounce لتقليل الطلبات.',
    explanation:
        '• المشكلة: المستخدم يكتب "fl" ثم "flutter"، وطلب "fl" يصل متأخراً فيستبدل النتائج الصحيحة.\n'
        '• رغم أن Dart خيط واحد، الـ async يسبب تداخلاً في الترتيب.\n'
        '• switchMap في RxDart يحل المشكلة أيضاً.',
    code: r'''int _requestId = 0;
Timer? _debounce;

void onQueryChanged(String q) {
  _debounce?.cancel();
  _debounce = Timer(const Duration(milliseconds: 300), () async {
    final id = ++_requestId;
    final results = await api.search(q);
    if (id != _requestId) return; // نتيجة قديمة
    setState(() => _results = results);
  });
}''',
  ),
  Question(
    id: 59,
    level: Level.hard,
    category: Category.testing,
    question: 'ما هي Golden Tests وكيف تختبر كود يعتمد على API؟',
    answer:
        'Golden Test يلتقط صورة للـ Widget ويقارنها بصورة مرجعية لاكتشاف أي تغيير بصري. لاختبار كود يعتمد على API نعزل التبعية خلف interface ونمرر Mock (mocktail) بدل الحقيقي.',
    explanation:
        '• إنشاء/تحديث الصور: flutter test --update-goldens.\n'
        '• الصور قد تختلف بين أنظمة التشغيل بسبب الخطوط، لذلك توحّد البيئة في CI.\n'
        '• when(...).thenAnswer لتحديد سلوك الـ mock، و verify للتأكد من الاستدعاء.',
    code: r'''class MockRepo extends Mock implements UserRepository {}

test('loads user', () async {
  final repo = MockRepo();
  when(() => repo.getUser('1'))
      .thenAnswer((_) async => User('Ali'));

  final cubit = UserCubit(repo);
  await cubit.load('1');

  expect(cubit.state, isA<UserLoaded>());
  verify(() => repo.getUser('1')).called(1);
});''',
  ),
  Question(
    id: 60,
    level: Level.hard,
    category: Category.internals,
    question: 'كيف تدير Dart الذاكرة (Garbage Collection)؟',
    answer:
        'Dart تستخدم Garbage Collector جيلي (generational): الـ Young Space للكائنات الجديدة قصيرة العمر ويُنظف بسرعة كبيرة (scavenger)، و Old Space للكائنات طويلة العمر ويُنظف بـ mark-sweep/compact بشكل متزامن قدر الإمكان.',
    explanation:
        '• لهذا إنشاء آلاف الـ Widgets في كل frame رخيص.\n'
        '• التسريبات تأتي من مراجع باقية: listeners غير ملغاة، static caches، closures تحمل context.\n'
        '• DevTools ← Memory لتتبع التسريبات، و leak_tracker للاكتشاف في الاختبارات.',
  ),
];
