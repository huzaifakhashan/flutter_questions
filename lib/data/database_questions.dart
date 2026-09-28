import '../models/question.dart';

const List<Question> databaseQuestions = [
  // ─────────────────────────── سهل ───────────────────────────
  Question(
    id: 2001,
    level: Level.easy,
    category: Category.sql,
    question: 'ما هي قاعدة البيانات العلائقية (RDBMS)؟',
    answer:
        'قاعدة بيانات تخزن البيانات في جداول (صفوف وأعمدة) وترتبط الجداول ببعضها عبر المفاتيح، ونتعامل معها بلغة SQL. أمثلة: MySQL, PostgreSQL, SQL Server, SQLite.',
    explanation:
        '• كل جدول يمثل كياناً (مستخدمين، طلبات...).\n'
        '• الهيكل (schema) محدد مسبقاً.\n'
        '• تدعم المعاملات (Transactions) وخصائص ACID والقيود (constraints).',
  ),
  Question(
    id: 2002,
    level: Level.easy,
    category: Category.dbDesign,
    question: 'ما الفرق بين Primary Key و Foreign Key؟',
    answer:
        'Primary Key يعرّف كل صف في الجدول بشكل فريد ولا يقبل NULL. Foreign Key عمود في جدول يشير إلى Primary Key في جدول آخر لربطهما وضمان سلامة البيانات (Referential Integrity).',
    explanation:
        '• جدول واحد له Primary Key واحد (قد يكون مركباً من عدة أعمدة).\n'
        '• Foreign Key يمنع إدخال قيمة غير موجودة في الجدول الأب.\n'
        '• ON DELETE CASCADE / SET NULL / RESTRICT تحدد ماذا يحدث عند حذف الأب.',
    code: r'''CREATE TABLE orders (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  user_id BIGINT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);''',
  ),
  Question(
    id: 2003,
    level: Level.easy,
    category: Category.sql,
    question: 'ما هي أنواع أوامر SQL (DDL, DML, DCL, TCL)؟',
    answer:
        'DDL لتعريف الهيكل (CREATE, ALTER, DROP). DML للتعامل مع البيانات (SELECT, INSERT, UPDATE, DELETE). DCL للصلاحيات (GRANT, REVOKE). TCL للمعاملات (COMMIT, ROLLBACK).',
    explanation:
        '• بعضهم يفصل SELECT في مجموعة DQL.\n'
        '• أوامر DDL في MySQL تنفذ COMMIT ضمني ولا يمكن التراجع عنها داخل transaction.',
    code: r'''SELECT name, email FROM users WHERE active = 1;
INSERT INTO users (name, email) VALUES ('Ali', 'ali@mail.com');
UPDATE users SET active = 0 WHERE id = 5;
DELETE FROM users WHERE id = 5;''',
  ),
  Question(
    id: 2004,
    level: Level.easy,
    category: Category.sql,
    question: 'ما الفرق بين WHERE و HAVING؟',
    answer:
        'WHERE يفلتر الصفوف قبل التجميع (GROUP BY)، و HAVING يفلتر المجموعات بعد التجميع ويمكنه استخدام دوال التجميع مثل COUNT و SUM.',
    explanation:
        '• ترتيب التنفيذ المنطقي: FROM ← WHERE ← GROUP BY ← HAVING ← SELECT ← ORDER BY ← LIMIT.\n'
        '• لذلك لا يمكن استخدام COUNT() داخل WHERE.',
    code: r'''SELECT user_id, COUNT(*) AS orders_count
FROM orders
WHERE status = 'paid'
GROUP BY user_id
HAVING COUNT(*) > 5;''',
  ),
  Question(
    id: 2005,
    level: Level.easy,
    category: Category.sql,
    question: 'ما الفرق بين DELETE و TRUNCATE و DROP؟',
    answer:
        'DELETE يحذف صفوفاً (مع WHERE اختياري) ويمكن التراجع عنه. TRUNCATE يفرغ الجدول كاملاً بسرعة ويعيد العداد (auto increment). DROP يحذف الجدول نفسه بهيكله.',
    explanation:
        '• DELETE يُنفذ صفاً صفاً ويُطلق الـ triggers، لذلك أبطأ.\n'
        '• TRUNCATE عملية DDL ولا تطلق triggers.\n'
        '• نصيحة: اكتب WHERE قبل تنفيذ DELETE أو UPDATE دائماً!',
  ),
  Question(
    id: 2006,
    level: Level.easy,
    category: Category.joins,
    question: 'اشرح أنواع الـ JOIN.',
    answer:
        'INNER JOIN يرجع الصفوف المتطابقة في الجدولين فقط. LEFT JOIN يرجع كل صفوف الجدول الأيسر مع المتطابق من الأيمن (أو NULL). RIGHT JOIN العكس. FULL OUTER JOIN كل الصفوف من الجدولين. CROSS JOIN كل التركيبات الممكنة.',
    explanation:
        '• LEFT JOIN مع WHERE right.id IS NULL لإيجاد صفوف بدون مقابل (مثلاً مستخدمون بلا طلبات).\n'
        '• MySQL لا يدعم FULL OUTER JOIN مباشرة، ويُحاكى بـ UNION.',
    code: r'''-- المستخدمون الذين لم يطلبوا أبداً
SELECT u.id, u.name
FROM users u
LEFT JOIN orders o ON o.user_id = u.id
WHERE o.id IS NULL;''',
  ),
  Question(
    id: 2007,
    level: Level.easy,
    category: Category.sql,
    question: 'ما هو GROUP BY ودوال التجميع (Aggregate Functions)؟',
    answer:
        'GROUP BY يجمع الصفوف ذات القيم المتشابهة في مجموعات، ودوال التجميع تحسب قيمة واحدة لكل مجموعة: COUNT, SUM, AVG, MIN, MAX.',
    explanation:
        '• كل عمود في SELECT يجب أن يكون في GROUP BY أو داخل دالة تجميع.\n'
        '• COUNT(*) يعد كل الصفوف، و COUNT(column) يتجاهل NULL.',
    code: r'''SELECT category_id, COUNT(*) AS total, AVG(price) AS avg_price
FROM products
GROUP BY category_id;''',
  ),
  Question(
    id: 2008,
    level: Level.easy,
    category: Category.sql,
    question: 'كيف تتعامل مع NULL في SQL؟',
    answer:
        'NULL يعني "قيمة غير معروفة" وليس صفراً أو نصاً فارغاً. لا يمكن مقارنته بـ =، بل نستخدم IS NULL و IS NOT NULL، و COALESCE لإعطاء قيمة بديلة.',
    explanation:
        '• NULL = NULL نتيجتها NULL وليست true.\n'
        '• أي عملية حسابية مع NULL نتيجتها NULL.\n'
        '• NOT IN مع قائمة فيها NULL قد ترجع نتيجة فارغة بشكل مفاجئ.',
    code: r'''SELECT name, COALESCE(phone, 'لا يوجد') AS phone
FROM users
WHERE deleted_at IS NULL;''',
  ),
  Question(
    id: 2009,
    level: Level.easy,
    category: Category.dbDesign,
    question: 'ما الفرق بين UNIQUE و PRIMARY KEY؟',
    answer:
        'كلاهما يمنع التكرار. لكن الجدول له Primary Key واحد فقط ولا يقبل NULL، بينما يمكن أن يكون هناك عدة قيود UNIQUE وتقبل NULL (عادة أكثر من NULL واحدة).',
    explanation:
        '• مثال UNIQUE: email أو username.\n'
        '• كلاهما يُنشئ فهرساً تلقائياً.',
  ),
  Question(
    id: 2010,
    level: Level.easy,
    category: Category.indexes,
    question: 'ما هو الـ Index ولماذا نستخدمه؟',
    answer:
        'هيكل بيانات إضافي (غالباً B-Tree) يسرّع البحث في عمود معين، مثل فهرس الكتاب، بدلاً من مسح الجدول كاملاً (Full Table Scan).',
    explanation:
        '• يسرّع SELECT و WHERE و JOIN و ORDER BY.\n'
        '• لكنه يبطئ INSERT و UPDATE و DELETE ويستهلك مساحة.\n'
        '• نضعه على الأعمدة المستخدمة كثيراً في البحث والربط، وليس على كل الأعمدة.',
    code: r'''CREATE INDEX idx_users_email ON users(email);''',
  ),
  Question(
    id: 2011,
    level: Level.easy,
    category: Category.dbDesign,
    question: 'ما الفرق بين CHAR و VARCHAR و TEXT؟',
    answer:
        'CHAR طول ثابت (يُكمل بمسافات)، مناسب لقيم بطول ثابت مثل رموز الدول. VARCHAR طول متغير حتى حد معين. TEXT لنصوص طويلة جداً ولها قيود في الفهرسة والقيم الافتراضية.',
    explanation:
        '• اختيار النوع المناسب يوفر مساحة ويحسن الأداء.\n'
        '• للمال استخدم DECIMAL وليس FLOAT لتجنب أخطاء التقريب.\n'
        '• للنصوص العربية والإيموجي في MySQL استخدم utf8mb4.',
  ),
  Question(
    id: 2012,
    level: Level.easy,
    category: Category.nosql,
    question: 'ما الفرق بين SQL و NoSQL؟',
    answer:
        'SQL: جداول بهيكل ثابت وعلاقات و ACID قوية، مناسبة للبيانات المترابطة (مالية، طلبات). NoSQL: هيكل مرن (مستندات، key-value، أعمدة، رسوم بيانية) ويتوسع أفقياً بسهولة، مناسب للبيانات الضخمة أو المتغيرة.',
    explanation:
        '• أنواع NoSQL: Document (MongoDB, Firestore)، Key-Value (Redis)، Wide-column (Cassandra)، Graph (Neo4j).\n'
        '• كثير من الأنظمة تستخدم الاثنين معاً.\n'
        '• الاختيار حسب طبيعة البيانات وأنماط الاستعلام.',
  ),
  Question(
    id: 2013,
    level: Level.easy,
    category: Category.sql,
    question: 'كيف تعمل Pagination باستخدام LIMIT و OFFSET؟',
    answer:
        'LIMIT يحدد عدد الصفوف المرجعة، و OFFSET عدد الصفوف التي نتخطاها. للصفحة رقم p بحجم n: LIMIT n OFFSET (p - 1) * n، مع ORDER BY لضمان ترتيب ثابت.',
    explanation:
        '• بدون ORDER BY الترتيب غير مضمون.\n'
        '• OFFSET الكبير بطيء لأن القاعدة تقرأ الصفوف المتخطاة ثم ترميها (انظر Keyset Pagination).',
    code: r'''SELECT * FROM posts
ORDER BY created_at DESC
LIMIT 20 OFFSET 40; -- الصفحة الثالثة''',
  ),
  Question(
    id: 2014,
    level: Level.easy,
    category: Category.joins,
    question: 'ما الفرق بين UNION و UNION ALL؟',
    answer:
        'كلاهما يدمج نتائج استعلامين. UNION يحذف الصفوف المكررة (أبطأ لأنه يحتاج فرزاً أو مقارنة)، و UNION ALL يبقي كل الصفوف (أسرع).',
    explanation:
        '• يجب أن يكون عدد الأعمدة وأنواعها متوافقة.\n'
        '• استخدم UNION ALL إن كنت متأكداً من عدم وجود تكرار.',
  ),
  Question(
    id: 2015,
    level: Level.easy,
    category: Category.transactions,
    question: 'ما هي الـ Transaction؟',
    answer:
        'مجموعة عمليات تُنفذ كوحدة واحدة: إما تنجح كلها (COMMIT) أو تُلغى كلها (ROLLBACK). مثال: تحويل مبلغ يخصم من حساب ويضيف لآخر.',
    explanation:
        '• تمنع ترك البيانات في حالة نصف مكتملة عند حدوث خطأ.\n'
        '• في Laravel: DB::transaction(fn () => ...).',
    code: r'''START TRANSACTION;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
UPDATE accounts SET balance = balance + 100 WHERE id = 2;
COMMIT;''',
  ),

  // ─────────────────────────── متوسط ───────────────────────────
  Question(
    id: 2016,
    level: Level.medium,
    category: Category.transactions,
    question: 'اشرح خصائص ACID.',
    answer:
        'Atomicity: كل شيء أو لا شيء. Consistency: البيانات تنتقل من حالة صحيحة لأخرى صحيحة وتحترم القيود. Isolation: المعاملات المتزامنة لا تتداخل بشكل خاطئ. Durability: بعد COMMIT تبقى البيانات حتى لو انقطعت الكهرباء.',
    explanation:
        '• Durability تتحقق عبر سجل الكتابة المسبقة (WAL / redo log).\n'
        '• Isolation لها مستويات تحدد مقدار التداخل المسموح.',
  ),
  Question(
    id: 2017,
    level: Level.medium,
    category: Category.dbDesign,
    question: 'ما هو التطبيع (Normalization)؟ اشرح 1NF و 2NF و 3NF.',
    answer:
        'تنظيم الجداول لتقليل التكرار ومنع شذوذ التحديث. 1NF: كل خلية قيمة واحدة ذرية ولا مجموعات مكررة. 2NF: 1NF وكل عمود يعتمد على كامل المفتاح وليس جزءاً منه. 3NF: 2NF ولا يعتمد عمود غير مفتاحي على عمود غير مفتاحي آخر.',
    explanation:
        '• مثال مخالف لـ 1NF: عمود phones = "0911, 0933".\n'
        '• مثال مخالف لـ 3NF: جدول orders فيه customer_city تعتمد على customer_id وليس على order id.\n'
        '• الهدف: كل معلومة تُخزن في مكان واحد.',
  ),
  Question(
    id: 2018,
    level: Level.medium,
    category: Category.dbDesign,
    question: 'كيف تمثل علاقة Many-to-Many؟',
    answer:
        'بجدول وسيط (Pivot / Junction table) يحتوي Foreign Key لكل من الجدولين، مع Primary Key مركب أو قيد UNIQUE على الزوج لمنع التكرار.',
    explanation:
        '• مثال: طلاب ومواد ← جدول enrollments (student_id, course_id).\n'
        '• يمكن أن يحتوي الجدول الوسيط بيانات إضافية (مثل الدرجة وتاريخ التسجيل).',
    code: r'''CREATE TABLE course_student (
  student_id BIGINT REFERENCES students(id),
  course_id  BIGINT REFERENCES courses(id),
  grade      DECIMAL(5,2),
  PRIMARY KEY (student_id, course_id)
);''',
  ),
  Question(
    id: 2019,
    level: Level.medium,
    category: Category.joins,
    question: 'ما الفرق بين Subquery و JOIN؟ وما هو Correlated Subquery؟',
    answer:
        'Subquery استعلام داخل استعلام، و JOIN يدمج الجداول مباشرة. غالباً يمكن كتابة الاثنين لنفس النتيجة. Correlated Subquery يعتمد على قيمة من الاستعلام الخارجي فيُنفذ (منطقياً) لكل صف، وقد يكون بطيئاً.',
    explanation:
        '• EXISTS غالباً أفضل من IN مع الجداول الكبيرة.\n'
        '• المحرّكات الحديثة تحوّل كثيراً من الـ subqueries إلى joins تلقائياً.\n'
        '• CTE (WITH) يجعل الاستعلامات المعقدة أوضح.',
    code: r'''-- موظفون راتبهم أعلى من متوسط قسمهم (correlated)
SELECT e.name, e.salary
FROM employees e
WHERE e.salary > (
  SELECT AVG(salary) FROM employees WHERE department_id = e.department_id
);''',
  ),
  Question(
    id: 2020,
    level: Level.medium,
    category: Category.indexes,
    question: 'ما الفرق بين Clustered و Non-clustered Index؟',
    answer:
        'Clustered Index يحدد الترتيب الفعلي لتخزين الصفوف على القرص، لذلك يوجد واحد فقط لكل جدول (في InnoDB هو الـ Primary Key). Non-clustered (Secondary) Index هيكل منفصل يشير إلى الصفوف، ويمكن إنشاء عدة منها.',
    explanation:
        '• في InnoDB الفهرس الثانوي يخزن قيمة الـ Primary Key، فيحتاج بحثاً ثانياً للوصول للصف.\n'
        '• لذلك Primary Key قصير (مثل BIGINT) أفضل من UUID نصي طويل.\n'
        '• UUID عشوائي كمفتاح يسبب تجزئة (fragmentation)؛ استخدم UUID v7 أو ULID المرتبة زمنياً.',
  ),
  Question(
    id: 2021,
    level: Level.medium,
    category: Category.indexes,
    question: 'ما هو Composite Index وما قاعدة Leftmost Prefix؟',
    answer:
        'فهرس على عدة أعمدة معاً. يُستفاد منه فقط إذا بدأ الاستعلام بأول عمود فيه (من اليسار). فهرس (a, b, c) يخدم: a، و a+b، و a+b+c، لكن لا يخدم b وحده أو c وحده.',
    explanation:
        '• ضع الأعمدة المستخدمة بالمساواة (=) أولاً، ثم أعمدة النطاق (> <).\n'
        '• بعد أول شرط نطاق لا تُستخدم الأعمدة التالية للبحث.',
    code: r'''CREATE INDEX idx_orders ON orders(user_id, status, created_at);

-- ✔️ يستخدم الفهرس
SELECT * FROM orders WHERE user_id = 7 AND status = 'paid';
-- ❌ لا يستخدمه (لا يبدأ بـ user_id)
SELECT * FROM orders WHERE status = 'paid';''',
  ),
  Question(
    id: 2022,
    level: Level.medium,
    category: Category.sql,
    question: 'ما هو الـ View؟ وما هو Materialized View؟',
    answer:
        'View استعلام محفوظ يظهر كجدول افتراضي، يبسط الاستعلامات المعقدة ويخفي أعمدة حساسة، لكنه يُنفذ عند كل استخدام. Materialized View يخزن النتيجة فعلياً ويحتاج تحديثاً دورياً، لكنه أسرع في القراءة.',
    explanation:
        '• Materialized Views مدعومة في PostgreSQL وليست في MySQL.\n'
        '• مفيدة للتقارير والإحصائيات الثقيلة.',
  ),
  Question(
    id: 2023,
    level: Level.medium,
    category: Category.sql,
    question: 'ما الفرق بين Stored Procedure و Function و Trigger؟',
    answer:
        'Stored Procedure مجموعة أوامر SQL محفوظة تُستدعى بـ CALL وقد تعدل البيانات. Function ترجع قيمة ويمكن استخدامها داخل SELECT. Trigger كود يُنفذ تلقائياً عند INSERT أو UPDATE أو DELETE على جدول.',
    explanation:
        '• الإيجابيات: أداء (قريب من البيانات)، إعادة استخدام.\n'
        '• السلبيات: منطق مخفي داخل قاعدة البيانات، صعوبة الاختبار والتتبع في Git.\n'
        '• معظم التطبيقات الحديثة تضع منطق الأعمال في الكود.',
  ),
  Question(
    id: 2024,
    level: Level.medium,
    category: Category.indexes,
    question: 'ما هو EXPLAIN وكيف تستخدمه؟',
    answer:
        'أمر يعرض خطة التنفيذ (Execution Plan) للاستعلام: أي فهارس ستُستخدم، نوع الوصول، وعدد الصفوف المتوقع فحصها. نستخدمه لفهم سبب بطء الاستعلام.',
    explanation:
        '• في MySQL انتبه للعمود type: ALL يعني Full Table Scan (سيئ غالباً)، و ref / eq_ref / const جيدة.\n'
        '• Using filesort و Using temporary إشارات لعمل إضافي.\n'
        '• EXPLAIN ANALYZE ينفذ الاستعلام فعلاً ويعطي الأوقات الحقيقية.',
    code: r'''EXPLAIN SELECT * FROM orders WHERE user_id = 7 ORDER BY created_at DESC;''',
  ),
  Question(
    id: 2025,
    level: Level.medium,
    category: Category.sql,
    question: 'ما هو SQL Injection وكيف تمنعه؟',
    answer:
        'هجوم يحقن فيه المهاجم كود SQL داخل مدخلات المستخدم ليغير معنى الاستعلام (قراءة كل البيانات، حذف جداول). الحل الأساسي: Prepared Statements (Parameterized Queries) وعدم دمج المدخلات في نص الاستعلام أبداً.',
    explanation:
        '• مثال: إدخال \' OR 1=1 -- في حقل تسجيل الدخول.\n'
        '• الـ ORMs تستخدم parameters تلقائياً.\n'
        '• حماية إضافية: أقل الصلاحيات لمستخدم قاعدة البيانات، والتحقق من المدخلات.',
    code: r'''-- ❌
"SELECT * FROM users WHERE email = '" + email + "'"

-- ✔️ Prepared statement
SELECT * FROM users WHERE email = ?''',
  ),
  Question(
    id: 2026,
    level: Level.medium,
    category: Category.joins,
    question: 'كيف تجد ثاني أعلى راتب؟ وما هي Window Functions؟',
    answer:
        'Window Functions تحسب قيمة لكل صف بناءً على مجموعة صفوف مرتبطة دون دمجها كـ GROUP BY، مثل ROW_NUMBER و RANK و DENSE_RANK و LAG و SUM() OVER. ثاني أعلى راتب: DENSE_RANK() = 2.',
    explanation:
        '• ROW_NUMBER: ترقيم فريد 1,2,3.\n'
        '• RANK: يترك فجوات عند التعادل 1,1,3.\n'
        '• DENSE_RANK: بدون فجوات 1,1,2.\n'
        '• PARTITION BY لتطبيقها داخل كل مجموعة (مثلاً لكل قسم).',
    code: r'''SELECT name, salary
FROM (
  SELECT name, salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
  FROM employees
) t
WHERE rnk = 2;

-- حل تقليدي
SELECT MAX(salary) FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);''',
  ),
  Question(
    id: 2027,
    level: Level.medium,
    category: Category.dbDesign,
    question: 'ما هو Denormalization ومتى نستخدمه؟',
    answer:
        'إضافة تكرار مقصود للبيانات (مثل تخزين comments_count في جدول posts) لتسريع القراءة وتجنب JOINs ثقيلة، على حساب تعقيد الكتابة والحفاظ على التزامن.',
    explanation:
        '• مناسب لأنظمة القراءة الكثيفة والتقارير.\n'
        '• يجب تحديث النسخ المكررة بشكل موثوق (transaction، triggers، events).\n'
        '• القاعدة: ابدأ مُطبّعاً، ولا تكسر التطبيع إلا عند وجود مشكلة أداء مقاسة.',
  ),
  Question(
    id: 2028,
    level: Level.medium,
    category: Category.indexes,
    question: 'لماذا OFFSET بطيء في الصفحات البعيدة؟ وما هو Keyset (Cursor) Pagination؟',
    answer:
        'مع OFFSET 100000 تقرأ قاعدة البيانات 100000 صف ثم ترميها. Keyset Pagination يستخدم آخر قيمة من الصفحة السابقة (مثل آخر id) في شرط WHERE، فيقفز مباشرة عبر الفهرس، وسرعته ثابتة.',
    explanation:
        '• العيب: لا يمكن القفز لصفحة رقم 50 مباشرة، فقط التالي/السابق.\n'
        '• مثالي للـ infinite scroll في تطبيقات الموبايل.\n'
        '• مع أعمدة غير فريدة استخدم (created_at, id) معاً.\n'
        '• في Laravel: cursorPaginate().',
    code: r'''-- بدلاً من OFFSET
SELECT * FROM posts
WHERE id < :last_seen_id
ORDER BY id DESC
LIMIT 20;''',
  ),
  Question(
    id: 2029,
    level: Level.medium,
    category: Category.joins,
    question: 'ما هو Self Join؟ أعط مثالاً.',
    answer:
        'ربط جدول بنفسه باستخدام أسماء مستعارة (aliases). مثال شائع: جدول موظفين فيه عمود manager_id يشير لموظف آخر في نفس الجدول.',
    explanation:
        '• نستخدم LEFT JOIN حتى يظهر المدير العام الذي ليس له مدير.\n'
        '• للهياكل الهرمية العميقة نستخدم Recursive CTE.',
    code: r'''SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id;''',
  ),
  Question(
    id: 2030,
    level: Level.medium,
    category: Category.nosql,
    question: 'ما هو Redis ومتى نستخدمه؟',
    answer:
        'قاعدة بيانات Key-Value تعمل في الذاكرة (in-memory) وسريعة جداً. تُستخدم للـ Cache، الجلسات (Sessions)، الطوابير (Queues)، Rate limiting، العدادات، لوحات الترتيب (Sorted Sets)، و Pub/Sub.',
    explanation:
        '• أنواع بيانات: String, Hash, List, Set, Sorted Set, Stream.\n'
        '• يدعم TTL لانتهاء المفاتيح تلقائياً.\n'
        '• يمكن حفظ البيانات على القرص (RDB / AOF)، لكن لا يُعامل غالباً كمصدر الحقيقة الأساسي.',
  ),

  // ─────────────────────────── صعب ───────────────────────────
  Question(
    id: 2031,
    level: Level.hard,
    category: Category.transactions,
    question: 'اشرح مستويات العزل (Isolation Levels) والمشاكل التي تمنعها.',
    answer:
        'Read Uncommitted: يسمح بـ Dirty Read. Read Committed: يمنع Dirty Read ويسمح بـ Non-repeatable Read. Repeatable Read: يمنعهما ويسمح نظرياً بـ Phantom Read. Serializable: يمنع الكل لكنه الأبطأ.',
    explanation:
        '• Dirty Read: قراءة تعديل لم يُعمل له COMMIT بعد.\n'
        '• Non-repeatable Read: قراءة نفس الصف مرتين بنتيجتين مختلفتين.\n'
        '• Phantom Read: ظهور صفوف جديدة عند تكرار نفس الاستعلام.\n'
        '• الافتراضي: MySQL InnoDB ← Repeatable Read، و PostgreSQL ← Read Committed.',
  ),
  Question(
    id: 2032,
    level: Level.hard,
    category: Category.transactions,
    question: 'ما هو الـ Deadlock وكيف تتجنبه؟',
    answer:
        'حالة تنتظر فيها معاملتان بعضهما: الأولى تقفل صف A وتنتظر B، والثانية تقفل B وتنتظر A. قاعدة البيانات تكتشفه وتلغي إحداهما. التجنب: القفل دائماً بنفس الترتيب، معاملات قصيرة، فهارس مناسبة لتقليل الصفوف المقفلة، وإعادة المحاولة عند الفشل.',
    explanation:
        '• مثال: تحويلان متعاكسان بين حسابين في نفس اللحظة.\n'
        '• الحل: قفل الحسابين بترتيب id تصاعدي دائماً.\n'
        '• SHOW ENGINE INNODB STATUS لعرض آخر deadlock في MySQL.',
  ),
  Question(
    id: 2033,
    level: Level.hard,
    category: Category.transactions,
    question: 'ما الفرق بين Optimistic و Pessimistic Locking؟',
    answer:
        'Pessimistic: نقفل الصف عند القراءة (SELECT ... FOR UPDATE) فينتظر الآخرون، مناسب عند كثرة التعارض. Optimistic: لا نقفل، بل نضيف عمود version ونتحقق عند التحديث أنه لم يتغير، وإلا نعيد المحاولة؛ مناسب عندما يكون التعارض نادراً.',
    explanation:
        '• Optimistic أفضل للأداء وقابلية التوسع.\n'
        '• Pessimistic يضمن النجاح لكن قد يسبب انتظاراً و deadlocks.',
    code: r'''-- Optimistic
UPDATE products
SET stock = stock - 1, version = version + 1
WHERE id = 10 AND version = 3;
-- إذا تأثر 0 صف ← شخص آخر عدّله، أعد المحاولة

-- Pessimistic
SELECT * FROM products WHERE id = 10 FOR UPDATE;''',
  ),
  Question(
    id: 2034,
    level: Level.hard,
    category: Category.nosql,
    question: 'اشرح نظرية CAP.',
    answer:
        'في نظام موزّع لا يمكن ضمان الثلاثة معاً: Consistency (كل القراءات ترى آخر كتابة)، Availability (كل طلب يحصل على رد)، Partition tolerance (العمل رغم انقطاع الشبكة بين العقد). وبما أن انقطاع الشبكة حتمي، فالاختيار الحقيقي عند حدوثه بين C و A.',
    explanation:
        '• CP: يرفض الطلبات بدل إرجاع بيانات قديمة (مثل أنظمة البنوك، HBase، etcd).\n'
        '• AP: يرد دائماً وقد تكون البيانات قديمة مؤقتاً (Cassandra, DynamoDB) ← Eventual Consistency.\n'
        '• PACELC يكمل الصورة: حتى بدون انقطاع هناك مفاضلة بين Latency و Consistency.',
  ),
  Question(
    id: 2035,
    level: Level.hard,
    category: Category.nosql,
    question: 'ما هو الـ Replication وما مشكلة Replication Lag؟',
    answer:
        'نسخ البيانات من خادم رئيسي (Primary) إلى خوادم تابعة (Replicas) للتوفر العالي وتوزيع القراءات. Replication Lag هو تأخر وصول التحديثات للنسخ، فقد يكتب المستخدم شيئاً ثم لا يراه فوراً إذا قُرئ من replica.',
    explanation:
        '• الحل: Read-your-writes، أي قراءة بيانات المستخدم من الـ primary مباشرة بعد الكتابة.\n'
        '• Laravel يدعم ذلك بخيار sticky في إعداد read/write connections.\n'
        '• Synchronous replication يمنع الفقدان لكنه أبطأ، و Asynchronous أسرع مع خطر فقدان آخر الكتابات.',
  ),
  Question(
    id: 2036,
    level: Level.hard,
    category: Category.nosql,
    question: 'ما الفرق بين Partitioning و Sharding؟',
    answer:
        'Partitioning تقسيم جدول كبير إلى أجزاء داخل نفس الخادم (مثلاً حسب السنة). Sharding توزيع البيانات على عدة خوادم مستقلة حسب مفتاح (shard key)، لتوسيع الكتابة والتخزين أفقياً.',
    explanation:
        '• اختيار shard key سيئ يسبب hot spots (خادم واحد يتحمل معظم الحمل).\n'
        '• Sharding يعقد JOINs والمعاملات بين الخوادم وإعادة التوزيع.\n'
        '• الترتيب المنطقي قبل الـ sharding: تحسين الاستعلامات ← الفهارس ← Cache ← Read replicas ← Partitioning ← Sharding.',
  ),
  Question(
    id: 2037,
    level: Level.hard,
    category: Category.indexes,
    question: 'متى لا تستخدم قاعدة البيانات الفهرس رغم وجوده؟',
    answer:
        'عند تطبيق دالة أو عملية على العمود، LIKE يبدأ بـ %، اختلاف نوع البيانات أو الـ collation، عدم البدء بأول عمود في الفهرس المركب، OR بين أعمدة مختلفة، أو عندما يكون الفهرس غير انتقائي فيقدّر المحسّن أن المسح الكامل أسرع.',
    explanation:
        '• WHERE YEAR(created_at) = 2024 ❌ ← WHERE created_at >= \'2024-01-01\' AND created_at < \'2025-01-01\' ✔️\n'
        '• WHERE phone = 123 وعمود phone نصي ← تحويل ضمني يلغي الفهرس.\n'
        '• فهرس على عمود gender (قيمتان) قليل الفائدة.\n'
        '• البديل: Functional / Generated column indexes، أو Full-text index للبحث النصي.',
  ),
  Question(
    id: 2038,
    level: Level.hard,
    category: Category.indexes,
    question: 'ما الفرق بين B-Tree Index و Hash Index؟',
    answer:
        'B-Tree شجرة متوازنة مرتبة تدعم المساواة والنطاقات (> < BETWEEN) والترتيب و LIKE \'abc%\'، وتعقيد البحث O(log n). Hash Index يدعم المساواة فقط بسرعة O(1) تقريباً، ولا يدعم النطاقات أو الترتيب.',
    explanation:
        '• B-Tree (فعلياً B+Tree) هو الافتراضي في MySQL و PostgreSQL.\n'
        '• أنواع أخرى في PostgreSQL: GIN (للـ JSONB والمصفوفات والبحث النصي)، GiST (للبيانات الجغرافية)، BRIN (للجداول الضخمة المرتبة زمنياً).',
  ),
  Question(
    id: 2039,
    level: Level.hard,
    category: Category.transactions,
    question: 'ما هو MVCC؟',
    answer:
        'Multi-Version Concurrency Control: بدلاً من قفل الصفوف عند القراءة، تحتفظ قاعدة البيانات بعدة نسخ من الصف، وكل معاملة ترى لقطة (snapshot) متسقة من البيانات. لذلك القراءة لا تحجب الكتابة، والكتابة لا تحجب القراءة.',
    explanation:
        '• تستخدمه PostgreSQL و InnoDB و Oracle.\n'
        '• في PostgreSQL النسخ القديمة تحتاج تنظيفاً بـ VACUUM.\n'
        '• في InnoDB النسخ القديمة في undo log؛ المعاملات الطويلة جداً تضخمه.',
  ),
  Question(
    id: 2040,
    level: Level.hard,
    category: Category.indexes,
    question: 'لديك استعلام بطيء على الإنتاج. ما خطواتك لحله؟',
    answer:
        'أحدده عبر slow query log أو أدوات المراقبة، أنفذ EXPLAIN / EXPLAIN ANALYZE، أتحقق من الفهارس والـ Full scans، أقلل الأعمدة (لا SELECT *) والصفوف، أعيد كتابة الاستعلام، أتحقق من N+1 في الكود، ثم أفكر في Cache أو Denormalization، وأقيس قبل وبعد.',
    explanation:
        '• لا تضف فهارس عشوائياً؛ كل فهرس يبطئ الكتابة.\n'
        '• أنشئ الفهارس على الجداول الكبيرة بطريقة لا تقفل الجدول (online DDL).\n'
        '• راجع الإحصائيات (ANALYZE TABLE) إن كانت خطة التنفيذ غريبة.\n'
        '• أحياناً المشكلة في الـ locks وليس في الاستعلام نفسه.',
  ),
  Question(
    id: 2041,
    level: Level.hard,
    category: Category.indexes,
    question: 'ما هو Covering Index؟',
    answer:
        'فهرس يحتوي كل الأعمدة التي يحتاجها الاستعلام (في WHERE و SELECT و ORDER BY)، فتُجلب النتيجة من الفهرس مباشرة دون الرجوع للجدول، وهذا أسرع بكثير.',
    explanation:
        '• في EXPLAIN في MySQL يظهر: Using index.\n'
        '• في PostgreSQL: Index Only Scan، ويمكن إضافة أعمدة بـ INCLUDE.\n'
        '• سبب إضافي لتجنب SELECT *.',
    code: r'''CREATE INDEX idx_orders_cover ON orders(user_id, status, total);

-- يُخدم بالكامل من الفهرس
SELECT status, total FROM orders WHERE user_id = 7;''',
  ),
  Question(
    id: 2042,
    level: Level.hard,
    category: Category.dbDesign,
    question: 'كيف تعدّل هيكل جدول ضخم على الإنتاج بدون توقف؟',
    answer:
        'بنمط Expand / Contract: أضف العمود الجديد (nullable) ← انشر كوداً يكتب في القديم والجديد ← انقل البيانات القديمة على دفعات (backfill) ← انشر كوداً يقرأ من الجديد ← أوقف الكتابة في القديم ← احذف العمود القديم لاحقاً.',
    explanation:
        '• تجنب العمليات التي تقفل الجدول لفترة طويلة.\n'
        '• أدوات: gh-ost و pt-online-schema-change لـ MySQL.\n'
        '• إعادة تسمية عمود مباشرة تكسر الكود القديم أثناء النشر.',
  ),
  Question(
    id: 2043,
    level: Level.hard,
    category: Category.dbDesign,
    question: 'كيف تمنع تكرار عملية (مثل دفع مرتين) على مستوى قاعدة البيانات؟',
    answer:
        'بقيد UNIQUE على مفتاح منطقي أو Idempotency Key يرسله العميل مع الطلب. عند إعادة إرسال نفس الطلب يفشل الإدخال الثاني فنرجع نتيجة العملية الأولى بدل تنفيذها مجدداً.',
    explanation:
        '• التحقق في الكود فقط (SELECT ثم INSERT) لا يكفي بسبب Race conditions.\n'
        '• القيد في قاعدة البيانات هو الضمان الأخير.\n'
        '• INSERT ... ON DUPLICATE KEY UPDATE أو ON CONFLICT DO NOTHING (PostgreSQL).',
    code: r'''ALTER TABLE payments ADD CONSTRAINT uq_idempotency UNIQUE (idempotency_key);

INSERT INTO payments (idempotency_key, order_id, amount)
VALUES ('a1b2c3', 55, 100)
ON CONFLICT (idempotency_key) DO NOTHING;''',
  ),
  Question(
    id: 2044,
    level: Level.hard,
    category: Category.dbDesign,
    question: 'صمم قاعدة بيانات لمتجر إلكتروني بسيط.',
    answer:
        'الجداول الأساسية: users، products، categories، orders (user_id, status, total)، order_items (order_id, product_id, quantity, unit_price)، addresses، payments. نخزن سعر المنتج في order_items وقت الشراء لأن سعر المنتج قد يتغير لاحقاً.',
    explanation:
        '• order_items هو جدول وسيط بين الطلبات والمنتجات مع بيانات إضافية.\n'
        '• المال بـ DECIMAL(10,2) أو كعدد صحيح بأصغر وحدة (cents).\n'
        '• فهارس على orders(user_id, created_at) و order_items(order_id).\n'
        '• تحدث بصوت عالٍ عن قراراتك: المخزون، الخصومات، المتغيرات (مقاسات/ألوان)، soft delete للمنتجات.',
    code: r'''users(id, name, email UNIQUE)
products(id, category_id FK, name, price, stock)
orders(id, user_id FK, status, total, created_at)
order_items(id, order_id FK, product_id FK, quantity, unit_price)
payments(id, order_id FK, provider, amount, status, idempotency_key UNIQUE)''',
  ),
  Question(
    id: 2045,
    level: Level.hard,
    category: Category.nosql,
    question: 'ما هو Connection Pooling ولماذا هو مهم؟',
    answer:
        'فتح اتصال جديد بقاعدة البيانات مكلف (TCP + مصادقة). الـ Pool يحتفظ بمجموعة اتصالات مفتوحة يعيد استخدامها. بدونه، مع ضغط عالٍ، قد تتجاوز حد max_connections وتنهار القاعدة.',
    explanation:
        '• PostgreSQL ينشئ process لكل اتصال، لذلك PgBouncer شائع جداً معه.\n'
        '• في البيئات serverless كل نسخة تفتح اتصالات، فالـ pooler ضروري.\n'
        '• حجم الـ pool الأكبر ليس دائماً أفضل؛ القاعدة محدودة بعدد الأنوية والقرص.',
  ),
];
