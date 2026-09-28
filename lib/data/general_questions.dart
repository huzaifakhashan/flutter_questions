import '../models/question.dart';

const List<Question> generalQuestions = [
  // ─────────────────────────── سهل ───────────────────────────
  Question(
    id: 3001,
    level: Level.easy,
    category: Category.git,
    question: 'ما هو Git وما الفرق بينه وبين GitHub؟',
    answer:
        'Git نظام تحكم بالإصدارات (Version Control) موزّع يعمل على جهازك ويتتبع تاريخ تغييرات الكود. GitHub منصة على الإنترنت لاستضافة مستودعات Git وتضيف ميزات التعاون: Pull Requests و Issues و Actions و Code Review.',
    explanation:
        '• موزّع: كل مطور لديه نسخة كاملة من التاريخ، ويمكنه العمل بدون إنترنت.\n'
        '• بدائل GitHub: GitLab و Bitbucket.\n'
        '• Git يمكن استخدامه وحده بدون أي منصة.',
  ),
  Question(
    id: 3002,
    level: Level.easy,
    category: Category.git,
    question: 'ما هي أوامر Git الأساسية؟',
    answer:
        'init لإنشاء مستودع، clone لنسخ مستودع، status لعرض الحالة، add لتجهيز التغييرات، commit لحفظها، push لرفعها، pull لجلب التحديثات، log لعرض التاريخ، branch و switch / checkout للفروع.',
    explanation:
        '• مراحل الملف: Working Directory ← (add) ← Staging Area ← (commit) ← Repository.\n'
        '• اكتب رسائل commit واضحة تشرح "لماذا" وليس فقط "ماذا".',
    code: r'''git clone https://github.com/user/repo.git
git status
git add .
git commit -m "Add login screen"
git push origin main
git log --oneline --graph''',
  ),
  Question(
    id: 3003,
    level: Level.easy,
    category: Category.git,
    question: 'ما هو الـ Branch ولماذا نستخدمه؟',
    answer:
        'الفرع (Branch) خط تطوير مستقل. نعمل على كل ميزة أو إصلاح في فرع منفصل دون التأثير على الفرع الرئيسي (main)، ثم ندمجه بعد المراجعة.',
    explanation:
        '• الفرع في Git مجرد مؤشر خفيف على commit، لذلك إنشاؤه سريع جداً.\n'
        '• تسمية شائعة: feature/login, fix/crash-on-start.',
    code: r'''git switch -c feature/login   # إنشاء فرع والانتقال إليه
git switch main
git merge feature/login
git branch -d feature/login''',
  ),
  Question(
    id: 3004,
    level: Level.easy,
    category: Category.git,
    question: 'ما الفرق بين git fetch و git pull؟',
    answer:
        'git fetch يجلب التحديثات من المستودع البعيد دون تعديل ملفاتك أو فرعك الحالي. git pull = fetch + merge (أو rebase)، أي يجلب التحديثات ويدمجها مباشرة في فرعك.',
    explanation:
        '• fetch آمن لتعرف ماذا تغير قبل الدمج.\n'
        '• git pull --rebase يحافظ على تاريخ خطي بدون merge commits إضافية.',
  ),
  Question(
    id: 3005,
    level: Level.easy,
    category: Category.git,
    question: 'ما هو الـ Pull Request (PR)؟',
    answer:
        'طلب لدمج تغييرات فرعك في فرع آخر (غالباً main) على GitHub. يتيح للفريق مراجعة الكود ومناقشته، وتشغيل الاختبارات التلقائية (CI) قبل الدمج.',
    explanation:
        '• في GitLab يسمى Merge Request.\n'
        '• PR جيد: صغير، وله وصف واضح، ومرتبط بـ Issue، ومع صور للتغييرات في الواجهة.\n'
        '• خيارات الدمج: Merge commit أو Squash and merge أو Rebase and merge.',
  ),
  Question(
    id: 3006,
    level: Level.easy,
    category: Category.git,
    question: 'ما هو ملف .gitignore؟',
    answer:
        'ملف يحدد الملفات والمجلدات التي يتجاهلها Git ولا يتتبعها، مثل ملفات البناء (build) والمكتبات (vendor, node_modules) وملفات الأسرار (.env) وإعدادات المحرر.',
    explanation:
        '• لا يؤثر على ملفات يتتبعها Git مسبقاً؛ يجب إزالتها أولاً بـ git rm --cached.\n'
        '• إذا رفعت سراً بالخطأ: غيّره فوراً، لأن حذفه من الـ commit التالي لا يحذفه من التاريخ.',
    code: r'''.env
/vendor
/node_modules
/build
*.log''',
  ),
  Question(
    id: 3007,
    level: Level.easy,
    category: Category.oop,
    question: 'ما هي المبادئ الأربعة للبرمجة كائنية التوجه (OOP)؟',
    answer:
        'التغليف (Encapsulation): إخفاء البيانات الداخلية وإتاحتها عبر دوال. الوراثة (Inheritance): كلاس يرث خصائص كلاس آخر. تعدد الأشكال (Polymorphism): نفس الواجهة بسلوكيات مختلفة. التجريد (Abstraction): إظهار الضروري فقط وإخفاء التفاصيل.',
    explanation:
        '• مثال Polymorphism: shape.area() تعمل على Circle و Square كلٌّ بطريقته.\n'
        '• مثال Encapsulation: رصيد الحساب private ولا يتغير إلا عبر deposit و withdraw.',
    code: r'''abstract class Shape { double area(); }

class Circle extends Shape {
  Circle(this.r);
  final double r;
  @override
  double area() => 3.14 * r * r;
}

class Square extends Shape {
  Square(this.s);
  final double s;
  @override
  double area() => s * s;
}''',
  ),
  Question(
    id: 3008,
    level: Level.easy,
    category: Category.web,
    question: 'ما هو REST API؟',
    answer:
        'أسلوب لتصميم الـ APIs عبر HTTP، يتعامل مع البيانات كموارد (Resources) لها روابط (مثل /users/5)، ويستخدم HTTP methods للعمليات، ويكون stateless (كل طلب يحمل كل ما يلزمه)، وغالباً يرجع JSON.',
    explanation:
        '• GET /posts ← قائمة، POST /posts ← إنشاء، GET /posts/5 ← عرض، PUT/PATCH /posts/5 ← تعديل، DELETE /posts/5 ← حذف.\n'
        '• استخدم أسماء جمع ولا تستخدم أفعالاً في الرابط (/getPosts ❌).\n'
        '• البدائل: GraphQL و gRPC.',
  ),
  Question(
    id: 3009,
    level: Level.easy,
    category: Category.web,
    question: 'ما هي HTTP Methods وما الفرق بين PUT و PATCH؟',
    answer:
        'GET للقراءة، POST للإنشاء، PUT لاستبدال المورد بالكامل، PATCH لتعديل جزئي، DELETE للحذف. الفرق: PUT يرسل المورد كاملاً، و PATCH يرسل الحقول المتغيرة فقط.',
    explanation:
        '• GET لا يجب أن يغير البيانات ولا يحمل body.\n'
        '• لا تضع بيانات حساسة في رابط GET لأنها تُحفظ في السجلات والتاريخ.',
  ),
  Question(
    id: 3010,
    level: Level.easy,
    category: Category.web,
    question: 'اذكر أهم HTTP Status Codes.',
    answer:
        '2xx نجاح: 200 OK، 201 Created، 204 No Content. 3xx تحويل: 301، 304 Not Modified. 4xx خطأ من العميل: 400، 401، 403، 404، 422، 429. 5xx خطأ من الخادم: 500، 502، 503.',
    explanation:
        '• 401 Unauthorized: غير مسجل دخول (لا نعرف من أنت).\n'
        '• 403 Forbidden: مسجل لكن لا تملك الصلاحية.\n'
        '• 422: بيانات غير صالحة (Validation).\n'
        '• 429: طلبات كثيرة (Rate limit).',
  ),
  Question(
    id: 3011,
    level: Level.easy,
    category: Category.web,
    question: 'ما الفرق بين Frontend و Backend؟',
    answer:
        'Frontend هو ما يراه المستخدم ويتفاعل معه (تطبيق Flutter، موقع React). Backend هو الخادم الذي ينفذ منطق الأعمال ويتعامل مع قاعدة البيانات والمصادقة ويوفر الـ API (مثل Laravel).',
    explanation:
        '• يتواصلان غالباً عبر HTTP و JSON.\n'
        '• Full-stack: مطور يعمل على الطرفين.\n'
        '• لا تثق أبداً ببيانات الـ Frontend؛ التحقق الحقيقي يكون في الـ Backend.',
  ),
  Question(
    id: 3012,
    level: Level.easy,
    category: Category.web,
    question: 'ما هو JSON؟',
    answer:
        'JavaScript Object Notation: صيغة نصية خفيفة لتبادل البيانات، تتكون من أزواج مفتاح/قيمة ومصفوفات، وتدعم الأنواع: string, number, boolean, null, object, array.',
    explanation:
        '• سهل القراءة للإنسان والآلة، والصيغة الأكثر استخداماً في الـ APIs.\n'
        '• لا يدعم التعليقات ولا نوع التاريخ (يُرسل كنص ISO 8601).\n'
        '• المفاتيح يجب أن تكون بين علامات تنصيص مزدوجة.',
    code: r'''{
  "id": 1,
  "name": "Ali",
  "skills": ["Flutter", "Laravel"],
  "active": true,
  "manager": null
}''',
  ),
  Question(
    id: 3013,
    level: Level.easy,
    category: Category.oop,
    question: 'ما الفرق بين Class و Object؟',
    answer:
        'Class هو القالب أو المخطط الذي يصف الخصائص والسلوكيات. Object هو نسخة فعلية (instance) مُنشأة من هذا القالب لها قيمها الخاصة في الذاكرة.',
    explanation:
        '• تشبيه: Class = مخطط البيت، Object = البيت المبني.\n'
        '• من Class واحد يمكن إنشاء عدد غير محدود من Objects.',
  ),
  Question(
    id: 3014,
    level: Level.easy,
    category: Category.dsa,
    question: 'ما الفرق بين Stack و Queue؟',
    answer:
        'Stack يعمل بمبدأ LIFO (آخر من يدخل أول من يخرج) مثل كومة الأطباق. Queue يعمل بمبدأ FIFO (أول من يدخل أول من يخرج) مثل طابور الانتظار.',
    explanation:
        '• استخدامات Stack: التراجع Undo، Call Stack للدوال، Navigator في Flutter، التحقق من الأقواس.\n'
        '• استخدامات Queue: طوابير المهام (Jobs)، الطباعة، BFS في الرسوم البيانية.',
  ),
  Question(
    id: 3015,
    level: Level.easy,
    category: Category.soft,
    question: 'عرّفني بنفسك (Tell me about yourself).',
    answer:
        'جواب قصير (1-2 دقيقة) يركز على المهنة: من أنت حالياً ← خبرتك وأهم إنجازاتك التقنية ← لماذا أنت مهتم بهذه الوظيفة. ليس قصة حياتك.',
    explanation:
        '• الصيغة: Present ← Past ← Future.\n'
        '• اذكر مشروعاً واحداً بأرقام (مثلاً: قللت زمن التحميل 40%).\n'
        '• اربط مهاراتك بمتطلبات الوظيفة.\n'
        '• تدرّب عليه بصوت عالٍ مسبقاً.',
  ),
  Question(
    id: 3046,
    level: Level.easy,
    category: Category.soft,
    question: 'هل لديك أي أسئلة لنا؟',
    answer:
        'دائماً قل نعم وجهّز 2-3 أسئلة، فهذا يُظهر اهتمامك. مثل: كيف يبدو يوم العمل في الفريق؟ ما التقنيات والتحديات الحالية؟ كيف تتم مراجعة الكود والنشر؟ ما المتوقع مني في أول 3 أشهر؟',
    explanation:
        '• تجنب الأسئلة التي جوابها موجود في موقع الشركة.\n'
        '• اترك سؤال الراتب والإجازات لمرحلة لاحقة، إلا إن فتحوه هم.',
  ),

  // ─────────────────────────── متوسط ───────────────────────────
  Question(
    id: 3016,
    level: Level.medium,
    category: Category.git,
    question: 'ما الفرق بين git merge و git rebase؟',
    answer:
        'merge يدمج الفرعين وينشئ merge commit ويحافظ على التاريخ كما حدث فعلاً. rebase يعيد تطبيق commits فرعك فوق آخر نقطة في الفرع الآخر، فيصبح التاريخ خطياً ونظيفاً، لكنه يعيد كتابة التاريخ (commits جديدة بـ hash مختلف).',
    explanation:
        '• القاعدة الذهبية: لا تعمل rebase لفرع مشترك سبق رفعه ويعمل عليه آخرون.\n'
        '• rebase مناسب لتحديث فرعك الشخصي من main قبل فتح الـ PR.\n'
        '• merge أكثر أماناً للفروع المشتركة.',
    code: r'''# تحديث فرعي بآخر تغييرات main
git switch feature/login
git fetch origin
git rebase origin/main
# بعد حل التعارضات:
git rebase --continue''',
  ),
  Question(
    id: 3017,
    level: Level.medium,
    category: Category.git,
    question: 'ما هو Merge Conflict وكيف تحله؟',
    answer:
        'يحدث عندما يعدّل فرعان نفس الأسطر في نفس الملف، ولا يعرف Git أي تعديل يعتمد. الحل: فتح الملف، اختيار أو دمج التعديلات بين العلامات <<<<<<< و ======= و >>>>>>>، ثم git add و git commit (أو rebase --continue).',
    explanation:
        '• تواصل مع صاحب التعديل الآخر إن لم تفهم تغييره.\n'
        '• شغّل الاختبارات بعد الحل.\n'
        '• للتقليل منها: فروع قصيرة العمر، ودمج main في فرعك بشكل متكرر.\n'
        '• git merge --abort للتراجع عن الدمج بالكامل.',
    code: r'''<<<<<<< HEAD
const timeout = 30;
=======
const timeout = 60;
>>>>>>> feature/slow-network''',
  ),
  Question(
    id: 3018,
    level: Level.medium,
    category: Category.git,
    question: 'ما الفرق بين git reset و git revert و git restore؟',
    answer:
        'revert ينشئ commit جديداً يعكس commit سابقاً، وهو آمن للفروع المشتركة. reset يحرك الفرع لـ commit سابق ويعيد كتابة التاريخ (soft / mixed / hard). restore يتراجع عن تغييرات ملفات لم تُحفظ بعد.',
    explanation:
        '• reset --soft: يبقي التغييرات في الـ staging.\n'
        '• reset --mixed (الافتراضي): يبقيها في الملفات دون staging.\n'
        '• reset --hard: يحذفها نهائياً ⚠️.\n'
        '• على main المشترك استخدم revert دائماً.',
    code: r'''git revert a1b2c3d          # تراجع آمن
git reset --soft HEAD~1      # فك آخر commit مع إبقاء التغييرات
git restore app.dart         # تجاهل تعديلات ملف
git restore --staged app.dart''',
  ),
  Question(
    id: 3019,
    level: Level.medium,
    category: Category.git,
    question: 'متى تستخدم git stash و git cherry-pick؟',
    answer:
        'stash يحفظ تعديلاتك غير المكتملة مؤقتاً ويعيد الملفات لحالة نظيفة (مثلاً لتنتقل لفرع آخر لإصلاح عاجل)، ثم تستعيدها بـ stash pop. cherry-pick ينسخ commit معيناً من فرع إلى فرعك الحالي.',
    explanation:
        '• مثال cherry-pick: إصلاح bug في develop وتحتاجه فوراً في فرع الإصدار.\n'
        '• git stash list لعرض المحفوظات، و git stash -u لتضمين الملفات الجديدة.',
    code: r'''git stash
git switch hotfix
# ... إصلاح ...
git switch feature/x
git stash pop

git cherry-pick 9f8e7d6''',
  ),
  Question(
    id: 3020,
    level: Level.medium,
    category: Category.oop,
    question: 'اشرح مبادئ SOLID.',
    answer:
        'S: Single Responsibility، لكل كلاس سبب واحد للتغيير. O: Open/Closed، مفتوح للإضافة ومغلق للتعديل. L: Liskov Substitution، يمكن استبدال الأب بالابن دون كسر السلوك. I: Interface Segregation، واجهات صغيرة ومحددة بدل واجهة ضخمة. D: Dependency Inversion، اعتمد على التجريدات (interfaces) لا على التنفيذات.',
    explanation:
        '• S: كلاس UserService لا يرسل إيميلات ولا يولد PDF.\n'
        '• O: إضافة طريقة دفع جديدة بكلاس جديد بدل if/else جديدة.\n'
        '• L: كلاس Square يرث Rectangle ويكسر setWidth ← مخالفة.\n'
        '• D: Controller يعتمد على PaymentGateway interface وليس Stripe مباشرة.',
  ),
  Question(
    id: 3021,
    level: Level.medium,
    category: Category.oop,
    question: 'ما الفرق بين Interface و Abstract Class؟',
    answer:
        'Interface عقد يحدد ماذا يجب أن يفعل الكلاس دون تنفيذ (عادة)، ويمكن تطبيق عدة interfaces. Abstract Class يمكن أن يحتوي حالة (خصائص) وتنفيذاً جزئياً مشتركاً، لكن يُورث منه واحد فقط.',
    explanation:
        '• استخدم Interface لقدرة يشترك بها كلاسات غير مترابطة (Comparable, Serializable).\n'
        '• استخدم Abstract Class لعائلة كلاسات تشترك بكود حقيقي.\n'
        '• في Dart كل كلاس هو interface ضمنياً (implements).',
  ),
  Question(
    id: 3022,
    level: Level.medium,
    category: Category.oop,
    question: 'لماذا يُقال "Composition over Inheritance"؟',
    answer:
        'لأن الوراثة تربط الكلاسات بقوة (تغيير الأب يكسر الأبناء) وتنتج هرميات عميقة يصعب تعديلها. التركيب (Composition) يبني السلوك بجمع كائنات صغيرة مستقلة (has-a)، وهو أكثر مرونة وقابلية للاختبار.',
    explanation:
        '• الوراثة مناسبة لعلاقة is-a حقيقية ومستقرة.\n'
        '• Flutter مثال ممتاز: الواجهات تُبنى بتركيب Widgets وليس بوراثتها.\n'
        '• مثال: Car يملك Engine بدل Car extends Engine.',
  ),
  Question(
    id: 3023,
    level: Level.medium,
    category: Category.security,
    question: 'ما الفرق بين Authentication و Authorization؟ وبين Session و JWT؟',
    answer:
        'Authentication: التحقق من هوية المستخدم (من أنت؟). Authorization: التحقق من صلاحياته (ماذا يُسمح لك؟). Session: الخادم يحفظ حالة الدخول ويعطي المتصفح cookie بمعرفها. JWT: توكن موقّع يحمل بيانات المستخدم ويتحقق منه الخادم دون تخزين حالة.',
    explanation:
        '• Session: سهل الإلغاء (تحذفه من الخادم) لكنه يحتاج تخزيناً مشتركاً عند التوسع.\n'
        '• JWT: stateless ومناسب للخدمات الموزعة، لكن صعب الإلغاء قبل انتهاء صلاحيته، لذلك نجعل مدته قصيرة مع Refresh Token.\n'
        '• JWT موقّع وليس مشفراً؛ لا تضع فيه بيانات سرية.',
  ),
  Question(
    id: 3024,
    level: Level.medium,
    category: Category.web,
    question: 'ما الفرق بين Cookies و localStorage و sessionStorage؟',
    answer:
        'Cookies صغيرة (~4KB) وتُرسل تلقائياً مع كل طلب للخادم، ولها خيارات أمان (HttpOnly, Secure, SameSite). localStorage أكبر (~5MB) ويبقى دائماً ولا يُرسل للخادم. sessionStorage مثله لكن يُحذف عند إغلاق التبويب.',
    explanation:
        '• localStorage يمكن لأي JavaScript قراءته، فهو معرض لسرقة التوكن عبر XSS.\n'
        '• cookie بخاصية HttpOnly لا يمكن لـ JavaScript قراءتها ← أأمن لتخزين التوكن.\n'
        '• في Flutter للموبايل: flutter_secure_storage للأسرار.',
  ),
  Question(
    id: 3025,
    level: Level.medium,
    category: Category.dsa,
    question: 'ما هو Big O Notation؟',
    answer:
        'طريقة لوصف كيف يزداد وقت (أو ذاكرة) الخوارزمية مع زيادة حجم المدخلات n في أسوأ الحالات. الشائع: O(1) ثابت، O(log n) لوغاريتمي، O(n) خطي، O(n log n)، O(n²) تربيعي، O(2ⁿ) أُسّي.',
    explanation:
        '• O(1): الوصول لعنصر في مصفوفة بالـ index أو HashMap.\n'
        '• O(log n): Binary Search.\n'
        '• O(n): المرور على قائمة.\n'
        '• O(n log n): أفضل خوارزميات الترتيب (Merge Sort).\n'
        '• O(n²): حلقتان متداخلتان.',
    code: r'''// O(n²) ❌
bool hasDuplicate(List<int> a) {
  for (var i = 0; i < a.length; i++) {
    for (var j = i + 1; j < a.length; j++) {
      if (a[i] == a[j]) return true;
    }
  }
  return false;
}

// O(n) ✔️
bool hasDuplicateFast(List<int> a) => a.toSet().length != a.length;''',
  ),
  Question(
    id: 3026,
    level: Level.medium,
    category: Category.dsa,
    question: 'ما الفرق بين Array و Linked List و Hash Map؟',
    answer:
        'Array: عناصر متجاورة في الذاكرة، وصول سريع بالـ index O(1) لكن الإضافة في المنتصف O(n). Linked List: عقد مترابطة، إضافة وحذف سريع O(1) إذا كان لديك المؤشر، لكن الوصول O(n). Hash Map: أزواج مفتاح/قيمة، بحث وإضافة O(1) في المتوسط.',
    explanation:
        '• Hash Map مثالي لعد التكرارات أو البحث السريع (Map في Dart، array في PHP).\n'
        '• Set لتخزين قيم فريدة والتحقق من الوجود بسرعة.\n'
        '• اختيار هيكل البيانات الصحيح أهم من تحسين الكود.',
  ),
  Question(
    id: 3027,
    level: Level.medium,
    category: Category.patterns,
    question: 'اشرح أنماط Singleton و Factory و Observer.',
    answer:
        'Singleton: نسخة واحدة فقط من الكلاس في كل التطبيق (مثل اتصال قاعدة بيانات). Factory: إنشاء الكائنات عبر دالة تقرر النوع المناسب، بدل new مباشرة. Observer: كائن ينشر تغييراته ومستمعون يُبلّغون تلقائياً (Streams و ChangeNotifier و Events).',
    explanation:
        '• Singleton قد يصبح حالة عامة مخفية تصعّب الاختبار؛ الأفضل تسجيله في DI Container.\n'
        '• الأنماط الثلاثة: Creational (Singleton, Factory, Builder)، Structural (Adapter, Decorator, Facade)، Behavioral (Observer, Strategy, Command).',
  ),
  Question(
    id: 3028,
    level: Level.medium,
    category: Category.web,
    question: 'ما هو CORS؟',
    answer:
        'Cross-Origin Resource Sharing: آلية في المتصفح تمنع صفحة من origin معين (نطاق + بروتوكول + منفذ) من قراءة ردود API على origin آخر، إلا إذا سمح الخادم بذلك عبر headers مثل Access-Control-Allow-Origin.',
    explanation:
        '• هي حماية في المتصفح فقط؛ تطبيقات الموبايل و Postman لا تتأثر بها.\n'
        '• طلبات معينة يسبقها طلب preflight بـ OPTIONS.\n'
        '• الحل يكون في الخادم (مثلاً config/cors.php في Laravel)، وليس في الـ Frontend.\n'
        '• لا تستخدم * مع credentials.',
  ),
  Question(
    id: 3029,
    level: Level.medium,
    category: Category.practices,
    question: 'ما هو CI/CD؟',
    answer:
        'CI (Continuous Integration): دمج الكود باستمرار مع تشغيل تلقائي للبناء والاختبارات مع كل push أو PR. CD (Continuous Delivery / Deployment): تجهيز أو نشر الإصدار تلقائياً بعد نجاح المراحل.',
    explanation:
        '• أدوات: GitHub Actions, GitLab CI, Jenkins, Codemagic (Flutter), Bitrise.\n'
        '• الفائدة: اكتشاف الأخطاء مبكراً ونشر سريع وموثوق.\n'
        '• Delivery: النشر بزر يدوي. Deployment: النشر تلقائي بالكامل.',
    code: r'''# .github/workflows/ci.yml
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter analyze
      - run: flutter test''',
  ),
  Question(
    id: 3030,
    level: Level.medium,
    category: Category.practices,
    question: 'ما هو Docker؟ وما الفرق بين Image و Container؟',
    answer:
        'Docker أداة لتغليف التطبيق مع كل ما يحتاجه (نظام، مكتبات، إعدادات) في حاوية تعمل بنفس الشكل على أي جهاز. Image قالب للقراءة فقط يُبنى من Dockerfile، و Container نسخة تعمل من هذا الـ Image.',
    explanation:
        '• يحل مشكلة "يعمل على جهازي فقط".\n'
        '• الحاوية أخف من Virtual Machine لأنها تشارك نواة النظام.\n'
        '• docker compose لتشغيل عدة خدمات معاً (تطبيق + MySQL + Redis).\n'
        '• Laravel Sail مبني على Docker.',
  ),
  Question(
    id: 3047,
    level: Level.medium,
    category: Category.soft,
    question: 'حدثني عن مشكلة صعبة واجهتها وكيف حللتها.',
    answer:
        'استخدم طريقة STAR: Situation (الموقف)، Task (مهمتك)، Action (ماذا فعلت أنت تحديداً)، Result (النتيجة، ويفضل بأرقام). ركز على طريقة تفكيرك وما تعلمته.',
    explanation:
        '• حضّر 3-4 قصص حقيقية: bug صعب، خلاف في الفريق، موعد تسليم ضيق، خطأ ارتكبته وتعلمت منه.\n'
        '• قل "أنا فعلت" وليس "نحن فعلنا" عند الحديث عن دورك.\n'
        '• لا تلُم الآخرين.',
  ),
  Question(
    id: 3048,
    level: Level.medium,
    category: Category.soft,
    question: 'ما هي نقاط ضعفك؟',
    answer:
        'اذكر نقطة ضعف حقيقية لكنها ليست أساسية للوظيفة، ثم وضّح ما تفعله لتحسينها. مثال: "كنت أتردد في طلب المساعدة وأضيع وقتاً، فصرت أحدد لنفسي 30 دقيقة ثم أسأل".',
    explanation:
        '• تجنب الأجوبة المستهلكة: "أنا perfectionist" أو "أعمل كثيراً".\n'
        '• الهدف إظهار الوعي الذاتي والرغبة في التطور.',
  ),

  // ─────────────────────────── صعب ───────────────────────────
  Question(
    id: 3031,
    level: Level.hard,
    category: Category.git,
    question: 'قارن بين استراتيجيات الفروع: Git Flow و GitHub Flow و Trunk-based.',
    answer:
        'Git Flow: فروع main و develop و feature و release و hotfix، مناسب للإصدارات المجدولة لكنه معقد. GitHub Flow: main دائماً قابل للنشر وفروع feature قصيرة مع PR. Trunk-based: الجميع يدمج في main بشكل متكرر جداً (يومياً) مع Feature Flags، ويتطلب CI قوياً.',
    explanation:
        '• تطبيقات الموبايل (إصدارات عبر المتاجر) قد تستفيد من فروع release.\n'
        '• خدمات الويب مع نشر مستمر تناسبها GitHub Flow أو Trunk-based.\n'
        '• Feature Flags تسمح بدمج كود غير مكتمل دون تفعيله للمستخدمين.',
  ),
  Question(
    id: 3032,
    level: Level.hard,
    category: Category.git,
    question: 'كيف تنظف تاريخ commits قبل الدمج؟ ولماذا --force-with-lease بدل --force؟',
    answer:
        'باستخدام git rebase -i لدمج (squash) أو تعديل أو إعادة ترتيب أو حذف commits، أو commit --amend لتعديل آخر commit. بعدها نحتاج push بالقوة، و --force-with-lease يرفض الرفع إذا أضاف شخص آخر commits للفرع البعيد منذ آخر fetch، فلا تمسح عمله.',
    explanation:
        '• --force يستبدل الفرع البعيد بدون أي تحقق ⚠️.\n'
        '• لا تعيد كتابة تاريخ main أو أي فرع مشترك.\n'
        '• git commit --fixup مع rebase --autosquash طريقة مرتبة.',
    code: r'''git rebase -i HEAD~4
# pick  a1 Add login UI
# squash b2 fix typo
# squash c3 fix lint
# reword d4 Add validation

git push --force-with-lease''',
  ),
  Question(
    id: 3033,
    level: Level.hard,
    category: Category.git,
    question: 'حذفت commits بالخطأ بـ reset --hard. كيف تستعيدها؟ وما هو git bisect؟',
    answer:
        'git reflog يسجل كل حركات HEAD محلياً (حتى المحذوفة)، فنجد hash الـ commit ونعود إليه بـ reset أو ننشئ منه فرعاً. git bisect يبحث ثنائياً في التاريخ لإيجاد أول commit سبّب bug.',
    explanation:
        '• الـ commits "المحذوفة" تبقى فترة (عادة 90 يوماً) قبل أن يحذفها garbage collection.\n'
        '• التعديلات غير المحفوظة في commit لا يمكن استعادتها بـ reflog.\n'
        '• bisect مع 1000 commit يحتاج ~10 خطوات فقط (log₂ 1000)، ويمكن أتمتته بـ git bisect run.',
    code: r'''git reflog
git reset --hard HEAD@{3}

git bisect start
git bisect bad            # الإصدار الحالي فيه الخطأ
git bisect good v1.2.0    # هذا الإصدار كان سليماً
# ... اختبر وأجب good/bad حتى يظهر الـ commit المسبب
git bisect reset''',
  ),
  Question(
    id: 3034,
    level: Level.hard,
    category: Category.web,
    question: 'ماذا يحدث عندما تكتب رابطاً في المتصفح وتضغط Enter؟',
    answer:
        'تحليل الرابط ← DNS لتحويل النطاق إلى IP (مع الكاش) ← اتصال TCP (three-way handshake) ← TLS handshake لـ HTTPS ← إرسال طلب HTTP ← الخادم (Load balancer ← Web server ← التطبيق ← قاعدة البيانات) يعالج ويرد ← المتصفح يحلل HTML ويبني DOM و CSSOM ويحمل الموارد ← Layout ← Paint.',
    explanation:
        '• سؤال مفتوح؛ ابدأ بالخطوط العريضة ثم تعمق فيما تعرفه جيداً.\n'
        '• نقاط إضافية: CDN، HTTP/2 و HTTP/3، Cache headers، Keep-alive.',
  ),
  Question(
    id: 3035,
    level: Level.hard,
    category: Category.security,
    question: 'كيف يعمل HTTPS / TLS باختصار؟',
    answer:
        'يرسل الخادم شهادته (Certificate) الموقعة من جهة موثوقة (CA) فيتحقق العميل من هوية الخادم. يتفق الطرفان عبر تشفير غير متماثل (مثل ECDHE) على مفتاح جلسة سري، ثم تُشفر كل البيانات بتشفير متماثل سريع (مثل AES) بهذا المفتاح.',
    explanation:
        '• التشفير غير المتماثل بطيء، فيُستخدم فقط لتبادل المفتاح.\n'
        '• يضمن: السرية، سلامة البيانات، والتحقق من هوية الخادم.\n'
        '• Certificate Pinning في تطبيقات الموبايل يمنع هجمات Man-in-the-Middle حتى مع شهادة مزيفة مثبتة على الجهاز.',
  ),
  Question(
    id: 3036,
    level: Level.hard,
    category: Category.security,
    question: 'اشرح هجمات XSS و CSRF و SQL Injection وطرق الحماية.',
    answer:
        'XSS: حقن JavaScript خبيث يُنفذ في متصفح الضحايا ← الحماية: escaping للمخرجات و Content-Security-Policy و HttpOnly cookies. CSRF: إجبار متصفح مستخدم مسجل على إرسال طلب ← الحماية: CSRF tokens و SameSite cookies. SQL Injection: حقن SQL في المدخلات ← الحماية: Prepared Statements.',
    explanation:
        '• القاعدة العامة: لا تثق بأي مدخل من المستخدم.\n'
        '• راجع قائمة OWASP Top 10: Broken Access Control هو الأخطر حالياً (مثلاً: تغيير id في الرابط لرؤية طلب شخص آخر ← IDOR).\n'
        '• حدّث المكتبات باستمرار.',
  ),
  Question(
    id: 3037,
    level: Level.hard,
    category: Category.security,
    question: 'كيف تخزن كلمات المرور بشكل آمن؟',
    answer:
        'لا تُخزن نصاً ولا تُشفّر (encryption قابل للفك)، بل تُحوّل بدالة Hash بطيئة مصممة لكلمات المرور مثل bcrypt أو Argon2، مع salt عشوائي فريد لكل مستخدم.',
    explanation:
        '• MD5 و SHA-256 سريعة جداً ← سهلة الكسر بالتخمين (brute force).\n'
        '• الـ salt يمنع Rainbow Tables ويجعل كلمتي مرور متطابقتين بـ hash مختلف.\n'
        '• Laravel: Hash::make و Hash::check (bcrypt افتراضياً).\n'
        '• أضف: Rate limiting على تسجيل الدخول، و 2FA.',
  ),
  Question(
    id: 3038,
    level: Level.hard,
    category: Category.web,
    question: 'ما معنى Idempotent و Safe في HTTP Methods؟',
    answer:
        'Safe: لا يغير حالة الخادم (GET, HEAD, OPTIONS). Idempotent: تنفيذه مرة أو عدة مرات يعطي نفس الحالة النهائية (GET, PUT, DELETE). POST ليس idempotent: تكراره ينشئ عدة سجلات، و PATCH ليس idempotent بالضرورة.',
    explanation:
        '• مهم لإعادة المحاولة التلقائية عند انقطاع الشبكة: آمن مع PUT، خطر مع POST.\n'
        '• لجعل POST آمناً للتكرار (مثل الدفع): Idempotency-Key header.\n'
        '• مثال PATCH غير idempotent: { "increment": 1 }.',
  ),
  Question(
    id: 3039,
    level: Level.hard,
    category: Category.web,
    question: 'اشرح HTTP Caching (Cache-Control و ETag).',
    answer:
        'Cache-Control يحدد هل وكم يُخزن الرد (max-age, no-cache, no-store, private, public). ETag بصمة لنسخة المورد: يرسلها العميل في If-None-Match، فإن لم يتغير المورد يرد الخادم 304 Not Modified بدون body، فيوفر الشبكة.',
    explanation:
        '• no-cache لا تعني "لا تخزن"، بل "تحقق من الخادم قبل الاستخدام"؛ no-store هي "لا تخزن أبداً".\n'
        '• الملفات الثابتة بأسماء فيها hash: max-age طويل جداً مع immutable.\n'
        '• طبقات الكاش: المتصفح ← CDN ← Reverse proxy ← كاش التطبيق ← قاعدة البيانات.',
  ),
  Question(
    id: 3040,
    level: Level.hard,
    category: Category.practices,
    question: 'Monolith أم Microservices؟',
    answer:
        'Monolith: تطبيق واحد ينشر كوحدة، أبسط في التطوير والنشر والتصحيح، ومناسب لمعظم الفرق والمشاريع في بدايتها. Microservices: خدمات مستقلة لكل منها قاعدة بيانات ونشر مستقل، تتوسع بشكل منفصل وتناسب فرقاً كبيرة، لكنها تضيف تعقيداً كبيراً (شبكة، تتبع، اتساق بيانات).',
    explanation:
        '• ابدأ بـ Modular Monolith بحدود واضحة بين الأجزاء، وافصل لاحقاً عند الحاجة الفعلية.\n'
        '• تحديات Microservices: Distributed transactions (Saga)، Observability، إصدارات الـ API.\n'
        '• الجواب الناضج يذكر الـ trade-offs وحجم الفريق.',
  ),
  Question(
    id: 3041,
    level: Level.hard,
    category: Category.patterns,
    question: 'اشرح أنماط Strategy و Adapter و Repository مع مثال.',
    answer:
        'Strategy: عائلة خوارزميات قابلة للتبديل خلف واجهة واحدة (طرق دفع، طرق شحن). Adapter: يغلّف كلاساً بواجهة غير متوافقة ليناسب الواجهة التي يتوقعها كودك (تغليف مكتبة خارجية). Repository: يعزل منطق الوصول للبيانات خلف واجهة، فلا يعرف باقي الكود إن كانت من API أو قاعدة محلية.',
    explanation:
        '• Strategy يستبدل سلاسل if/else أو switch الطويلة ← يحقق Open/Closed.\n'
        '• Adapter يحميك من تغيير المكتبات الخارجية.\n'
        '• Repository مع Offline-first: يقرر بين الكاش والشبكة.',
    code: r'''abstract interface class PaymentStrategy {
  Future<void> pay(double amount);
}

class CardPayment implements PaymentStrategy {
  @override
  Future<void> pay(double amount) async { /* ... */ }
}

class WalletPayment implements PaymentStrategy {
  @override
  Future<void> pay(double amount) async { /* ... */ }
}

class Checkout {
  Checkout(this.strategy);
  final PaymentStrategy strategy;
  Future<void> complete(double total) => strategy.pay(total);
}''',
  ),
  Question(
    id: 3042,
    level: Level.hard,
    category: Category.practices,
    question: 'ما الفرق بين Vertical و Horizontal Scaling؟ وما هو Load Balancer؟',
    answer:
        'Vertical: تكبير الخادم نفسه (CPU و RAM أكثر)، سهل لكن له حد أعلى ونقطة فشل واحدة. Horizontal: إضافة خوادم أكثر، يتطلب أن يكون التطبيق Stateless. Load Balancer يوزع الطلبات على الخوادم ويستبعد الخادم المعطل عبر Health checks.',
    explanation:
        '• Stateless يعني: الجلسات والملفات والكاش خارج الخادم (Redis, S3).\n'
        '• خوارزميات التوزيع: Round Robin, Least Connections, IP Hash.\n'
        '• قاعدة البيانات عادة أصعب جزء في التوسع الأفقي.',
  ),
  Question(
    id: 3043,
    level: Level.hard,
    category: Category.dsa,
    question: 'كيف يعمل Hash Table داخلياً؟ وما هي الـ Collisions؟',
    answer:
        'يحوّل المفتاح بدالة hash إلى رقم يحدد مكانه (bucket) في مصفوفة، فيكون البحث O(1) في المتوسط. Collision يحدث عندما يُعطي مفتاحان نفس المكان، ويُحل بـ Chaining (قائمة في كل bucket) أو Open Addressing (البحث عن مكان فارغ تالٍ).',
    explanation:
        '• عند امتلاء الجدول (load factor مرتفع) يُعاد إنشاؤه بحجم أكبر (rehashing).\n'
        '• أسوأ حالة O(n) إذا تجمعت كل المفاتيح في bucket واحد.\n'
        '• لذلك يجب أن تتسق hashCode مع == (في Dart و Java): كائنان متساويان ← نفس hashCode.',
  ),
  Question(
    id: 3044,
    level: Level.hard,
    category: Category.dsa,
    question: 'ما هو Recursion؟ وما علاقته بـ Memoization و Dynamic Programming؟',
    answer:
        'Recursion: دالة تستدعي نفسها لحل مشكلة أصغر حتى تصل لحالة أساس (base case). إذا تكررت نفس الحسابات الفرعية (مثل Fibonacci) نخزن نتائجها (Memoization)، وهذا جوهر Dynamic Programming، فيتحول التعقيد من أُسّي إلى خطي.',
    explanation:
        '• بدون base case ← Stack Overflow.\n'
        '• كل استدعاء يستهلك إطاراً في الـ Call Stack، فالعمق الكبير خطر.\n'
        '• DP يمكن تنفيذه top-down (memoization) أو bottom-up (جدول وحلقة).',
    code: r'''// O(2ⁿ)
int fib(int n) => n < 2 ? n : fib(n - 1) + fib(n - 2);

// O(n) مع memoization
final _memo = <int, int>{};
int fibFast(int n) {
  if (n < 2) return n;
  return _memo[n] ??= fibFast(n - 1) + fibFast(n - 2);
}''',
  ),
  Question(
    id: 3045,
    level: Level.hard,
    category: Category.practices,
    question: 'System Design: كيف تصمم خدمة لتقصير الروابط (مثل bit.ly)؟',
    answer:
        'API: POST لإنشاء رابط قصير و GET /{code} للتحويل (301/302). التوليد: رقم تسلسلي فريد يُحوّل إلى Base62 (قصير وبدون تكرار). التخزين: جدول (code, long_url, created_at) مع فهرس على code. الأداء: القراءة أكثر بكثير من الكتابة، لذلك Cache (Redis) أمام قاعدة البيانات، ثم Read replicas و CDN.',
    explanation:
        '• ابدأ دائماً بتوضيح المتطلبات: عدد المستخدمين، نسبة القراءة للكتابة، مدة صلاحية الروابط، الإحصائيات.\n'
        '• قدّر الأرقام تقريبياً (الطلبات في الثانية، حجم التخزين).\n'
        '• ارسم المكونات، ثم ناقش نقاط الاختناق والـ trade-offs.\n'
        '• الإحصائيات (النقرات) تُسجل بشكل غير متزامن عبر Queue.',
  ),
  Question(
    id: 3049,
    level: Level.hard,
    category: Category.soft,
    question: 'كيف تتعامل مع خلاف تقني مع زميل أو مع مراجعة كود قاسية؟',
    answer:
        'أفصل بين الشخص والكود، أستمع لفهم وجهة النظر، وأعتمد على الحقائق (قياسات، توثيق، تجربة صغيرة) بدل الآراء، وأحياناً أقترح الاكتفاء بقرار "جيد بما يكفي" مع إمكانية المراجعة لاحقاً. وإن لم نتفق، نصعّد للقائد التقني بهدوء، وألتزم بالقرار النهائي.',
    explanation:
        '• المقابل يختبر نضجك وقدرتك على العمل ضمن فريق.\n'
        '• أعطِ مثالاً حقيقياً بطريقة STAR.\n'
        '• في مراجعة الكود: اعتبر التعليقات على الكود وليست عليك، واشكر المراجع.',
  ),
];
