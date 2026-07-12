import 'package:flutter/material.dart';

/// Data for a single lesson inside a course.
class CourseSection {
  final String id;
  final String title;
  final String body;
  final String? codeSnippet;
  final List<String>? bullets;

  const CourseSection({
    required this.id,
    required this.title,
    required this.body,
    this.codeSnippet,
    this.bullets,
  });
}

/// Data for a full programming course the user can open.
class Course {
  final String id;
  final String title;
  final String iconPath;
  final Color accentColor;
  final String description;
  final List<CourseSection> sections;

  const Course({
    required this.id,
    required this.title,
    required this.iconPath,
    required this.accentColor,
    required this.description,
    required this.sections,
  });
}

/// All 8 hard-coded courses used by the home page grid.
class CourseCatalog {
  static const python = Course(
    id: 'python',
    title: 'Python',
    iconPath: 'assets/icons/pyic.svg',
    accentColor: Color(0xFF10B981),
    description:
        'A beginner-friendly, powerful language used in web, data science, AI and automation. Master the fundamentals and build real-world scripts.',
    sections: [
      CourseSection(
        id: 'py-1',
        title: '1. Introduction to Python',
        body:
            'Python is a high-level, interpreted, general-purpose programming language created by Guido van Rossum in 1991. It emphasises code readability and lets you express ideas in fewer lines than languages like C++ or Java.',
        bullets: [
          'Easy to read, English-like syntax',
          'Dynamically typed and interpreted',
          'Huge standard library and ecosystem',
          'Used at Google, Netflix, Instagram, NASA',
        ],
      ),
      CourseSection(
        id: 'py-2',
        title: '2. Setting up Python',
        body:
            'Install Python from python.org or use Anaconda for data science. Use VS Code, PyCharm, or Jupyter Notebook as your editor. Verify the install on the command line:',
        codeSnippet: 'python --version\npip --version',
      ),
      CourseSection(
        id: 'py-3',
        title: '3. Variables & Data Types',
        body:
            'Python has core data types: int, float, str, bool, list, tuple, dict, set. Variables are created the moment you assign a value.',
        codeSnippet:
            'name = "InoViq"\nage = 21\npi = 3.14\nis_active = True\nskills = ["Flutter", "Django"]',
      ),
      CourseSection(
        id: 'py-4',
        title: '4. Control Flow',
        body:
            'Control flow lets your program make decisions and repeat work. Python uses if / elif / else for branching and for / while for loops.',
        codeSnippet:
            'for i in range(5):\n    print(i)\n\nif age >= 18:\n    print("Adult")\nelse:\n    print("Minor")',
      ),
      CourseSection(
        id: 'py-5',
        title: '5. Functions',
        body:
            'Functions are defined with the def keyword. They can return values, accept default arguments and accept * args / ** kwargs for variable inputs.',
        codeSnippet:
            'def greet(name, msg="Hello"):\n    return f"{msg}, {name}!"\n\nprint(greet("Aswin"))',
      ),
      CourseSection(
        id: 'py-6',
        title: '6. Object-Oriented Programming',
        body:
            'Everything in Python is an object. Define a class with the class keyword; __init__ is the constructor; self refers to the current instance.',
        codeSnippet:
            'class Dog:\n    def __init__(self, name):\n        self.name = name\n    def bark(self):\n        return f"{self.name} says woof!"',
      ),
      CourseSection(
        id: 'py-7',
        title: '7. Modules & Packages',
        body:
            'Group reusable code into modules (.py files) and packages (folders with __init__.py). Import them with the import statement.',
        bullets: [
          'import math  ->  math.sqrt(16)',
          'from datetime import date',
          'pip install requests',
        ],
      ),
      CourseSection(
        id: 'py-8',
        title: '8. File Handling',
        body:
            'Read and write files using the built-in open() function. Always prefer the with-statement so the file is closed even on errors.',
        codeSnippet:
            'with open("notes.txt", "w") as f:\n    f.write("Hello, InoViq!")',
      ),
      CourseSection(
        id: 'py-9',
        title: '9. Popular Libraries',
        body:
            'The Python ecosystem is huge. These libraries power the modern data and AI world:',
        bullets: [
          'NumPy & Pandas — data analysis',
          'Matplotlib & Seaborn — visualisation',
          'Requests — HTTP calls',
          'Django & Flask — web frameworks',
          'TensorFlow & PyTorch — machine learning',
        ],
      ),
      CourseSection(
        id: 'py-10',
        title: '10. Build Your First Project',
        body:
            'A great starter project is a CLI to-do list or a weather checker using the requests library. Break it into functions, write tests with pytest, and push it to GitHub.',
      ),
    ],
  );

