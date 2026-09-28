/**
 * INOVIQ Course Catalog Data
 * Extracted directly from lib/course_data.dart
 */
const COURSE_CATALOG = [
  {
    id: 'python',
    title: 'Python',
    tagline: 'Versatile & Beginner Friendly',
    category: 'systems',
    iconPath: 'assets/icons/pyic.svg',
    accentColor: '#10B981',
    accentLight: 'rgba(16, 185, 129, 0.12)',
    description:
      'A beginner-friendly, powerful language used in web, data science, AI and automation. Master the fundamentals and build real-world scripts.',
    sections: [
      {
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
      },
      {
        id: 'py-2',
        title: '2. Setting up Python',
        body:
          'Install Python from python.org or use Anaconda for data science. Use VS Code, PyCharm, or Jupyter Notebook as your editor. Verify the install on the command line:',
        codeSnippet: 'python --version\npip --version',
      },
      {
        id: 'py-3',
        title: '3. Variables & Data Types',
        body:
          'Python has core data types: int, float, str, bool, list, tuple, dict, set. Variables are created the moment you assign a value.',
        codeSnippet:
          'name = "InoViq"\nage = 21\npi = 3.14\nis_active = True\nskills = ["Flutter", "Django"]\nprint(f"{name} is {age} years old")',
      },
      {
        id: 'py-4',
        title: '4. Control Flow',
        body:
          'Control flow lets your program make decisions and repeat work. Python uses if / elif / else for branching and for / while for loops.',
        codeSnippet:
          'for i in range(5):\n    print(f"Iteration {i}")\n\nage = 20\nif age >= 18:\n    print("Eligible for certification")\nelse:\n    print("Minor learner")',
      },
      {
        id: 'py-5',
        title: '5. Functions',
        body:
          'Functions are defined with the def keyword. They can return values, accept default arguments and accept *args / **kwargs for variable inputs.',
        codeSnippet:
          'def greet(name, msg="Welcome to INOVIQ"):\n    return f"{msg}, {name}!"\n\nprint(greet("Aswin"))\nprint(greet("Learner", "Hello"))',
      },
      {
        id: 'py-6',
        title: '6. Object-Oriented Programming',
        body:
          'Everything in Python is an object. Define a class with the class keyword; __init__ is the constructor; self refers to the current instance.',
        codeSnippet:
          'class Course:\n    def __init__(self, title, lessons):\n        self.title = title\n        self.lessons = lessons\n\n    def summary(self):\n        return f"{self.title}: {self.lessons} modules"\n\nc = Course("Python Mastery", 10)\nprint(c.summary())',
      },
      {
        id: 'py-7',
        title: '7. Modules & Packages',
        body:
          'Group reusable code into modules (.py files) and packages (folders with __init__.py). Import them with the import statement.',
        bullets: [
          'import math  ->  math.sqrt(16)',
          'from datetime import date',
          'pip install requests',
        ],
        codeSnippet: 'import math\nfrom datetime import date\n\nprint(f"Square root: {math.sqrt(64)}")\nprint(f"Today is: {date.today()}")',
      },
      {
        id: 'py-8',
        title: '8. File Handling',
        body:
          'Read and write files using the built-in open() function. Always prefer the with-statement so the file is closed even on errors.',
        codeSnippet:
          'with open("inoviq_notes.txt", "w") as f:\n    f.write("Learning Python with InoViq app!\\n100% Offline.")\n\nwith open("inoviq_notes.txt", "r") as f:\n    print(f.read())',
      },
      {
        id: 'py-9',
        title: '9. Popular Libraries',
        body:
          'The Python ecosystem is huge. These libraries power the modern data and AI world:',
        bullets: [
          'NumPy & Pandas — data analysis & manipulation',
          'Matplotlib & Seaborn — rich visualization',
          'Requests — HTTP API calls',
          'Django & Flask — web framework backends',
          'TensorFlow & PyTorch — deep learning & AI',
        ],
      },
      {
        id: 'py-10',
        title: '10. Build Your First Project',
        body:
          'A great starter project is a CLI to-do list or a weather checker using the requests library. Break it into functions, write tests with pytest, and push it to GitHub.',
        codeSnippet:
          'todo_list = ["Setup Flutter", "Install SQLite", "Complete INOVIQ app"]\nfor idx, item in enumerate(todo_list, 1):\n    print(f"{idx}. [x] {item}")',
      },
    ],
  },
  {
    id: 'django',
    title: 'Django',
    tagline: 'Batteries-Included Web Framework',
    category: 'backend',
    iconPath: 'assets/icons/djic.svg',
    accentColor: '#EAB308',
    accentLight: 'rgba(234, 179, 8, 0.12)',
    description:
      'A high-level Python web framework that encourages rapid development and clean, pragmatic design. Perfect for building secure, database-driven websites.',
    sections: [
      {
        id: 'dj-1',
        title: '1. Introduction to Django',
        body:
          'Django follows the "batteries included" philosophy: ORM, admin, auth, forms and templating ship out of the box so you can ship a real product in days, not months.',
        bullets: [
          'Model-View-Template (MVT) architecture',
          'Built-in secure Admin interface',
          'Protects against SQL injection, XSS, CSRF & clickjacking',
        ],
      },
      {
        id: 'dj-2',
        title: '2. Installing Django',
        body:
          'Set up an isolated environment with venv so dependencies don\'t leak between projects.',
        codeSnippet:
          'python -m venv venv\nsource venv/bin/activate    # Windows: venv\\Scripts\\activate\npip install django\ndjango-admin --version',
      },
      {
        id: 'dj-3',
        title: '3. Project & Apps',
        body:
          'A Django project is the whole website. An app is a self-contained module (e.g. blog, accounts, courses) inside it.',
        codeSnippet:
          'django-admin startproject inoviq_web .\npython manage.py startapp courses\npython manage.py runserver',
      },
      {
        id: 'dj-4',
        title: '4. Models & ORM',
        body:
          'Define your schema in Python. Django generates the SQL and gives you a powerful ORM for queries.',
        codeSnippet:
          'from django.db import models\n\nclass Course(models.Model):\n    title = models.CharField(max_length=200)\n    description = models.TextField()\n    published = models.DateField(auto_now_add=True)\n\n    def __str__(self):\n        return self.title',
      },
      {
        id: 'dj-5',
        title: '5. Views & URLs',
        body:
          'Views receive a request and return a response. URLs map patterns to views via urls.py.',
        bullets: [
          'Function-based views (FBVs) for straightforward logic',
          'Class-based views (CBVs) for clean, reusable code',
          'path() & include() for modular routing',
        ],
        codeSnippet:
          'from django.urls import path\nfrom . import views\n\nurlpatterns = [\n    path("", views.course_list, name="course_list"),\n    path("<int:pk>/", views.course_detail, name="course_detail"),\n]',
      },
      {
        id: 'dj-6',
        title: '6. Templates',
        body:
          'Django templates let you embed Python-like logic in HTML using {% %} blocks and {{ }} variables while keeping concerns cleanly separated.',
        codeSnippet:
          '<!-- base.html template snippet -->\n<h1>{{ course.title }}</h1>\n<p>{{ course.description }}</p>\n<ul>\n{% for section in course.sections.all %}\n  <li>{{ section.title }}</li>\n{% endfor %}\n</ul>',
      },
      {
        id: 'dj-7',
        title: '7. Forms & CSRF',
        body:
          'Handle user input safely. Django forms provide CSRF protection, validation and rendering out of the box.',
        codeSnippet:
          'from django import forms\n\nclass FeedbackForm(forms.Form):\n    email = forms.EmailField()\n    message = forms.CharField(widget=forms.Textarea)',
      },
      {
        id: 'dj-8',
        title: '8. Authentication',
        body:
          'django.contrib.auth ships users, groups, permissions and sessions. The included login / logout views are production-ready and battle-tested.',
      },
      {
        id: 'dj-9',
        title: '9. REST APIs with DRF',
        body:
          'Django REST Framework turns your models into JSON APIs with serializers, viewsets and browsable API out of the box.',
        codeSnippet:
          '# serializers.py\nfrom rest_framework import serializers\nfrom .models import Course\n\nclass CourseSerializer(serializers.ModelSerializer):\n    class Meta:\n        model = Course\n        fields = ["id", "title", "published"]',
      },
      {
        id: 'dj-10',
        title: '10. Deploying to Production',
        body:
          'Push to Render, Railway, or a VPS. Always set DEBUG=False, configure ALLOWED_HOSTS, run collectstatic, and put gunicorn behind nginx.',
      },
    ],
  },
  {
    id: 'cpp',
    title: 'C++',
    tagline: 'High-Performance Systems & Engines',
    category: 'systems',
    iconPath: 'assets/icons/cppic.svg',
    accentColor: '#F97316',
    accentLight: 'rgba(249, 115, 22, 0.12)',
    description:
      'A powerful, high-performance systems language that powers game engines, browsers, operating systems and embedded devices.',
    sections: [
      {
        id: 'cpp-1',
        title: '1. Introduction to C++',
        body:
          'C++ is an extension of C with classes, templates and the Standard Template Library (STL). It offers fine-grained control over memory and CPU.',
      },
      {
        id: 'cpp-2',
        title: '2. Setting up the Compiler',
        body:
          'Install GCC (Linux), MinGW (Windows) or Clang (macOS). Verify on the command line:',
        codeSnippet: 'g++ --version\ng++ -O2 main.cpp -o app\n./app',
      },
      {
        id: 'cpp-3',
        title: '3. Variables & Data Types',
        body:
          'C++ is statically typed. Common types: int, double, char, bool, std::string.',
        codeSnippet:
          '#include <iostream>\n#include <string>\n\nint main() {\n    int age = 21;\n    std::string name = "InoViq";\n    const double PI = 3.14159;\n    std::cout << name << " - " << age << std::endl;\n    return 0;\n}',
      },
      {
        id: 'cpp-4',
        title: '4. Control Flow',
        body:
          'Same keywords you know from other languages: if / else, switch, while, for, do-while, plus break / continue.',
      },
      {
        id: 'cpp-5',
        title: '5. Functions',
        body:
          'Functions need a return type and parameter types. Pass by value, by reference, or by pointer.',
        codeSnippet:
          'int add(int a, int b) {\n    return a + b;\n}\n\nvoid increment(int &val) {\n    val++;\n}',
      },
      {
        id: 'cpp-6',
        title: '6. Arrays & Strings',
        body:
          'C-style arrays are fixed-size raw memory. Prefer std::vector and std::string for safety and ergonomics.',
        codeSnippet:
          '#include <vector>\n#include <string>\n\nstd::vector<int> nums = {1, 2, 3, 4};\nnums.push_back(5);\nstd::string greeting = "Hello INOVIQ";',
      },
      {
        id: 'cpp-7',
        title: '7. Pointers & References',
        body:
          'A reference is an alias; a pointer holds a memory address. Modern C++ prefers smart pointers (unique_ptr, shared_ptr) over raw new/delete.',
        codeSnippet:
          'int x = 42;\nint* ptr = &x;     // pointer to address\nint& ref = x;      // reference alias\n*ptr = 100;\nstd::cout << ref;  // prints 100',
      },
      {
        id: 'cpp-8',
        title: '8. Object-Oriented Programming',
        body:
          'C++ supports classes, inheritance, polymorphism, abstract classes and multiple inheritance. Use virtual destructors in any polymorphic base class.',
        bullets: [
          'Encapsulation with private / public access modifiers',
          'Inheritance : public BaseClass',
          'virtual functions & dynamic dispatch via v-table',
        ],
      },
      {
        id: 'cpp-9',
        title: '9. STL (Standard Template Library)',
        body:
          'Reusable, fast generic containers and algorithms:',
        bullets: [
          'std::vector, std::list, std::map, std::unordered_map',
          'std::sort, std::find, std::transform',
          'std::unique_ptr, std::shared_ptr for automatic memory cleanup',
        ],
      },
      {
        id: 'cpp-10',
        title: '10. Memory Management & RAII',
        body:
          'Allocate with new/free on the heap only when you must. Prefer RAII (Resource Acquisition Is Initialization) and smart pointers — they prevent leaks by cleaning up automatically when scope ends.',
      },
    ],
  },
  {
    id: 'java',
    title: 'Java',
    tagline: 'Enterprise, Spring & Android',
    category: 'backend',
    iconPath: 'assets/icons/javaic.svg',
    accentColor: '#2563EB',
    accentLight: 'rgba(37, 99, 235, 0.12)',
    description:
      'A class-based, object-oriented, general-purpose language with the slogan "write once, run anywhere". Powers Android, Spring and enterprise systems worldwide.',
    sections: [
      {
        id: 'java-1',
        title: '1. Introduction to Java',
        body:
          'Java is compiled to bytecode that runs on the JVM. It is statically typed, strongly typed, and multi-threaded by design.',
      },
      {
        id: 'java-2',
        title: '2. JDK Installation',
        body:
          'Install a recent JDK (17 or 21 LTS). Set JAVA_HOME and verify on terminal:',
        codeSnippet: 'java -version\njavac -version',
      },
      {
        id: 'java-3',
        title: '3. Variables & Data Types',
        body:
          'Two categories: primitives (int, long, double, boolean) and objects (String, custom classes).',
        codeSnippet:
          'int age = 21;\nString name = "InoViq";\nboolean active = true;\nSystem.out.println("Student: " + name);',
      },
      {
        id: 'java-4',
        title: '4. Control Flow',
        body:
          'Same building blocks: if / else, switch (including pattern matching in modern Java), while, for, enhanced for-each loop.',
      },
      {
        id: 'java-5',
        title: '5. Classes & Objects',
        body:
          'The entry point is the main method. A class is a blueprint; an object is an instance created with new.',
        codeSnippet:
          'public class Main {\n    public static void main(String[] args) {\n        System.out.println("Hello from INOVIQ!");\n    }\n}',
      },
      {
        id: 'java-6',
        title: '6. Inheritance & Polymorphism',
        body:
          'Java supports single class inheritance with extends. Methods can be overridden for polymorphic behaviour. Abstract classes and interfaces enable richer modular designs.',
      },
      {
        id: 'java-7',
        title: '7. Exception Handling',
        body:
          'Java forces you to handle checked exceptions. Use try / catch / finally, and try-with-resources for autocloseable resources.',
        codeSnippet:
          'try (var br = new BufferedReader(new FileReader("data.txt"))) {\n    System.out.println(br.readLine());\n} catch (IOException e) {\n    e.printStackTrace();\n}',
      },
      {
        id: 'java-8',
        title: '8. Collections Framework',
        body:
          'List, Set, Map, Queue are the core interfaces. Common implementations: ArrayList, HashSet, HashMap, LinkedList.',
        codeSnippet:
          'List<String> courses = new ArrayList<>();\ncourses.add("Java");\ncourses.add("Flutter");\ncourses.forEach(System.out::println);',
      },
      {
        id: 'java-9',
        title: '9. Multithreading',
        body:
          'Java threads can be created by extending Thread, implementing Runnable, or using Executors. Modern code prefers virtual threads (Project Loom) and structured concurrency.',
      },
      {
        id: 'java-10',
        title: '10. Java for Android',
        body:
          'Android apps run Java/Kotlin code on the Dalvik/ART VM. Even though Kotlin is now preferred, Java is still the bedrock of millions of production apps.',
      },
    ],
  },
  {
    id: 'flutter',
    title: 'Flutter',
    tagline: 'Multiplatform Native UI with Dart',
    category: 'mobile',
    iconPath: 'assets/icons/flutic.svg',
    accentColor: '#A855F7',
    accentLight: 'rgba(168, 85, 247, 0.12)',
    description:
      'Google\'s UI toolkit for building beautiful, natively compiled applications for mobile, web and desktop from a single Dart codebase.',
    sections: [
      {
        id: 'fl-1',
        title: '1. Introduction to Flutter',
        body:
          'Flutter is a reactive, widget-based framework that draws every pixel itself via Impeller/Skia, so your app looks identical and runs at 60/120fps on every platform.',
      },
      {
        id: 'fl-2',
        title: '2. Dart Basics',
        body:
          'Flutter apps are written in Dart — a sound null-safe, JIT + AOT compiled language with familiar C-style syntax.',
        codeSnippet:
          'var name = "InoViq";\nString greet(String who) => "Hello, $who!";\n\nvoid main() {\n  print(greet(name));\n}',
      },
      {
        id: 'fl-3',
        title: '3. Widgets (Stateless & Stateful)',
        body:
          'Everything is a widget. StatelessWidget rebuilds only when its inputs change; StatefulWidget keeps mutable state in a State object.',
        codeSnippet:
          'class CourseCard extends StatelessWidget {\n  final String title;\n  const CourseCard({super.key, required this.title});\n\n  @override\n  Widget build(BuildContext context) {\n    return Card(child: Text(title));\n  }\n}',
      },
      {
        id: 'fl-4',
        title: '4. Layouts & Navigation',
        body:
          'Compose screens from Container, Row, Column, Stack and ListView. Push routes with Navigator.push(MaterialPageRoute(...)).',
      },
      {
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
      },
      {
        id: 'fl-6',
        title: '6. Forms & Validation',
        body:
          'Wrap inputs in a Form with a GlobalKey. Use TextFormField validators to enforce rules and surface friendly errors.',
        codeSnippet:
          'TextFormField(\n  validator: (val) {\n    if (val == null || !val.contains("@")) return "Enter valid email";\n    return null;\n  },\n)',
      },
      {
        id: 'fl-7',
        title: '7. Networking (HTTP & REST)',
        body:
          'Use the http or dio package for REST calls. Wrap calls in async functions with try / catch and handle loading state explicitly.',
        codeSnippet:
          'final res = await http.get(Uri.parse("https://api.example.com/v1/courses"));\nfinal data = jsonDecode(res.body);',
      },
      {
        id: 'fl-8',
        title: '8. Local Storage with SQLite',
        body:
          'For relational data use sqflite. For simple key-value data use shared_preferences. INOVIQ uses sqflite to run 100% offline on Android devices.',
        codeSnippet:
          '// INOVIQ DatabaseHelper snippet\nFuture<Database> initDB() async {\n  String path = join(await getDatabasesPath(), "backend.db");\n  return await openDatabase(path, version: 1, onCreate: _onCreate);\n}',
      },
      {
        id: 'fl-9',
        title: '9. Animations & Material 3',
        body:
          'Use AnimatedContainer for simple state transitions, Hero for shared element transitions, and AnimationController for choreography.',
      },
      {
        id: 'fl-10',
        title: '10. Publishing to Stores',
        body:
          'Build an App Bundle with flutter build appbundle, sign it with your keystore, then upload via Google Play Console or App Store Connect.',
      },
    ],
  },
  {
    id: 'web',
    title: 'Web Dev',
    tagline: 'HTML5, Modern CSS & JavaScript',
    category: 'web',
    iconPath: 'assets/icons/csic.svg',
    accentColor: '#0D9488',
    accentLight: 'rgba(13, 148, 136, 0.12)',
    description:
      'Master the modern web stack — HTML for structure, CSS for presentation and JavaScript for behaviour. Then layer React and Node.js on top.',
    sections: [
      {
        id: 'web-1',
        title: '1. Introduction to Web Development',
        body:
          'Every website is built from three building blocks: HTML (structure), CSS (style) and JavaScript (interactivity). Tooling, frameworks and even AI come and go — these three stay.',
      },
      {
        id: 'web-2',
        title: '2. HTML Basics',
        body:
          'HTML is a tree of elements. Use semantic tags (header, main, section, article, footer) so screen readers and search engines can understand your page.',
        codeSnippet:
          '<header>\n  <h1>InoViq Learning Platform</h1>\n</header>\n<main>\n  <section><p>Master modern web development.</p></section>\n</main>',
      },
      {
        id: 'web-3',
        title: '3. CSS Styling & Layout',
        body:
          'Selectors target elements. The box model (margin / border / padding / content) defines how they take up space. Flexbox and Grid are the modern layout tools.',
        codeSnippet:
          '.card-grid {\n  display: grid;\n  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));\n  gap: 1.5rem;\n}',
      },
      {
        id: 'web-4',
        title: '4. Responsive Design',
        body:
          'Use media queries and a mobile-first mindset. Modern CSS prefers container queries, clamp() for fluid type, and CSS variables for theming.',
      },
      {
        id: 'web-5',
        title: '5. JavaScript Basics (ES6+)',
        body:
          'JS is the language of the browser. Modern JS is async-first, modular (ES modules) and supports classes, arrow functions and destructuring.',
        codeSnippet:
          'const greet = (name) => `Hello, ${name}! Welcome to INOVIQ.`;\nconsole.log(greet("Web Developer"));',
      },
      {
        id: 'web-6',
        title: '6. DOM Manipulation',
        body:
          'Use document.querySelector, addEventListener, and classList to read and modify the page. React/Vue/Angular all build on top of this.',
        codeSnippet:
          'const btn = document.querySelector("#complete-btn");\nbtn.addEventListener("click", () => {\n  btn.classList.toggle("completed");\n});',
      },
      {
        id: 'web-7',
        title: '7. Front-end Frameworks (Intro to React)',
        body:
          'React lets you describe your UI as a function of state. Components are reusable, declarative and easy to test.',
        codeSnippet:
          'function Hello({ name }) {\n  return <h1>Hello, {name}!</h1>;\n}',
      },
      {
        id: 'web-8',
        title: '8. Backend Basics (Node.js)',
        body:
          'Node runs JS on the server. Express makes routing easy. The npm ecosystem hosts the largest package collection on Earth.',
        codeSnippet:
          'const express = require("express");\nconst app = express();\n\napp.get("/api/courses", (req, res) => res.json(courses));\napp.listen(3000);',
      },
      {
        id: 'web-9',
        title: '9. Databases for the Web',
        body:
          'Relational (PostgreSQL, MySQL) for structured data. NoSQL (MongoDB) for flexible documents. Choose based on shape, consistency and query patterns.',
      },
      {
        id: 'web-10',
        title: '10. Deploying Your Site',
        body:
          'Static sites → Vercel, Netlify, GitHub Pages. Full-stack apps → Render, Railway or Fly.io. Always set up HTTPS and a custom domain.',
      },
    ],
  },
  {
    id: 'gamedev',
    title: 'Game Dev',
    tagline: 'Unity Engine & C# Gameplay',
    category: 'game',
    iconPath: 'assets/icons/gic.svg',
    accentColor: '#EC4899',
    accentLight: 'rgba(236, 72, 153, 0.12)',
    description:
      'Build 2D and 3D games with the Unity engine and C#. Master physics, animations, audio and shipping your first game to the stores.',
    sections: [
      {
        id: 'gd-1',
        title: '1. Introduction to Game Development',
        body:
          'A game is a real-time simulation that responds to player input. The job of a developer is to make the loop of input → simulation → feedback feel great.',
      },
      {
        id: 'gd-2',
        title: '2. Unity Basics',
        body:
          'Unity organises everything around GameObjects with attached Components. The Scene view lets you lay them out, the Game view renders what the player will see.',
      },
      {
        id: 'gd-3',
        title: '3. C# for Unity',
        body:
          'All gameplay logic is written in C# and attached as a MonoBehaviour script.',
        codeSnippet:
          'using UnityEngine;\n\npublic class PlayerController : MonoBehaviour {\n    public float speed = 5.0f;\n\n    void Update() {\n        if (Input.GetKeyDown(KeyCode.Space)) {\n            Jump();\n        }\n    }\n}',
      },
      {
        id: 'gd-4',
        title: '4. Game Objects & Components',
        body:
          'Composition over inheritance: a "Player" object has a Transform, Animator, Collider and a PlayerController script attached.',
      },
      {
        id: 'gd-5',
        title: '5. Physics & Collisions',
        body:
          'Unity uses PhysX for rigid bodies, colliders and triggers. Be careful with FixedUpdate vs Update for physics calculations.',
        codeSnippet:
          'void FixedUpdate() {\n    rb.MovePosition(rb.position + movement * speed * Time.fixedDeltaTime);\n}',
      },
      {
        id: 'gd-6',
        title: '6. Animations',
        body:
          'The Animator component reads an Animation Controller. Blend trees let you smoothly interpolate between states (idle, walk, run, jump).',
      },
      {
        id: 'gd-7',
        title: '7. UI in Games',
        body:
          'Use UGUI or UI Toolkit for HUDs, menus and dialogs. Anchor UI to screen corners so it scales to any resolution.',
      },
      {
        id: 'gd-8',
        title: '8. Audio',
        body:
          'Add AudioSource components for sound effects and AudioMixers for music. Use 3D spatial audio so the world feels alive.',
      },
      {
        id: 'gd-9',
        title: '9. Building Your First Game',
        body:
          'Start with a tiny scope: one mechanic, one level, one enemy. Ship it. Then iterate. A finished small game beats an unfinished big one every time.',
      },
      {
        id: 'gd-10',
        title: '10. Publishing Games',
        body:
          'Unity builds for PC, Mac, mobile, console, webGL and even VR/XR. Use Unity Cloud Build pipeline to automate nightly builds on real devices.',
      },
    ],
  },
  {
    id: 'devops',
    title: 'DevOps',
    tagline: 'Git, CI/CD, Docker & Cloud',
    category: 'cloud',
    iconPath: 'assets/icons/dvic.svg',
    accentColor: '#EF4444',
    accentLight: 'rgba(239, 68, 68, 0.12)',
    description:
      'Bridge the gap between code and production. Master version control, CI/CD, containers, cloud and observability to ship reliable software faster.',
    sections: [
      {
        id: 'do-1',
        title: '1. Introduction to DevOps',
        body:
          'DevOps is a culture and a set of practices that automate the path from a developer\'s commit to a running production system.',
      },
      {
        id: 'do-2',
        title: '2. Version Control with Git',
        body:
          'Git tracks every change to your code. Branching, pull requests and code review are the heart of collaborative software.',
        codeSnippet:
          'git init\ngit add .\ngit commit -m "feat: complete inoviq learning app"\ngit push origin main',
      },
      {
        id: 'do-3',
        title: '3. CI/CD Pipelines',
        body:
          'GitHub Actions, GitLab CI or Jenkins run your tests and deploy on every push. A good pipeline gives you fast, trustworthy feedback.',
        codeSnippet:
          '# .github/workflows/deploy.yml\nname: Deploy INOVIQ Website\non: [push]\njobs:\n  build-and-deploy:\n    runs-on: ubuntu-latest\n    steps:\n      - uses: actions/checkout@v4\n      - run: echo "Deployment successful"',
      },
      {
        id: 'do-4',
        title: '4. Containers with Docker',
        body:
          'A Dockerfile packages an app and its dependencies into a portable image. docker-compose orchestrates multi-service apps locally.',
        codeSnippet:
          'FROM nginx:alpine\nCOPY ./website /usr/share/nginx/html\nEXPOSE 80\nCMD ["nginx", "-g", "daemon off;"]',
      },
      {
        id: 'do-5',
        title: '5. Kubernetes',
        body:
          'Kubernetes schedules your containers across a cluster, heals them when they crash, and rolls out new versions with zero downtime.',
      },
      {
        id: 'do-6',
        title: '6. Cloud Providers (AWS / Azure / GCP)',
        body:
          'Each cloud offers 200+ services. Start with the big ones: compute (EC2 / VM / Compute Engine), object storage (S3 / Blob / GCS), and managed databases.',
      },
      {
        id: 'do-7',
        title: '7. Monitoring & Logging',
        body:
          'Three pillars: metrics (Prometheus), logs (Loki / ELK) and traces (OpenTelemetry). Dashboards (Grafana) make the data actionable.',
      },
      {
        id: 'do-8',
        title: '8. Infrastructure as Code (Terraform)',
        body:
          'Terraform lets you describe your infrastructure declaratively. Plan before apply so you can review what will change.',
        codeSnippet:
          'resource "aws_s3_bucket" "inoviq_assets" {\n  bucket = "inoviq-learning-assets"\n  tags = {\n    Environment = "Production"\n  }\n}',
      },
      {
        id: 'do-9',
        title: '9. Security in DevOps (DevSecOps)',
        body:
          'Shift security left: scan dependencies, container images and IaC in CI. Use OIDC for short-lived cloud credentials, never long-lived keys.',
      },
      {
        id: 'do-10',
        title: '10. Capstone Project',
        body:
          'Build a small app → containerise it → push to GitHub → add a CI pipeline → deploy to a free-tier cluster. You\'ll exercise every concept end-to-end.',
      },
    ],
  },
];

