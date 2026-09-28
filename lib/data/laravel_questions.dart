import '../models/question.dart';

const List<Question> laravelQuestions = [
  // ─────────────────────────── سهل ───────────────────────────
  Question(
    id: 1001,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو Laravel ولماذا نستخدمه؟',
    answer:
        'Laravel هو إطار عمل PHP مفتوح المصدر مبني على نمط MVC، يسرّع تطوير تطبيقات الويب والـ API بتوفير أدوات جاهزة: Routing و Eloquent ORM و Migrations و Authentication و Queues و Blade.',
    explanation:
        '• يوفر كوداً منظماً وقابلاً للصيانة بدل كتابة كل شيء من الصفر.\n'
        '• نظام بيئي غني: Sanctum, Horizon, Telescope, Forge, Vapor, Livewire.\n'
        '• حماية جاهزة من CSRF و SQL Injection و XSS.\n'
        '• أداة Artisan لتوليد الكود وتنفيذ المهام.',
  ),
  Question(
    id: 1002,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'اشرح نمط MVC في Laravel.',
    answer:
        'Model يمثل البيانات والتعامل مع قاعدة البيانات، View يعرض الواجهة (Blade)، و Controller يستقبل الطلب وينسق بين الـ Model والـ View ويرجع الاستجابة.',
    explanation:
        '• الطلب ← Route ← Controller ← Model ← Controller ← View / JSON.\n'
        '• الفائدة: فصل المسؤوليات وسهولة الصيانة والاختبار.\n'
        '• في تطبيقات الـ API غالباً تُستبدل الـ View بـ JSON أو API Resource.',
  ),
  Question(
    id: 1003,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو Artisan؟ اذكر أوامر شائعة.',
    answer:
        'Artisan هو واجهة سطر الأوامر في Laravel، يُستخدم لتوليد الملفات وتنفيذ الـ migrations وتشغيل الخادم وتنظيف الكاش وغيرها، ويمكن كتابة أوامر مخصصة.',
    explanation:
        '• يمكنك إنشاء أمر خاص بك: php artisan make:command.\n'
        '• php artisan list لعرض كل الأوامر.',
    code: r'''php artisan serve
php artisan make:model Post -mcr   # model + migration + resource controller
php artisan migrate
php artisan migrate:fresh --seed
php artisan route:list
php artisan tinker
php artisan optimize:clear''',
  ),
  Question(
    id: 1004,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'كيف تعرّف Route في Laravel؟ وما الفرق بين web.php و api.php؟',
    answer:
        'نعرّف الـ routes في مجلد routes باستخدام Route::get / post / put / delete. web.php للصفحات ويستخدم session و CSRF، و api.php للـ API وهو stateless وتضاف له البادئة /api تلقائياً.',
    explanation:
        '• يمكن تمرير parameters: /posts/{id}.\n'
        '• Route::name() لتسمية الـ route واستخدامه بـ route(\'posts.show\').\n'
        '• Route::middleware() و Route::prefix() و Route::group() للتجميع.',
    code: r'''Route::get('/posts/{post}', [PostController::class, 'show'])
    ->name('posts.show');

Route::middleware('auth')->prefix('admin')->group(function () {
    Route::resource('users', UserController::class);
});''',
  ),
  Question(
    id: 1005,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هي الـ Migrations؟',
    answer:
        'ملفات PHP تصف تغييرات هيكل قاعدة البيانات (إنشاء جداول، أعمدة، فهارس) وتعمل كنظام تحكم بالإصدارات لقاعدة البيانات، بحيث يحصل كل فريق التطوير على نفس الهيكل.',
    explanation:
        '• دالة up() لتطبيق التغيير و down() للتراجع عنه.\n'
        '• migrate لتنفيذها و migrate:rollback للتراجع.\n'
        '• لا تعدّل migration نُفّذ على الإنتاج، بل أنشئ واحداً جديداً.',
    code: r'''Schema::create('posts', function (Blueprint $table) {
    $table->id();
    $table->foreignId('user_id')->constrained()->cascadeOnDelete();
    $table->string('title');
    $table->text('body');
    $table->timestamps();
});''',
  ),
  Question(
    id: 1006,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو Blade؟',
    answer:
        'محرك القوالب (Template Engine) في Laravel. يسمح بكتابة HTML مع تعليمات مختصرة مثل @if و @foreach و {{ }}، ويُترجم إلى PHP ويُخزّن مؤقتاً للأداء.',
    explanation:
        '• {{ \$var }} تطبع القيمة مع escaping تلقائي ضد XSS.\n'
        '• {!! \$var !!} تطبع بدون escaping (خطر، استخدمها بحذر).\n'
        '• @extends و @section و @yield للقوالب الرئيسية، و Components لإعادة الاستخدام.',
    code: r'''@extends('layouts.app')

@section('content')
    @foreach ($posts as $post)
        <h2>{{ $post->title }}</h2>
    @endforeach
@endsection''',
  ),
  Question(
    id: 1007,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو ملف .env ولماذا لا نرفعه على Git؟',
    answer:
        'ملف متغيرات البيئة: يحتوي إعدادات تختلف من بيئة لأخرى مثل بيانات قاعدة البيانات ومفاتيح الـ API و APP_KEY. لا نرفعه لأنه يحتوي أسراراً، ونرفع بدلاً منه .env.example.',
    explanation:
        '• نقرأ القيم داخل ملفات config فقط بـ env()، وفي باقي الكود نستخدم config().\n'
        '• السبب: بعد config:cache لا تُقرأ env() خارج ملفات config.\n'
        '• APP_DEBUG=false دائماً على الإنتاج.',
  ),
  Question(
    id: 1008,
    level: Level.easy,
    category: Category.php,
    question: 'ما هو Composer؟',
    answer:
        'مدير الحزم (Package Manager) في PHP. يثبت المكتبات المذكورة في composer.json ويدير إصداراتها، ويوفر autoloading للكلاسات حسب معيار PSR-4.',
    explanation:
        '• composer.lock يثبت الإصدارات الدقيقة، ويجب رفعه على Git.\n'
        '• composer install يثبت من الـ lock، و composer update يحدث الإصدارات.\n'
        '• على الإنتاج: composer install --no-dev --optimize-autoloader.',
  ),
  Question(
    id: 1009,
    level: Level.easy,
    category: Category.eloquent,
    question: 'ما هو Eloquent ORM؟',
    answer:
        'الـ ORM الخاص بـ Laravel: كل جدول يقابله Model، ونتعامل مع السجلات ككائنات PHP بدل كتابة SQL يدوياً، مع دعم العلاقات بين الجداول.',
    explanation:
        '• مبني على نمط Active Record: الكائن نفسه يعرف كيف يحفظ نفسه (save).\n'
        '• اسم الجدول يُستنتج من اسم الـ Model بصيغة الجمع (Post ← posts).\n'
        '• يمكن استخدام Query Builder مباشرة لاستعلامات معقدة.',
    code: r'''$post = Post::create(['title' => 'Hi', 'body' => '...']);
$posts = Post::where('published', true)->latest()->get();
$post->update(['title' => 'New']);
$post->delete();''',
  ),
  Question(
    id: 1010,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو الـ Middleware؟',
    answer:
        'طبقة تمر عبرها الطلبات قبل الوصول للـ Controller (أو بعد الاستجابة)، تُستخدم للتحقق من تسجيل الدخول، الصلاحيات، اللغة، تسجيل الطلبات، Rate limiting...',
    explanation:
        '• أمثلة جاهزة: auth, guest, throttle, verified.\n'
        '• تُنشأ بـ php artisan make:middleware.\n'
        '• \$next(\$request) لتمرير الطلب للطبقة التالية.',
    code: r'''class EnsureUserIsAdmin
{
    public function handle(Request $request, Closure $next)
    {
        if (! $request->user()?->is_admin) {
            abort(403);
        }
        return $next($request);
    }
}''',
  ),
  Question(
    id: 1011,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما الفرق بين Seeders و Factories؟',
    answer:
        'Factory يولّد بيانات وهمية لـ Model معين (باستخدام Faker). Seeder يملأ قاعدة البيانات ببيانات أولية، وغالباً يستخدم الـ Factories.',
    explanation:
        '• Factories أساسية في الاختبارات.\n'
        '• Seeders مفيدة لبيانات ثابتة (أدوار، دول) أو بيانات تجريبية.\n'
        '• php artisan db:seed.',
    code: r'''// Factory
public function definition(): array
{
    return ['name' => fake()->name(), 'email' => fake()->unique()->safeEmail()];
}

// Seeder
User::factory()->count(10)->has(Post::factory()->count(3))->create();''',
  ),
  Question(
    id: 1012,
    level: Level.easy,
    category: Category.php,
    question: 'ما الفرق بين == و === في PHP؟',
    answer:
        '== يقارن القيم بعد تحويل الأنواع (loose)، أما === فيقارن القيمة والنوع معاً (strict).',
    explanation:
        '• 0 == "0" ← true، و 0 === "0" ← false.\n'
        '• استخدم === دائماً لتجنب أخطاء غير متوقعة.\n'
        '• في PHP 8 تغيرت مقارنة الأرقام بالنصوص: 0 == "abc" أصبحت false.',
  ),
  Question(
    id: 1013,
    level: Level.easy,
    category: Category.laravelSecurity,
    question: 'ما هو CSRF وكيف يحمي Laravel منه؟',
    answer:
        'CSRF هجوم يجعل متصفح المستخدم المسجل يرسل طلباً من موقع آخر دون علمه. Laravel يولد token لكل جلسة ويتحقق منه في كل طلب POST/PUT/DELETE عبر middleware، ونضعه في الفورم بـ @csrf.',
    explanation:
        '• بدون token صحيح يرجع خطأ 419.\n'
        '• routes الـ API التي تستخدم tokens (وليس cookies) لا تحتاجه.\n'
        '• يمكن استثناء routes مثل webhooks.',
    code: r'''<form method="POST" action="/posts">
    @csrf
    <input name="title">
</form>''',
  ),
  Question(
    id: 1014,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'كيف تتحقق من صحة البيانات (Validation) في Laravel؟',
    answer:
        'باستخدام \$request->validate([...]) داخل الـ Controller أو بكلاس Form Request. إذا فشل التحقق يعيد Laravel المستخدم مع الأخطاء تلقائياً، أو يرجع 422 مع JSON للـ API.',
    explanation:
        '• قواعد شائعة: required, email, unique:users, min, max, confirmed, exists.\n'
        '• validate() ترجع البيانات المتحقق منها فقط، استخدمها بدل \$request->all().',
    code: r'''$data = $request->validate([
    'title' => ['required', 'string', 'max:255'],
    'email' => ['required', 'email', 'unique:users,email'],
]);''',
  ),
  Question(
    id: 1015,
    level: Level.easy,
    category: Category.laravelBasics,
    question: 'ما هو Resource Controller؟',
    answer:
        'Controller يحتوي الدوال السبع القياسية لعمليات CRUD: index, create, store, show, edit, update, destroy، ويُربط بسطر واحد Route::resource.',
    explanation:
        '• للـ API نستخدم Route::apiResource (بدون create و edit لأنها صفحات HTML).\n'
        '• php artisan make:controller PostController --resource.',
    code: r'''Route::resource('posts', PostController::class);
Route::apiResource('api/posts', Api\PostController::class);''',
  ),

  // ─────────────────────────── متوسط ───────────────────────────
  Question(
    id: 1016,
    level: Level.medium,
    category: Category.laravelBasics,
    question: 'اشرح دورة حياة الطلب (Request Lifecycle) في Laravel.',
    answer:
        'public/index.php ← تحميل autoload وإنشاء التطبيق (bootstrap/app.php) ← HTTP Kernel ← تسجيل وتشغيل Service Providers ← Middleware العامة ← Router يطابق الـ route ← Middleware الـ route ← Controller ← Response يعود عبر نفس الـ Middleware ← يُرسل للمتصفح.',
    explanation:
        '• كل الطلبات تدخل من public/index.php.\n'
        '• الـ Service Providers هي مرحلة إعداد التطبيق (bootstrapping).\n'
        '• فهم هذه الدورة يساعد في معرفة أين تضع الكود (Middleware أم Provider أم Controller).',
  ),
  Question(
    id: 1017,
    level: Level.medium,
    category: Category.laravelAdvanced,
    question: 'ما هو Service Container و Dependency Injection في Laravel؟',
    answer:
        'Service Container هو المكون الذي يدير إنشاء الكائنات وتبعياتها. عندما تطلب كلاساً في constructor أو دالة Controller، يقوم Laravel بحله تلقائياً (auto-resolving) وحقنه لك.',
    explanation:
        '• bind: ينشئ كائناً جديداً كل مرة.\n'
        '• singleton: كائن واحد طوال الطلب.\n'
        '• ربط interface بـ implementation يسهل التبديل والاختبار.',
    code: r'''// AppServiceProvider::register
$this->app->bind(PaymentGateway::class, StripeGateway::class);

// Controller: Laravel يحقن StripeGateway تلقائياً
public function __construct(private PaymentGateway $gateway) {}''',
  ),
  Question(
    id: 1018,
    level: Level.medium,
    category: Category.laravelAdvanced,
    question: 'ما هو Service Provider؟ وما الفرق بين register و boot؟',
    answer:
        'Service Providers هي المكان المركزي لإعداد التطبيق. register() لتسجيل الـ bindings في الـ Container فقط، و boot() يُنفذ بعد تسجيل كل الـ Providers ويُستخدم لأي شيء يعتمد على خدمات أخرى (events, routes, macros, gates).',
    explanation:
        '• لا تستخدم خدمات أخرى داخل register لأنها قد لا تكون سُجلت بعد.\n'
        '• Deferred providers تُحمّل فقط عند الحاجة لتحسين الأداء.',
  ),
  Question(
    id: 1019,
    level: Level.medium,
    category: Category.eloquent,
    question: 'اشرح أنواع العلاقات في Eloquent.',
    answer:
        'hasOne / belongsTo (واحد لواحد)، hasMany / belongsTo (واحد لكثير)، belongsToMany (كثير لكثير عبر جدول وسيط pivot)، hasManyThrough، والعلاقات Polymorphic.',
    explanation:
        '• belongsTo يكون في الـ Model الذي يحتوي الـ foreign key.\n'
        '• belongsToMany يحتاج جدولاً وسيطاً مثل role_user، ونصل لأعمدته بـ ->pivot.\n'
        '• attach / detach / sync لإدارة علاقات many-to-many.',
    code: r'''class User extends Model {
    public function posts() { return $this->hasMany(Post::class); }
    public function roles() { return $this->belongsToMany(Role::class)->withTimestamps(); }
}

class Post extends Model {
    public function user() { return $this->belongsTo(User::class); }
}

$user->roles()->sync([1, 3]);''',
  ),
  Question(
    id: 1020,
    level: Level.medium,
    category: Category.eloquent,
    question: 'ما هي مشكلة N+1 وكيف تحلها؟',
    answer:
        'عندما تجلب N سجل ثم تصل لعلاقة كل واحد منها داخل حلقة، فيُنفذ استعلام لكل سجل (1 + N استعلام). الحل: Eager Loading باستخدام with() لجلب العلاقة باستعلام واحد إضافي.',
    explanation:
        '• 100 منشور مع كاتبها = 101 استعلام بدون with، و 2 فقط معها.\n'
        '• Model::preventLazyLoading() في بيئة التطوير لاكتشاف المشكلة مبكراً.\n'
        '• load() للتحميل بعد جلب البيانات، و withCount() لعد العلاقات.',
    code: r'''// ❌ N+1
foreach (Post::all() as $post) {
    echo $post->user->name;
}

// ✔️ استعلامان فقط
foreach (Post::with('user')->get() as $post) {
    echo $post->user->name;
}''',
  ),
  Question(
    id: 1021,
    level: Level.medium,
    category: Category.laravelSecurity,
    question: 'ما هو Mass Assignment وما فائدة \$fillable و \$guarded؟',
    answer:
        'Mass Assignment هو تمرير مصفوفة كاملة لـ create() أو update(). الخطر أن يرسل المستخدم حقلاً غير متوقع مثل is_admin. \$fillable يحدد الحقول المسموحة، و \$guarded يحدد الممنوعة.',
    explanation:
        '• لا تمرر \$request->all() أبداً، بل \$request->validated().\n'
        '• \$guarded = [] يلغي الحماية بالكامل، فاستخدمه بحذر.',
    code: r'''class User extends Model
{
    protected $fillable = ['name', 'email', 'password'];
}

User::create($request->validated());''',
  ),
  Question(
    id: 1022,
    level: Level.medium,
    category: Category.laravelBasics,
    question: 'ما هو Form Request ولماذا نستخدمه؟',
    answer:
        'كلاس مخصص يحتوي قواعد التحقق (rules) والصلاحية (authorize) لطلب معين. يُحقن في الـ Controller ويتحقق تلقائياً قبل تنفيذ الدالة، فيبقى الـ Controller نظيفاً.',
    explanation:
        '• php artisan make:request StorePostRequest.\n'
        '• authorize() ترجع false ← 403.\n'
        '• يمكن تخصيص الرسائل بـ messages() وتجهيز البيانات بـ prepareForValidation().',
    code: r'''class StorePostRequest extends FormRequest
{
    public function authorize(): bool
    {
        return $this->user()->can('create', Post::class);
    }

    public function rules(): array
    {
        return ['title' => 'required|max:255', 'body' => 'required'];
    }
}

public function store(StorePostRequest $request)
{
    return Post::create($request->validated());
}''',
  ),
  Question(
    id: 1023,
    level: Level.medium,
    category: Category.laravelApi,
    question: 'ما الفرق بين Sanctum و Passport؟',
    answer:
        'Sanctum خفيف ومناسب لتطبيقات SPA وتطبيقات الموبايل عبر API tokens بسيطة أو cookies. Passport تطبيق كامل لـ OAuth2 ومناسب عندما تحتاج أن تسمح لتطبيقات خارجية (third-party) بالوصول نيابة عن المستخدم.',
    explanation:
        '• معظم المشاريع (مثل تطبيق Flutter مع Laravel API) يكفيها Sanctum.\n'
        '• Sanctum يدعم abilities (صلاحيات للتوكن).\n'
        '• Passport أعقد ويحتاج clients و grants.',
    code: r'''// تسجيل الدخول وإصدار توكن
$token = $user->createToken('mobile', ['posts:write'])->plainTextToken;

// حماية الـ routes
Route::middleware('auth:sanctum')->get('/me', fn (Request $r) => $r->user());''',
  ),
  Question(
    id: 1024,
    level: Level.medium,
    category: Category.laravelApi,
    question: 'ما هي API Resources؟',
    answer:
        'طبقة تحويل بين الـ Model وشكل الـ JSON المُرجع. تتيح التحكم بالحقول المعروضة وإخفاء الحساسة وتنسيق البيانات وإضافة العلاقات بشكل شرطي.',
    explanation:
        '• تفصل شكل الـ API عن هيكل قاعدة البيانات، فتغيير عمود لا يكسر التطبيق.\n'
        '• whenLoaded() لإضافة العلاقة فقط إن حُمّلت (تمنع N+1).\n'
        '• Resource::collection() للقوائم مع دعم pagination.',
    code: r'''class PostResource extends JsonResource
{
    public function toArray($request): array
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'author' => new UserResource($this->whenLoaded('user')),
            'created_at' => $this->created_at->toIso8601String(),
        ];
    }
}''',
  ),
  Question(
    id: 1025,
    level: Level.medium,
    category: Category.eloquent,
    question: 'ما هي Accessors و Mutators و Casts؟',
    answer:
        'Accessor يعدّل القيمة عند قراءتها، و Mutator يعدّلها عند حفظها. Casts تحول نوع العمود تلقائياً (مثل json إلى array أو datetime إلى Carbon أو boolean).',
    explanation:
        '• في الإصدارات الحديثة نستخدم Attribute::make(get:, set:).\n'
        '• Casts مفيدة جداً: \'settings\' => \'array\'، \'password\' => \'hashed\'.\n'
        '• يمكن إنشاء Custom Casts و Enum casts.',
    code: r'''protected function name(): Attribute
{
    return Attribute::make(
        get: fn ($value) => ucfirst($value),
        set: fn ($value) => strtolower($value),
    );
}

protected function casts(): array
{
    return ['is_admin' => 'boolean', 'options' => 'array', 'status' => Status::class];
}''',
  ),
  Question(
    id: 1026,
    level: Level.medium,
    category: Category.laravelAdvanced,
    question: 'ما هي الـ Queues و Jobs ومتى نستخدمها؟',
    answer:
        'الـ Queues تؤجل المهام البطيئة (إرسال إيميل، معالجة صور، استدعاء API خارجي) لتُنفذ في الخلفية بواسطة worker، فيرد التطبيق على المستخدم فوراً.',
    explanation:
        '• Drivers: database, redis, sqs.\n'
        '• php artisan queue:work لتشغيل الـ worker.\n'
        '• \$tries و backoff لإعادة المحاولة، و failed_jobs لتخزين الفاشلة.\n'
        '• Horizon لمراقبة Redis queues.',
    code: r'''class SendWelcomeEmail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    public function __construct(public User $user) {}

    public function handle(): void
    {
        Mail::to($this->user)->send(new WelcomeMail($this->user));
    }
}

SendWelcomeEmail::dispatch($user)->delay(now()->addMinutes(5));''',
  ),
  Question(
    id: 1027,
    level: Level.medium,
    category: Category.laravelAdvanced,
    question: 'ما هي Events و Listeners؟',
    answer:
        'نظام لفصل الكود: نطلق حدثاً (Event) مثل OrderPlaced، وعدة Listeners تستجيب له بشكل مستقل (إرسال إيميل، تحديث المخزون، إشعار)، دون أن يعرف كود الطلب بها.',
    explanation:
        '• يحقق مبدأ Open/Closed: تضيف سلوكاً جديداً بدون تعديل الكود الأصلي.\n'
        '• Listener يمكن أن يكون ShouldQueue ليعمل في الخلفية.\n'
        '• Observers حالة خاصة للاستماع لأحداث Model (created, updated...).',
    code: r'''OrderPlaced::dispatch($order);

class SendOrderConfirmation implements ShouldQueue
{
    public function handle(OrderPlaced $event): void
    {
        Mail::to($event->order->user)->send(new OrderConfirmed($event->order));
    }
}''',
  ),
  Question(
    id: 1028,
    level: Level.medium,
    category: Category.eloquent,
    question: 'ما هو Soft Delete؟',
    answer:
        'بدلاً من حذف السجل فعلياً، يُملأ عمود deleted_at بتاريخ الحذف، ويستثنيه Eloquent تلقائياً من الاستعلامات. يمكن استعادته لاحقاً.',
    explanation:
        '• نضيف trait SoftDeletes و \$table->softDeletes() في الـ migration.\n'
        '• withTrashed() لعرض الكل، onlyTrashed() للمحذوفة فقط.\n'
        '• restore() للاستعادة و forceDelete() للحذف النهائي.\n'
        '• انتبه لقيود unique: السجل المحذوف ما زال موجوداً.',
  ),
  Question(
    id: 1029,
    level: Level.medium,
    category: Category.eloquent,
    question: 'ما هي Local Scopes و Global Scopes؟',
    answer:
        'Local Scope دالة قابلة لإعادة الاستخدام لإضافة شروط على الاستعلام عند الطلب. Global Scope يُطبق تلقائياً على كل استعلامات الـ Model (مثل SoftDeletes أو فلترة حسب الـ tenant).',
    explanation:
        '• Local: تبدأ باسم scope ونستدعيها بدونه.\n'
        '• Global: يمكن تجاوزه بـ withoutGlobalScope().',
    code: r'''public function scopePublished(Builder $query): void
{
    $query->where('published', true);
}

Post::published()->latest()->get();''',
  ),
  Question(
    id: 1030,
    level: Level.medium,
    category: Category.laravelAdvanced,
    question: 'كيف تعمل الـ Facades في Laravel؟',
    answer:
        'الـ Facade يبدو كاستدعاء static (مثل Cache::get) لكنه في الحقيقة وكيل (proxy) يستخدم __callStatic ليجلب الكائن الحقيقي من الـ Service Container ويستدعي الدالة عليه.',
    explanation:
        '• getFacadeAccessor() يرجع اسم الخدمة في الـ Container.\n'
        '• لذلك يمكن اختبارها بسهولة: Cache::shouldReceive() أو Mail::fake().\n'
        '• البديل: حقن التبعية مباشرة (أوضح في الكلاسات الكبيرة).',
  ),

  // ─────────────────────────── صعب ───────────────────────────
  Question(
    id: 1031,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'كيف تحسّن أداء تطبيق Laravel؟',
    answer:
        'على مستوى الإعداد: config:cache و route:cache و view:cache و OPcache و composer --optimize-autoloader. على مستوى الكود: Eager Loading، اختيار الأعمدة المطلوبة فقط، فهارس مناسبة، Cache للنتائج، Queues للمهام الثقيلة، و Pagination.',
    explanation:
        '• أداة القياس أولاً: Telescope أو Debugbar أو Laravel Pulse لمعرفة الاستعلامات البطيئة.\n'
        '• php artisan optimize يجمع أوامر الكاش.\n'
        '• Octane لإبقاء التطبيق في الذاكرة بين الطلبات.\n'
        '• Redis للـ cache والـ sessions بدل الملفات.\n'
        '• CDN للملفات الثابتة.',
  ),
  Question(
    id: 1032,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'ما هو Laravel Octane وما المخاطر عند استخدامه؟',
    answer:
        'Octane يشغل التطبيق عبر خوادم مثل Swoole أو RoadRunner أو FrankenPHP، فيُحمّل التطبيق مرة واحدة في الذاكرة ويخدم طلبات كثيرة، بدل إعادة الإقلاع مع كل طلب، مما يرفع الأداء بشكل كبير.',
    explanation:
        '• الخطر: الحالة تبقى بين الطلبات، مثل المتغيرات static والـ singletons التي تحفظ بيانات مستخدم معين، فتتسرب لطلب مستخدم آخر.\n'
        '• لا تحقن Request أو Config في constructor لـ singleton.\n'
        '• راقب تسرب الذاكرة، واضبط max-requests لإعادة تشغيل الـ workers.',
  ),
  Question(
    id: 1033,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'كيف تستخدم الـ Cache بشكل صحيح؟ وما هي مشكلة Cache Stampede؟',
    answer:
        'Cache::remember يجلب القيمة من الكاش أو ينفذ الاستعلام ويخزنه. Cache Stampede تحدث عندما تنتهي صلاحية مفتاح مطلوب بكثرة، فتنفذ مئات الطلبات نفس الاستعلام الثقيل في نفس اللحظة. الحل: قفل (Cache::lock) أو Stale-while-revalidate (Cache::flexible).',
    explanation:
        '• امسح أو حدث الكاش عند تغيير البيانات (في Observer مثلاً).\n'
        '• Cache tags (مع Redis) لمسح مجموعة مفاتيح مرتبطة.\n'
        '• أضف عشوائية للـ TTL لتجنب انتهاء كثير من المفاتيح معاً.',
    code: r'''$posts = Cache::remember('posts.popular', now()->addMinutes(10), fn () =>
    Post::popular()->take(10)->get()
);

// يرجع القيمة القديمة ويحدّثها في الخلفية
$stats = Cache::flexible('stats', [300, 600], fn () => Stats::compute());''',
  ),
  Question(
    id: 1034,
    level: Level.hard,
    category: Category.eloquent,
    question: 'كيف تمنع Race Condition عند تعديل رصيد أو مخزون؟',
    answer:
        'باستخدام Transaction مع قفل الصف lockForUpdate() حتى لا يقرأ طلب آخر نفس القيمة قبل انتهاء التعديل، أو بتحديث ذري (atomic) مثل decrement مع شرط، أو Atomic Locks عبر Cache::lock للعمليات الأوسع.',
    explanation:
        '• المشكلة: طلبان يقرآن المخزون = 1 معاً ثم كلاهما يبيع ← مخزون سالب.\n'
        '• lockForUpdate يعمل فقط داخل transaction.\n'
        '• التحديث الشرطي بجملة واحدة غالباً أسرع وأبسط.',
    code: r'''DB::transaction(function () use ($productId, $qty) {
    $product = Product::whereKey($productId)->lockForUpdate()->firstOrFail();
    if ($product->stock < $qty) {
        throw new OutOfStockException();
    }
    $product->decrement('stock', $qty);
});

// بديل ذري بجملة واحدة
$updated = Product::whereKey($id)->where('stock', '>=', $qty)
    ->decrement('stock', $qty); // 0 يعني لم ينجح''',
  ),
  Question(
    id: 1035,
    level: Level.hard,
    category: Category.eloquent,
    question: 'ما هي Polymorphic Relationships؟',
    answer:
        'علاقة تسمح لـ Model واحد بالانتماء لأكثر من نوع Model عبر عمودين: commentable_id و commentable_type. مثال: التعليقات تنتمي للمنشورات أو للفيديوهات.',
    explanation:
        '• morphTo في الـ Model الفرعي، و morphMany / morphOne في الأصل.\n'
        '• morphToMany للعلاقة كثير لكثير (مثل tags).\n'
        '• استخدم Relation::enforceMorphMap لتخزين أسماء قصيرة بدل أسماء الكلاسات.\n'
        '• العيب: لا يمكن وضع foreign key حقيقي على مستوى قاعدة البيانات.',
    code: r'''class Comment extends Model {
    public function commentable() { return $this->morphTo(); }
}

class Post extends Model {
    public function comments() { return $this->morphMany(Comment::class, 'commentable'); }
}''',
  ),
  Question(
    id: 1036,
    level: Level.hard,
    category: Category.laravelSecurity,
    question: 'ما الفرق بين Gates و Policies؟',
    answer:
        'كلاهما للتحقق من الصلاحيات (Authorization). Gate دالة closure بسيطة لصلاحية عامة غير مرتبطة بـ Model. Policy كلاس يجمع صلاحيات Model معين (view, update, delete...).',
    explanation:
        '• نستخدم: \$user->can(\'update\', \$post) أو \$this->authorize() أو @can في Blade أو middleware can:.\n'
        '• Gate::before لإعطاء المدير كل الصلاحيات.\n'
        '• Authentication = من أنت؟ و Authorization = ماذا يُسمح لك؟',
    code: r'''class PostPolicy
{
    public function update(User $user, Post $post): bool
    {
        return $user->id === $post->user_id;
    }
}

Gate::define('access-admin', fn (User $user) => $user->is_admin);

$this->authorize('update', $post); // 403 إن لم يُسمح''',
  ),
  Question(
    id: 1037,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'هل تحتاج Repository Pattern مع Eloquent؟',
    answer:
        'الجواب المتوازن: Eloquent بحد ذاته طبقة تجريد، فإضافة Repository لكل Model غالباً تكرار بلا فائدة. لكنه مفيد عند وجود منطق استعلام معقد مشترك، أو عند الحاجة لتبديل المصدر (API خارجي)، أو لعزل الـ Domain في مشاريع كبيرة.',
    explanation:
        '• البدائل الأبسط: Scopes، Query classes، Action / Service classes.\n'
        '• المقابل يبحث عن فهم الـ trade-offs وليس جواباً واحداً.\n'
        '• إن استخدمته: interface + implementation + bind في Service Provider.',
  ),
  Question(
    id: 1038,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'كيف تتعامل مع فشل الـ Jobs وإعادة المحاولة بشكل آمن؟',
    answer:
        'بتحديد \$tries و backoff و timeout، ودالة failed() لمعالجة الفشل النهائي، والأهم جعل الـ Job idempotent (تنفيذه مرتين لا يسبب ضرراً)، مع ShouldBeUnique أو WithoutOverlapping لمنع التكرار.',
    explanation:
        '• مثال مشكلة: Job دفع يُعاد بعد timeout فيُخصم المبلغ مرتين.\n'
        '• الحل: مفتاح idempotency أو التحقق من الحالة قبل التنفيذ.\n'
        '• php artisan queue:retry و queue:failed.\n'
        '• retry_after يجب أن يكون أكبر من timeout.',
    code: r'''class ChargeOrder implements ShouldQueue, ShouldBeUnique
{
    public $tries = 5;
    public $backoff = [10, 60, 300];

    public function uniqueId(): string { return (string) $this->order->id; }

    public function handle(): void
    {
        if ($this->order->isPaid()) return; // idempotent
        $this->gateway->charge($this->order);
    }

    public function failed(Throwable $e): void
    {
        $this->order->markAsFailed();
    }
}''',
  ),
  Question(
    id: 1039,
    level: Level.hard,
    category: Category.eloquent,
    question: 'كيف تعالج جدولاً فيه ملايين السجلات دون استهلاك الذاكرة؟',
    answer:
        'لا تستخدم all() أو get(). استخدم chunkById() لمعالجة دفعات، أو lazyById() / cursor() لقراءة سجل تلو الآخر، أو استعلام update جماعي مباشر إن أمكن.',
    explanation:
        '• chunk() مع تعديل عمود الشرط قد يتخطى سجلات، لذلك chunkById أكثر أماناً.\n'
        '• cursor() يستخدم ذاكرة قليلة لكنه لا يدعم eager loading.\n'
        '• الأفضل تنفيذ العملية داخل Job أو أمر Artisan.',
    code: r'''User::where('active', false)->chunkById(1000, function ($users) {
    foreach ($users as $user) {
        $user->archive();
    }
});

foreach (User::lazyById(500) as $user) { /* ... */ }''',
  ),
  Question(
    id: 1040,
    level: Level.hard,
    category: Category.laravelApi,
    question: 'كيف تطبق Rate Limiting وتحمي الـ API؟',
    answer:
        'بتعريف limiter في RateLimiter::for وتطبيقه بـ middleware throttle، بحدود مختلفة حسب المستخدم أو الـ IP أو الخطة. عند التجاوز يرجع 429 Too Many Requests.',
    explanation:
        '• حدود أشد على login و OTP لمنع brute force.\n'
        '• استخدم Redis كمخزن للعدادات في الإنتاج.\n'
        '• حماية إضافية: Sanctum abilities، التحقق من المدخلات، CORS، HTTPS فقط.',
    code: r'''RateLimiter::for('api', function (Request $request) {
    return $request->user()?->isPremium()
        ? Limit::perMinute(1000)->by($request->user()->id)
        : Limit::perMinute(60)->by($request->user()?->id ?: $request->ip());
});

Route::middleware('throttle:api')->group(/* ... */);''',
  ),
  Question(
    id: 1041,
    level: Level.hard,
    category: Category.laravelTesting,
    question: 'كيف تكتب اختبارات في Laravel؟ وما الفرق بين Feature و Unit Tests؟',
    answer:
        'Feature Test يختبر ميزة كاملة عبر طلب HTTP مع قاعدة البيانات. Unit Test يختبر كلاساً أو دالة بمعزل. نستخدم RefreshDatabase و Factories، و Fakes مثل Mail::fake و Queue::fake و Http::fake لعزل الخدمات الخارجية.',
    explanation:
        '• PHPUnit أو Pest.\n'
        '• actingAs(\$user) لتسجيل الدخول في الاختبار.\n'
        '• assertDatabaseHas و assertJson و assertStatus.\n'
        '• قاعدة SQLite in-memory أسرع للاختبار، لكن الأفضل نفس نوع قاعدة الإنتاج.',
    code: r'''it('creates a post', function () {
    Queue::fake();
    $user = User::factory()->create();

    $this->actingAs($user)
        ->postJson('/api/posts', ['title' => 'Hi', 'body' => 'Text'])
        ->assertCreated()
        ->assertJsonPath('data.title', 'Hi');

    $this->assertDatabaseHas('posts', ['title' => 'Hi', 'user_id' => $user->id]);
    Queue::assertPushed(NotifyFollowers::class);
});''',
  ),
  Question(
    id: 1042,
    level: Level.hard,
    category: Category.laravelSecurity,
    question: 'Eloquent يحمي من SQL Injection، فمتى يمكن أن تحدث رغم ذلك؟',
    answer:
        'عند استخدام الدوال الخام بدمج مدخلات المستخدم مباشرة: DB::raw و whereRaw و orderByRaw و selectRaw، أو تمرير اسم عمود من المستخدم إلى orderBy أو where كاسم عمود.',
    explanation:
        '• Eloquent يحمي القيم (bindings) لكن لا يحمي أسماء الأعمدة.\n'
        '• مرر القيم كـ bindings: whereRaw(\'price > ?\', [\$price]).\n'
        '• للترتيب الديناميكي: قائمة بيضاء (whitelist) بأسماء الأعمدة المسموحة.',
    code: r'''// ❌ خطر
User::whereRaw("email = '$email'")->first();
Post::orderBy($request->sort)->get();

// ✔️ آمن
User::whereRaw('email = ?', [$email])->first();
$sort = in_array($request->sort, ['title', 'created_at']) ? $request->sort : 'id';
Post::orderBy($sort)->get();''',
  ),
  Question(
    id: 1043,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'ما هي طرق بناء تطبيق Multi-tenant في Laravel؟',
    answer:
        'ثلاث طرق: قاعدة بيانات واحدة مع عمود tenant_id في كل جدول (Global Scope)، أو قاعدة واحدة مع schema لكل tenant، أو قاعدة بيانات منفصلة لكل tenant.',
    explanation:
        '• عمود tenant_id: الأبسط والأرخص، لكن خطأ واحد قد يسرب بيانات بين العملاء.\n'
        '• قاعدة لكل tenant: عزل قوي ونسخ احتياطي مستقل، لكن migrations وإدارة أصعب.\n'
        '• تحديد الـ tenant عادة من الـ subdomain أو المستخدم المسجل.\n'
        '• مكتبات: stancl/tenancy و spatie/laravel-multitenancy.',
  ),
  Question(
    id: 1044,
    level: Level.hard,
    category: Category.php,
    question: 'ما الفرق بين Interface و Abstract Class و Trait في PHP؟',
    answer:
        'Interface عقد يحدد دوالاً بدون تنفيذ، ويمكن للكلاس تطبيق عدة Interfaces. Abstract Class يمكن أن يحتوي تنفيذاً جزئياً وخصائص، لكن يُورث منه كلاس واحد فقط. Trait لإعادة استخدام كود (نسخه) في عدة كلاسات بدون وراثة.',
    explanation:
        '• Interface ← "ماذا يفعل" (can-do).\n'
        '• Abstract ← "ما هو" مع سلوك مشترك (is-a).\n'
        '• Trait ← حل لغياب الوراثة المتعددة، مثل HasFactory و SoftDeletes في Laravel.\n'
        '• تعارض الأسماء بين Traits يُحل بـ insteadof و as.',
    code: r'''interface Payable { public function pay(int $amount): bool; }

abstract class Gateway implements Payable {
    protected function log(string $m): void { /* ... */ }
}

trait HasUuid {
    protected static function bootHasUuid(): void {
        static::creating(fn ($m) => $m->uuid = (string) Str::uuid());
    }
}''',
  ),
  Question(
    id: 1045,
    level: Level.hard,
    category: Category.laravelAdvanced,
    question: 'كيف تنشر تطبيق Laravel على الإنتاج بدون توقف (Zero-downtime)؟',
    answer:
        'بنشر كل إصدار في مجلد جديد (releases/xxx)، تثبيت الحزم وبناء الكاش هناك، تشغيل migrations متوافقة مع الإصدار السابق، ثم تبديل رابط current (symlink) بشكل ذري، وإعادة تشغيل الـ queue workers و PHP-FPM / Octane.',
    explanation:
        '• ملفات مشتركة بين الإصدارات: .env و storage.\n'
        '• php artisan queue:restart لأن الـ workers تحتفظ بالكود القديم في الذاكرة.\n'
        '• الـ migrations يجب ألا تكسر الكود القديم (مثلاً: لا تحذف عموداً ما زال مستخدماً).\n'
        '• أدوات: Laravel Forge / Envoyer, Deployer, أو CI/CD مع Docker.',
  ),
];