  static const django = Course(
    id: 'django',
    title: 'Django',
    iconPath: 'assets/icons/djic.svg',
    accentColor: Color(0xFFFACC15),
    description:
        'A high-level Python web framework that encourages rapid development and clean, pragmatic design. Perfect for building secure, database-driven websites.',
    sections: [
      CourseSection(
        id: 'dj-1',
        title: '1. Introduction to Django',
        body:
            'Django follows the "batteries included" philosophy: ORM, admin, auth, forms and templating ship out of the box so you can ship a real product in days, not months.',
      ),
      CourseSection(
        id: 'dj-2',
        title: '2. Installing Django',
        body:
            'Set up an isolated environment with venv so dependencies don\'t leak between projects.',
        codeSnippet:
            'python -m venv venv\nsource venv/bin/activate    # Windows: venv\\Scripts\\activate\npip install django\ndjango-admin --version',
      ),
      CourseSection(
        id: 'dj-3',
        title: '3. Project & Apps',
        body:
            'A Django project is the whole website. An app is a self-contained module (e.g. blog, accounts) inside it.',
        codeSnippet:
            'django-admin startproject inoviq .\npython manage.py startapp courses',
      ),
      CourseSection(
        id: 'dj-4',
        title: '4. Models & ORM',
        body:
            'Define your schema in Python. Django generates the SQL and gives you a powerful ORM for queries.',
        codeSnippet:
            'class Course(models.Model):\n    title = models.CharField(max_length=200)\n    published = models.DateField()',
      ),
      CourseSection(
        id: 'dj-5',
        title: '5. Views & URLs',
        body:
            'Views receive a request and return a response. URLs map patterns to views via urls.py.',
        bullets: [
          'Function-based views (FBVs)',
          'Class-based views (CBVs)',
          'path() & include()',
        ],
      ),
      CourseSection(
        id: 'dj-6',
        title: '6. Templates',
        body:
            'Django templates let you embed Python-like logic in HTML using {% %} blocks and {{ }} variables while keeping concerns separate.',
      ),
      CourseSection(
        id: 'dj-7',
        title: '7. Forms',
        body:
            'Handle user input safely. Django forms provide CSRF protection, validation and rendering out of the box.',
      ),
      CourseSection(
        id: 'dj-8',
        title: '8. Authentication',
        body:
            'django.contrib.auth ships users, groups, permissions and sessions. The included login / logout views are production-ready.',
      ),
      CourseSection(
        id: 'dj-9',
        title: '9. REST APIs with DRF',
        body:
            'Django REST Framework turns your models into JSON APIs with serializers, viewsets and browsable API out of the box.',
        codeSnippet:
            'pip install djangorestframework\n# serializers, viewsets, urls in 5 lines',
      ),
      CourseSection(
        id: 'dj-10',
        title: '10. Deploying to Production',
        body:
            'Push to Render, Railway, or a VPS. Always set DEBUG=False, configure ALLOWED_HOSTS, run collectstatic, and put gunicorn behind nginx.',
      ),
    ],
  );