const TEAM_MEMBERS = [
  { name: 'Ashwin T S', role: 'Team Member', avatar: 'AT', highlight: 'Frontend UI & Architecture' },
  { name: 'Jessa Jaison', role: 'Team Member', avatar: 'JJ', highlight: 'Course Content & Logic' },
  { name: 'Anzil T Z', role: 'Team Member', avatar: 'AZ', highlight: 'SQLite Database & Storage' },
  { name: 'Abishek P Prasad', role: 'Team Member', avatar: 'AP', highlight: 'Auth & Validation Flows' },
  { name: 'Ahnas Mohammed P.M', role: 'Project Manager', avatar: 'AM', isManager: true, highlight: 'Project Planning & Coordination' },
  { name: 'Fathahiya Shirin P.M', role: 'Project Manager', avatar: 'FS', isManager: true, highlight: 'Quality Assurance & Delivery' },
  { name: 'Mohammed Sharafas P.M', role: 'Project Manager', avatar: 'MS', isManager: true, highlight: 'Mentorship & Architecture' },
];

const QUIZ_QUESTIONS = [
  {
    course: 'Flutter',
    question: 'In Flutter, what kind of widget should you use when its UI depends on mutable internal state?',
    options: ['StatelessWidget', 'StatefulWidget', 'InheritedModel', 'ProxyWidget'],
    correct: 1,
    explanation: 'StatefulWidget maintains a mutable State object that can call setState() to trigger rebuilds.',
  },
  {
    course: 'Python',
    question: 'Which built-in Python block ensures that open files or resources are automatically closed even if errors occur?',
    options: ['try / catch', 'with statement (context manager)', 'open.lock()', 'defer'],
    correct: 1,
    explanation: 'The `with` statement utilizes Python context managers (__enter__ and __exit__) to guarantee cleanup.',
  },
  {
    course: 'Django',
    question: 'Which architectural design pattern does Django primarily follow out of the box?',
    options: ['Model-View-Controller (MVC)', 'Model-View-Template (MVT)', 'Component-Entity-System (CES)', 'MVVM'],
    correct: 1,
    explanation: 'Django follows MVT: Models describe data, Views handle logic/dispatch, and Templates render the presentation.',
  },
  {
    course: 'SQLite',
    question: 'How does INOVIQ store user profile and authentication records without requiring any remote cloud server?',
    options: ['Firebase Cloud Firestore', 'Local SQLite database (backend.db via sqflite)', 'MongoDB Atlas', 'Cookies'],
    correct: 1,
    explanation: 'INOVIQ operates 100% offline on-device using SQLite with `users` and `login` tables via the sqflite package.',
  },
  {
    course: 'C++',
    question: 'What modern C++ concept guarantees automatic destruction and memory cleanup when an object goes out of scope?',
    options: ['Manual malloc / free', 'RAII (Resource Acquisition Is Initialization)', 'Garbage Collector thread', 'Virtual pointers'],
    correct: 1,
    explanation: 'RAII binds resource lifecycle to object lifetime, ensuring automatic destruction without memory leaks.',
  },
];