  static const cpp = Course(
    id: 'cpp',
    title: 'C++',
    iconPath: 'assets/icons/cppic.svg',
    accentColor: Color(0xFFFB923C),
    description:
        'A powerful, high-performance systems language that powers game engines, browsers, operating systems and embedded devices.',
    sections: [
      CourseSection(
        id: 'cpp-1',
        title: '1. Introduction to C++',
        body:
            'C++ is an extension of C with classes, templates and the Standard Template Library (STL). It offers fine-grained control over memory and CPU.',
      ),
      CourseSection(
        id: 'cpp-2',
        title: '2. Setting up the Compiler',
        body:
            'Install GCC (Linux), MinGW (Windows) or Clang (macOS). Verify on the command line:',
        codeSnippet: 'g++ --version',
      ),
      CourseSection(
        id: 'cpp-3',
        title: '3. Variables & Data Types',
        body:
            'C++ is statically typed. Common types: int, double, char, bool, std::string.',
        codeSnippet:
            'int age = 21;\nstd::string name = "InoViq";\nconst double PI = 3.14159;',
      ),
      CourseSection(
        id: 'cpp-4',
        title: '4. Control Flow',
        body:
            'Same keywords you know from other languages: if / else, switch, while, for, do-while, plus break / continue.',
      ),
      CourseSection(
        id: 'cpp-5',
        title: '5. Functions',
        body:
            'Functions need a return type and parameter types. Pass by value, by reference, or by pointer.',
        codeSnippet:
            'int add(int a, int b) {\n    return a + b;\n}',
      ),
      CourseSection(
        id: 'cpp-6',
        title: '6. Arrays & Strings',
        body:
            'C-style arrays are fixed-size raw memory. Prefer std::vector and std::string for safety and ergonomics.',
        codeSnippet:
            'std::vector<int> nums = {1, 2, 3, 4};\nstd::string greeting = "Hello";',
      ),
      CourseSection(
        id: 'cpp-7',
        title: '7. Pointers & References',
        body:
            'A reference is an alias; a pointer holds a memory address. Modern C++ prefers smart pointers (unique_ptr, shared_ptr) over raw new/delete.',
      ),
      CourseSection(
        id: 'cpp-8',
        title: '8. Object-Oriented Programming',
        body:
            'C++ supports classes, inheritance, polymorphism, abstract classes and multiple inheritance. Use virtual destructors in any polymorphic base class.',
        bullets: [
          'Encapsulation with private / public',
          'Inheritance : public Base',
          'virtual functions & v-table',
        ],
      ),
      CourseSection(
        id: 'cpp-9',
        title: '9. STL (Standard Template Library)',
        body:
            'Reusable, fast generic containers and algorithms:',
        bullets: [
          'std::vector, std::list, std::map, std::set',
          'std::sort, std::find, std::for_each',
          'std::unique_ptr, std::shared_ptr',
        ],
      ),
      CourseSection(
        id: 'cpp-10',
        title: '10. Memory Management',
        body:
            'Allocate with new/free on the heap only when you must. Prefer RAII and smart pointers — they prevent leaks by cleaning up automatically when scope ends.',
      ),
    ],
  );

  static const java = Course(
    id: 'java',
    title: 'Java',
    iconPath: 'assets/icons/javaic.svg',
    accentColor: Color(0xFF1E40AF),
    description:
        'A class-based, object-oriented, general-purpose language with the slogan "write once, run anywhere". Powers Android, Spring and the enterprise.',
    sections: [
      CourseSection(
        id: 'java-1',
        title: '1. Introduction to Java',
        body:
            'Java is compiled to bytecode that runs on the JVM. It is statically typed, strongly typed, and multi-threaded by design.',
      ),
      CourseSection(
        id: 'java-2',
        title: '2. JDK Installation',
        body:
            'Install a recent JDK (17 or 21 LTS). Set JAVA_HOME and verify:',
        codeSnippet: 'java -version\njavac -version',
      ),
      CourseSection(
        id: 'java-3',
        title: '3. Variables & Data Types',
        body:
            'Two categories: primitives (int, long, double, boolean) and objects (String, custom classes).',
        codeSnippet:
            'int age = 21;\nString name = "InoViq";\nboolean active = true;',
      ),
      CourseSection(
        id: 'java-4',
        title: '4. Control Flow',
        body:
            'Same building blocks you already know: if / else, switch, while, for, enhanced for-each, plus break/continue.',
      ),
      CourseSection(
        id: 'java-5',
        title: '5. Classes & Objects',
        body:
            'The entry point is the main method. A class is a blueprint; an object is an instance created with new.',
        codeSnippet:
            'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello");\n    }\n}',
      ),
      CourseSection(
        id: 'java-6',
        title: '6. Inheritance & Polymorphism',
        body:
            'Java supports single class inheritance with extends. Methods can be overridden for polymorphic behaviour. Abstract classes and interfaces enable richer designs.',
      ),
      CourseSection(
        id: 'java-7',
        title: '7. Exception Handling',
        body:
            'Java forces you to handle checked exceptions. Use try / catch / finally, and try-with-resources for autocloseable resources.',
        codeSnippet:
            'try (var br = new BufferedReader(new FileReader("a.txt"))) {\n    System.out.println(br.readLine());\n} catch (IOException e) {\n    e.printStackTrace();\n}',
      ),
      CourseSection(
        id: 'java-8',
        title: '8. Collections Framework',
        body:
            'List, Set, Map, Queue are the core interfaces. Common implementations: ArrayList, HashSet, HashMap, LinkedList.',
      ),
      CourseSection(
        id: 'java-9',
        title: '9. Multithreading',
        body:
            'Java threads can be created by extending Thread, implementing Runnable, or using Executors. Modern code prefers virtual threads and structured concurrency.',
      ),
      CourseSection(
        id: 'java-10',
        title: '10. Java for Android',
        body:
            'Android apps run Java/Kotlin code on the Dalvik/ART VM. Even though Kotlin is now preferred, Java is still the bedrock of millions of production apps.',
      ),
    ],
  );

  static const flutter = Course(
    id: 'flutter',
    title: 'Flutter',
    iconPath: 'assets/icons/flutic.svg',
    accentColor: Color(0xFFA855F7),
    description:
        'Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web and desktop from a single Dart codebase.',
    sections: [
      CourseSection(
        id: 'fl-1',
        title: '1. Introduction to Flutter',
        body:
            'Flutter is a reactive, widget-based framework that draws every pixel itself via Skia, so your app looks identical on every platform.',
      ),
      CourseSection(
        id: 'fl-2',
        title: '2. Dart Basics',
        body:
            'Flutter apps are written in Dart — a sound null-safe, JIT + AOT compiled language with familiar C-style syntax.',
        codeSnippet:
            'var name = "InoViq";\nString greet(String who) => "Hello, \$who!";',
      ),
      CourseSection(
        id: 'fl-3',
        title: '3. Widgets (Stateless & Stateful)',
        body:
            'Everything is a widget. StatelessWidget rebuilds only when its inputs change; StatefulWidget keeps mutable state in a State object.',
      ),
      CourseSection(
        id: 'fl-4',
        title: '4. Layouts & Navigation',
        body:
            'Compose screens from Container, Row, Column, Stack and ListView. Push routes with Navigator.push(MaterialPageRoute(...)).',
      ),
      CourseSection(
        id: 'fl-5',
        title: '5. State Management',
        body:
            'Pick the right tool for the size of your app:',
        bullets: [
          'setState for tiny local state',
          'Provider / Riverpod for medium apps',
          'BLoC / Cubit for large, testable apps',
          'InheritedWidget for low-level needs',
        ],
      ),
      CourseSection(
        id: 'fl-6',
        title: '6. Forms & Validation',
        body:
            'Wrap inputs in a Form with a GlobalKey. Use TextFormField validators to enforce rules and surface friendly errors.',
      ),
      CourseSection(
        id: 'fl-7',
        title: '7. Networking (HTTP & REST)',
        body:
            'Use the http or dio package for REST calls. Wrap calls in async functions with try / catch and handle loading state explicitly.',
        codeSnippet:
            'final res = await http.get(Uri.parse("https://api.example.com/v1/courses"));\nfinal data = jsonDecode(res.body);',
      ),
      CourseSection(
        id: 'fl-8',
        title: '8. Local Storage with SQLite',
        body:
            'For relational data use sqflite. For simple key-value data use shared_preferences. Hive is another popular NoSQL option.',
      ),
      CourseSection(
        id: 'fl-9',
        title: '9. Animations',
        body:
            'Use AnimatedContainer for simple state transitions, Hero for shared element transitions, and AnimationController for choreography.',
      ),
      CourseSection(
        id: 'fl-10',
        title: '10. Publishing to Stores',
        body:
            'Build an App Bundle with flutter build appbundle, sign it with your keystore, then upload via the Google Play Console or App Store Connect.',
      ),
    ],
  );

  static const web = Course(
    id: 'web',
    title: 'Web Dev',
    iconPath: 'assets/icons/csic.svg',
    accentColor: Color(0xFF0D9488),
    description:
        'Master the modern web stack — HTML for structure, CSS for presentation and JavaScript for behaviour. Then layer React and Node.js on top.',
    sections: [
      CourseSection(
        id: 'web-1',
        title: '1. Introduction to Web Development',
        body:
            'Every website is built from three building blocks: HTML (structure), CSS (style) and JavaScript (interactivity). Tooling, frameworks and even AI come and go — these three stay.',
      ),
      CourseSection(
        id: 'web-2',
        title: '2. HTML Basics',
        body:
            'HTML is a tree of elements. Use semantic tags (header, main, section, article, footer) so screen readers and search engines can understand your page.',
        codeSnippet:
            '<header><h1>InoViq</h1></header>\n<main>\n  <section><p>Hello, world!</p></section>\n</main>',
      ),
      CourseSection(
        id: 'web-3',
        title: '3. CSS Styling',
        body:
            'Selectors target elements. The box model (margin / border / padding / content) defines how they take up space. Flexbox and Grid are the modern layout tools.',
      ),
      CourseSection(
        id: 'web-4',
        title: '4. Responsive Design',
        body:
            'Use media queries and a mobile-first mindset. Modern CSS prefers container queries, clamp() for fluid type, and CSS variables for theming.',
      ),
      CourseSection(
        id: 'web-5',
        title: '5. JavaScript Basics',
        body:
            'JS is the language of the browser. Modern JS is async-first, modular (ES modules) and supports classes, arrow functions and destructuring.',
        codeSnippet:
            'const greet = (name) => `Hello, \${name}!`;\nconsole.log(greet("InoViq"));',
      ),
      CourseSection(
        id: 'web-6',
        title: '6. DOM Manipulation',
        body:
            'Use document.querySelector, addEventListener, and classList to read and modify the page. React/Vue/Angular all build on top of this.',
      ),
      CourseSection(
        id: 'web-7',
        title: '7. Front-end Frameworks (Intro to React)',
        body:
            'React lets you describe your UI as a function of state. Components are reusable, declarative and easy to test.',
        codeSnippet:
            'function Hello({ name }) {\n  return <h1>Hello, {name}!</h1>;\n}',
      ),
      CourseSection(
        id: 'web-8',
        title: '8. Backend Basics (Node.js)',
        body:
            'Node runs JS on the server. Express makes routing easy. The npm ecosystem hosts the largest package collection on Earth.',
        codeSnippet:
            'app.get("/api/courses", (req, res) => res.json(courses));',
      ),
      CourseSection(
        id: 'web-9',
        title: '9. Databases for the Web',
        body:
            'Relational (PostgreSQL, MySQL) for structured data. NoSQL (MongoDB) for flexible documents. Choose based on shape, consistency and query patterns.',
      ),
      CourseSection(
        id: 'web-10',
        title: '10. Deploying Your Site',
        body:
            'Static sites → Vercel, Netlify, GitHub Pages. Full-stack apps → Render, Railway or Fly.io. Always set up HTTPS and a custom domain.',
      ),
    ],
  );

  static const gamedev = Course(
    id: 'gamedev',
    title: 'Game Dev',
    iconPath: 'assets/icons/gic.svg',
    accentColor: Color(0xFFEC4899),
    description:
        'Build 2D and 3D games with the Unity engine and C#. Master physics, animations, audio and shipping your first game to the stores.',
    sections: [
      CourseSection(
        id: 'gd-1',
        title: '1. Introduction to Game Development',
        body:
            'A game is a real-time simulation that responds to player input. The job of a developer is to make the loop of input → simulation → feedback feel great.',
      ),
      CourseSection(
        id: 'gd-2',
        title: '2. Unity Basics',
        body:
            'Unity organises everything around GameObjects with attached Components. The Scene view lets you lay them out, the Game view renders what the player will see.',
      ),
      CourseSection(
        id: 'gd-3',
        title: '3. C# for Unity',
        body:
            'All gameplay logic is written in C# and attached as a MonoBehaviour script.',
        codeSnippet:
            'void Update() {\n    if (Input.GetKeyDown(KeyCode.Space))\n        Jump();\n}',
      ),
      CourseSection(
        id: 'gd-4',
        title: '4. Game Objects & Components',
        body:
            'Composition over inheritance: a "Player" object has a Transform, Animator, Collider and a PlayerController script attached.',
      ),
      CourseSection(
        id: 'gd-5',
        title: '5. Physics & Collisions',
        body:
            'Unity uses PhysX for rigid bodies, colliders and triggers. Be careful with FixedUpdate vs Update for physics calculations.',
      ),
      CourseSection(
        id: 'gd-6',
        title: '6. Animations',
        body:
            'The Animator component reads an Animation Controller. Blend trees let you smoothly interpolate between states (idle, walk, run, jump).',
      ),
      CourseSection(
        id: 'gd-7',
        title: '7. UI in Games',
        body:
            'Use UGUI or UI Toolkit for HUDs, menus and dialogs. Anchor UI to screen corners so it scales to any resolution.',
      ),
      CourseSection(
        id: 'gd-8',
        title: '8. Audio',
        body:
            'Add AudioSource components for sound effects and AudioMixers for music. Use 3D spatial audio so the world feels alive.',
      ),
      CourseSection(
        id: 'gd-9',
        title: '9. Building Your First Game',
        body:
            'Start with a tiny scope: one mechanic, one level, one enemy. Ship it. Then iterate. A finished small game beats an unfinished big one every time.',
      ),
      CourseSection(
        id: 'gd-10',
        title: '10. Publishing Games',
        body:
            'Unity builds for PC, Mac, mobile, console, webGL and even VR/XR. Use the Unity Cloud Build pipeline to automate nightly builds on real devices.',
      ),
    ],
  );

  static const devops = Course(
    id: 'devops',
    title: 'DevOps',
    iconPath: 'assets/icons/dvic.svg',
    accentColor: Color(0xFFEF4444),
    description:
        'Bridge the gap between code and production. Master version control, CI/CD, containers, cloud and observability to ship reliable software faster.',
    sections: [
      CourseSection(
        id: 'do-1',
        title: '1. Introduction to DevOps',
        body:
            'DevOps is a culture and a set of practices that automate the path from a developer\'s commit to a running production system.',
      ),
      CourseSection(
        id: 'do-2',
        title: '2. Version Control with Git',
        body:
            'Git tracks every change to your code. Branching, pull requests and code review are the heart of collaborative software.',
        codeSnippet:
            'git init\ngit add .\ngit commit -m "first commit"\ngit push origin main',
      ),
      CourseSection(
        id: 'do-3',
        title: '3. CI/CD Pipelines',
        body:
            'GitHub Actions, GitLab CI or Jenkins run your tests and deploy on every push. A good pipeline gives you fast, trustworthy feedback.',
      ),
      CourseSection(
        id: 'do-4',
        title: '4. Containers with Docker',
        body:
            'A Dockerfile packages an app and its dependencies into a portable image. docker-compose orchestrates multi-service apps locally.',
        codeSnippet:
            'FROM node:20\nWORKDIR /app\nCOPY . .\nRUN npm install\nCMD ["node", "server.js"]',
      ),
      CourseSection(
        id: 'do-5',
        title: '5. Kubernetes',
        body:
            'Kubernetes schedules your containers across a cluster, heals them when they crash, and rolls out new versions with zero downtime.',
      ),
      CourseSection(
        id: 'do-6',
        title: '6. Cloud Providers (AWS / Azure / GCP)',
        body:
            'Each cloud offers 200+ services. Start with the big ones: compute (EC2 / VM / Compute Engine), object storage (S3 / Blob / GCS), and managed databases.',
      ),
      CourseSection(
        id: 'do-7',
        title: '7. Monitoring & Logging',
        body:
            'Three pillars: metrics (Prometheus), logs (Loki / ELK) and traces (OpenTelemetry). Dashboards (Grafana) make the data actionable.',
      ),
      CourseSection(
        id: 'do-8',
        title: '8. Infrastructure as Code (Terraform)',
        body:
            'Terraform lets you describe your infrastructure declaratively. Plan before apply so you can review what will change.',
      ),
      CourseSection(
        id: 'do-9',
        title: '9. Security in DevOps (DevSecOps)',
        body:
            'Shift security left: scan dependencies, container images and IaC in CI. Use OIDC for short-lived cloud credentials, never long-lived keys.',
      ),
      CourseSection(
        id: 'do-10',
        title: '10. Capstone Project',
        body:
            'Build a small app → containerise it → push to GitHub → add a CI pipeline → deploy to a free-tier cluster. You\'ll exercise every concept end-to-end.',
      ),
    ],
  );

  static const List<Course> all = [
    django,
    python,
    cpp,
    java,
    flutter,
    web,
    gamedev,
    devops,
  ];

  static Course byId(String id) =>
      all.firstWhere((c) => c.id == id, orElse: () => python);
}
