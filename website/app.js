/**
 * INOVIQ Website Interactive Application Engine
 * Handles Phone Simulator, Course Catalog, Modal Reader, Code Playground,
 * SQLite Inspector, Auth Simulation, and Interactive Quiz.
 */

document.addEventListener('DOMContentLoaded', () => {
  initTheme();
  initPhoneSimulator();
  initCourseCatalog();
  initCourseReader();
  initPlayground();
  initDatabaseInspector();
  initAuthSimulator();
  initQuiz();
  initMobileMenu();
});

/* ==========================================================================
   1. Theme Management (Obsidian Dark / Crisp Teal Light)
   ========================================================================== */
function initTheme() {
  const themeToggle = document.getElementById('theme-toggle-btn');
  const storedTheme = localStorage.getItem('inoviq_theme') || 'dark';
  document.documentElement.setAttribute('data-theme', storedTheme);
  updateThemeIcon(storedTheme);

  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const current = document.documentElement.getAttribute('data-theme') || 'dark';
      const nextTheme = current === 'dark' ? 'light' : 'dark';
      document.documentElement.setAttribute('data-theme', nextTheme);
      localStorage.setItem('inoviq_theme', nextTheme);
      updateThemeIcon(nextTheme);
      showToast(`Switched to ${nextTheme === 'dark' ? 'Dark Obsidian' : 'Teal Light'} mode`);
    });
  }
}

function updateThemeIcon(theme) {
  const icon = document.getElementById('theme-icon');
  if (icon) {
    icon.textContent = theme === 'dark' ? '☀️' : '🌙';
  }
}

/* ==========================================================================
   2. Interactive Smartphone Simulator
   ========================================================================== */
let activeCourseInPhone = COURSE_CATALOG[0]; // Python default
let phoneCompletedLessons = new Set(['py-1']);

function initPhoneSimulator() {
  const clockElem = document.getElementById('phone-clock');
  if (clockElem) {
    const updateClock = () => {
      const d = new Date();
      const h = String(d.getHours()).padStart(2, '0');
      const m = String(d.getMinutes()).padStart(2, '0');
      clockElem.textContent = `${h}:${m}`;
    };
    updateClock();
    setInterval(updateClock, 30000);
  }

  // Setup pill buttons below phone
  const screenPills = document.querySelectorAll('.screen-pill-btn');
  screenPills.forEach(pill => {
    pill.addEventListener('click', () => {
      const screenId = pill.getAttribute('data-screen');
      switchPhoneScreen(screenId);
    });
  });

  // Setup bottom nav inside phone
  const phoneNavTabs = document.querySelectorAll('.phone-nav-tab');
  phoneNavTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      const screenId = tab.getAttribute('data-screen');
      switchPhoneScreen(screenId);
    });
  });

  // Setup Welcome Screen Buttons inside phone
  const btnStart = document.getElementById('phone-btn-get-started');
  if (btnStart) {
    btnStart.addEventListener('click', () => {
      switchPhoneScreen('home');
      showToast('Navigated to Home Course Grid in Simulator');
    });
  }

  const btnHaveAccount = document.getElementById('phone-btn-have-account');
  if (btnHaveAccount) {
    btnHaveAccount.addEventListener('click', () => {
      switchPhoneScreen('profile');
      showToast('Navigated to Profile Screen in Simulator');
    });
  }

  // Setup Home Screen Course Cards inside phone
  renderPhoneCourseGrid();

  // Setup Back Button on Course Detail screen inside phone
  const btnBack = document.getElementById('phone-detail-back');
  if (btnBack) {
    btnBack.addEventListener('click', () => {
      switchPhoneScreen('home');
    });
  }
}

function switchPhoneScreen(screenId) {
  const screens = document.querySelectorAll('.virtual-screen');
  screens.forEach(s => s.classList.remove('active'));

  const target = document.getElementById(`vscreen-${screenId}`);
  if (target) {
    target.classList.add('active');
  }

  // Update pills
  document.querySelectorAll('.screen-pill-btn').forEach(pill => {
    pill.classList.toggle('active', pill.getAttribute('data-screen') === screenId);
  });

  // Update phone bottom nav
  document.querySelectorAll('.phone-nav-tab').forEach(tab => {
    tab.classList.toggle('active', tab.getAttribute('data-screen') === screenId);
  });
}

function renderPhoneCourseGrid() {
  const container = document.getElementById('phone-courses-container');
  if (!container) return;

  container.innerHTML = COURSE_CATALOG.slice(0, 6).map(c => `
    <div class="v-course-card" onclick="openPhoneCourseDetail('${c.id}')">
      <div class="v-course-icon-wrap" style="background: ${c.accentLight || 'rgba(0,137,123,0.1)'}">
        <img src="${c.iconPath}" alt="${c.title} icon" />
      </div>
      <div class="v-course-name">${c.title}</div>
      <div class="v-course-badge">${c.sections.length} Lessons</div>
    </div>
  `).join('');
}

window.openPhoneCourseDetail = function(courseId) {
  const course = COURSE_CATALOG.find(c => c.id === courseId) || COURSE_CATALOG[0];
  activeCourseInPhone = course;

  const heroElem = document.getElementById('phone-detail-hero');
  const titleElem = document.getElementById('phone-detail-title');
  const progressElem = document.getElementById('phone-detail-progress-val');
  const contentElem = document.getElementById('phone-detail-content');

  if (heroElem) heroElem.style.background = course.accentColor;
  if (titleElem) titleElem.textContent = course.title;

  updatePhoneProgress();

  if (contentElem) {
    contentElem.innerHTML = course.sections.slice(0, 3).map((sec, idx) => {
      const isDone = phoneCompletedLessons.has(sec.id);
      return `
        <div class="v-lesson-chip">
          <strong>${sec.title}</strong>
          <p style="margin-top:4px; font-size:0.68rem; color:#475569;">${sec.body.slice(0, 80)}...</p>
          ${sec.codeSnippet ? `<div class="v-lesson-code-box">${escapeHtml(sec.codeSnippet.split('\n')[0])}</div>` : ''}
          <div class="v-lesson-check-btn" onclick="togglePhoneLessonComplete('${sec.id}')">
            ${isDone ? '✓ Completed' : 'Mark Complete'}
          </div>
        </div>
      `;
    }).join('');
  }

  switchPhoneScreen('detail');
};

window.togglePhoneLessonComplete = function(secId) {
  if (phoneCompletedLessons.has(secId)) {
    phoneCompletedLessons.remove(secId);
    showToast('Lesson marked uncompleted in phone simulator');
  } else {
    phoneCompletedLessons.add(secId);
    showToast('✓ Lesson marked complete in phone simulator!');
  }
  updatePhoneProgress();
  window.openPhoneCourseDetail(activeCourseInPhone.id);
};

function updatePhoneProgress() {
  const progressElem = document.getElementById('phone-detail-progress-val');
  const progressBar = document.getElementById('phone-detail-progress-fill');
  if (progressElem && activeCourseInPhone) {
    const total = activeCourseInPhone.sections.length;
    const completedCount = activeCourseInPhone.sections.filter(s => phoneCompletedLessons.has(s.id)).length;
    const pct = Math.round((completedCount / total) * 100);
    progressElem.textContent = `${pct}% Complete`;
    if (progressBar) progressBar.style.width = `${pct}%`;
  }
}

/* ==========================================================================
   3. Course Catalog Grid & Filtering
   ========================================================================== */
let activeCategory = 'all';
let searchQuery = '';

function initCourseCatalog() {
  renderCourseGrid();

  // Category filter chips
  const chips = document.querySelectorAll('.filter-chip');
  chips.forEach(chip => {
    chip.addEventListener('click', () => {
      chips.forEach(c => c.classList.remove('active'));
      chip.classList.add('active');
      activeCategory = chip.getAttribute('data-category');
      renderCourseGrid();
    });
  });

  // Search input
  const searchInput = document.getElementById('course-search-input');
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchQuery = e.target.value.trim().toLowerCase();
      renderCourseGrid();
    });
  }
}

function getStoredCompletedLessons() {
  try {
    return JSON.parse(localStorage.getItem('inoviq_completed_lessons')) || [];
  } catch (e) {
    return [];
  }
}

function saveCompletedLessons(arr) {
  localStorage.setItem('inoviq_completed_lessons', JSON.stringify(arr));
}

function renderCourseGrid() {
  const grid = document.getElementById('courses-grid');
  if (!grid) return;

  const completedList = getStoredCompletedLessons();

  const filtered = COURSE_CATALOG.filter(c => {
    const matchesCat = activeCategory === 'all' || c.category === activeCategory;
    const matchesQuery = !searchQuery || 
      c.title.toLowerCase().includes(searchQuery) ||
      c.description.toLowerCase().includes(searchQuery) ||
      c.sections.some(s => s.title.toLowerCase().includes(searchQuery) || s.body.toLowerCase().includes(searchQuery));
    return matchesCat && matchesQuery;
  });

  if (filtered.length === 0) {
    grid.innerHTML = `
      <div style="grid-column: 1/-1; text-align: center; padding: 3rem; color: var(--text-muted);">
        <p style="font-size: 1.2rem; font-weight: 600;">No courses found matching "${escapeHtml(searchQuery)}"</p>
        <p style="font-size: 0.9rem; margin-top: 0.5rem;">Try searching for "Python", "Flutter", "Docker", or "ORM"</p>
      </div>
    `;
    return;
  }

  grid.innerHTML = filtered.map(c => {
    const totalLessons = c.sections.length;
    const completedCount = c.sections.filter(s => completedList.includes(s.id)).length;
    const pct = Math.round((completedCount / totalLessons) * 100);

    return `
      <div class="course-card" style="--card-accent: ${c.accentColor}; --card-glow: ${c.accentLight};">
        <div class="course-card-top">
          <div class="course-icon-container" style="background: ${c.accentLight}">
            <img src="${c.iconPath}" alt="${c.title} icon" />
          </div>
          <span class="course-badge-pill">${totalLessons} Lessons</span>
        </div>
        <div class="course-info">
          <span class="course-tagline">${c.tagline}</span>
          <h3 class="course-title">${c.title}</h3>
          <p class="course-desc">${c.description}</p>
        </div>
        <div class="course-card-footer">
          <div class="course-progress-summary">
            <div class="mini-progress-bar">
              <div class="mini-progress-fill" style="width: ${pct}%;"></div>
            </div>
            <span>${pct}% Done</span>
          </div>
          <button class="btn-open-course" onclick="openCourseReaderModal('${c.id}')">
            Explore Course →
          </button>
        </div>
      </div>
    `;
  }).join('');
}

/* ==========================================================================
   4. Full Course Reader Modal Studio
   ========================================================================== */
let currentReaderCourse = null;
let currentSectionIndex = 0;

function initCourseReader() {
  const modal = document.getElementById('course-reader-modal');
  const closeBtn = document.getElementById('reader-close-btn');

  if (closeBtn && modal) {
    closeBtn.addEventListener('click', () => {
      modal.classList.remove('active');
    });

    modal.addEventListener('click', (e) => {
      if (e.target === modal) {
        modal.classList.remove('active');
      }
    });

    document.addEventListener('keydown', (e) => {
      if (e.key === 'Escape' && modal.classList.contains('active')) {
        modal.classList.remove('active');
      }
    });
  }

  // Prev / Next lesson buttons
  const btnPrev = document.getElementById('reader-btn-prev');
  const btnNext = document.getElementById('reader-btn-next');

  if (btnPrev) {
    btnPrev.addEventListener('click', () => {
      if (currentSectionIndex > 0) {
        setReaderSection(currentSectionIndex - 1);
      }
    });
  }

  if (btnNext) {
    btnNext.addEventListener('click', () => {
      if (currentReaderCourse && currentSectionIndex < currentReaderCourse.sections.length - 1) {
        setReaderSection(currentSectionIndex + 1);
      }
    });
  }

  // Mark lesson as complete button
  const btnComplete = document.getElementById('reader-btn-complete');
  if (btnComplete) {
    btnComplete.addEventListener('click', () => {
      if (!currentReaderCourse) return;
      const section = currentReaderCourse.sections[currentSectionIndex];
      let completedList = getStoredCompletedLessons();

      if (completedList.includes(section.id)) {
        completedList = completedList.filter(id => id !== section.id);
        saveCompletedLessons(completedList);
        showToast(`Marked "${section.title}" as incomplete`);
      } else {
        completedList.push(section.id);
        saveCompletedLessons(completedList);
        showToast(`✓ Marked "${section.title}" as complete!`);
      }

      updateReaderTOC();
      updateReaderProgress();
      renderCourseGrid(); // sync with grid
    });
  }
}

window.openCourseReaderModal = function(courseId, sectionIndex = 0) {
  const course = COURSE_CATALOG.find(c => c.id === courseId);
  if (!course) return;

  currentReaderCourse = course;
  currentSectionIndex = sectionIndex;

  const modal = document.getElementById('course-reader-modal');
  const title = document.getElementById('reader-course-title');
  const subtitle = document.getElementById('reader-course-sub');
  const iconWrap = document.getElementById('reader-course-icon-wrap');

  if (title) title.textContent = course.title;
  if (subtitle) subtitle.textContent = course.tagline;
  if (iconWrap) {
    iconWrap.style.background = course.accentLight;
    iconWrap.innerHTML = `<img src="${course.iconPath}" alt="${course.title} icon" />`;
  }

  updateReaderTOC();
  setReaderSection(sectionIndex);

  if (modal) modal.classList.add('active');
};

function updateReaderTOC() {
  const tocContainer = document.getElementById('reader-toc-list');
  if (!tocContainer || !currentReaderCourse) return;

  const completedList = getStoredCompletedLessons();

  tocContainer.innerHTML = currentReaderCourse.sections.map((sec, idx) => {
    const isCompleted = completedList.includes(sec.id);
    const isActive = idx === currentSectionIndex;
    return `
      <div class="toc-item ${isActive ? 'active' : ''} ${isCompleted ? 'completed' : ''}" onclick="setReaderSection(${idx})">
        <span>${sec.title}</span>
        <div class="toc-check-icon">✓</div>
      </div>
    `;
  }).join('');

  updateReaderProgress();
}

function updateReaderProgress() {
  if (!currentReaderCourse) return;
  const completedList = getStoredCompletedLessons();
  const total = currentReaderCourse.sections.length;
  const completedCount = currentReaderCourse.sections.filter(s => completedList.includes(s.id)).length;
  const pct = Math.round((completedCount / total) * 100);

  const pctLabel = document.getElementById('reader-progress-pct');
  const fillBar = document.getElementById('reader-progress-fill');

  if (pctLabel) pctLabel.textContent = `${pct}% Complete`;
  if (fillBar) {
    fillBar.style.width = `${pct}%`;
    fillBar.style.background = currentReaderCourse.accentColor;
  }
}

window.setReaderSection = function(index) {
  if (!currentReaderCourse || index < 0 || index >= currentReaderCourse.sections.length) return;
  currentSectionIndex = index;

  const section = currentReaderCourse.sections[index];
  const completedList = getStoredCompletedLessons();
  const isDone = completedList.includes(section.id);

  // Update TOC active state
  document.querySelectorAll('.toc-item').forEach((item, idx) => {
    item.classList.toggle('active', idx === index);
  });

  // Update content elements
  const badgeNum = document.getElementById('reader-lesson-badge');
  const title = document.getElementById('reader-lesson-title');
  const body = document.getElementById('reader-lesson-body');
  const bulletsContainer = document.getElementById('reader-lesson-bullets');
  const codeBox = document.getElementById('reader-code-box');
  const codePre = document.getElementById('reader-code-pre');
  const codeLang = document.getElementById('reader-code-lang');
  const btnComplete = document.getElementById('reader-btn-complete');

  if (badgeNum) badgeNum.textContent = `Lesson ${index + 1} of ${currentReaderCourse.sections.length}`;
  if (title) title.textContent = section.title;
  if (body) body.textContent = section.body;

  if (bulletsContainer) {
    if (section.bullets && section.bullets.length > 0) {
      bulletsContainer.style.display = 'flex';
      bulletsContainer.innerHTML = section.bullets.map(b => `<li>${escapeHtml(b)}</li>`).join('');
    } else {
      bulletsContainer.style.display = 'none';
    }
  }

  if (codeBox && codePre) {
    if (section.codeSnippet) {
      codeBox.style.display = 'block';
      codePre.textContent = section.codeSnippet;
      if (codeLang) codeLang.textContent = currentReaderCourse.title;
    } else {
      codeBox.style.display = 'none';
    }
  }

  if (btnComplete) {
    btnComplete.classList.toggle('done', isDone);
    btnComplete.innerHTML = isDone ? '✓ Completed' : 'Mark Lesson as Complete';
  }

  // Update Prev / Next button states
  const btnPrev = document.getElementById('reader-btn-prev');
  const btnNext = document.getElementById('reader-btn-next');
  if (btnPrev) btnPrev.style.visibility = index === 0 ? 'hidden' : 'visible';
  if (btnNext) btnNext.style.visibility = index === currentReaderCourse.sections.length - 1 ? 'hidden' : 'visible';
};

window.copyReaderSnippet = function() {
  const codePre = document.getElementById('reader-code-pre');
  if (codePre) {
    navigator.clipboard.writeText(codePre.textContent).then(() => {
      showToast('Code snippet copied to clipboard!');
    });
  }
};

window.sendSnippetToPlayground = function() {
  const codePre = document.getElementById('reader-code-pre');
  if (!codePre || !currentReaderCourse) return;

  const modal = document.getElementById('course-reader-modal');
  if (modal) modal.classList.remove('active');

  const playgroundSection = document.getElementById('playground');
  if (playgroundSection) {
    playgroundSection.scrollIntoView({ behavior: 'smooth' });
  }

  // Map course to playground language
  let lang = 'python';
  if (currentReaderCourse.id === 'flutter') lang = 'dart';
  else if (currentReaderCourse.id === 'web') lang = 'javascript';
  else if (currentReaderCourse.id === 'cpp') lang = 'cpp';
  else if (currentReaderCourse.id === 'java') lang = 'java';
  else if (currentReaderCourse.id === 'django') lang = 'python';

  setPlaygroundLang(lang, codePre.textContent);
  showToast(`Loaded ${currentReaderCourse.title} snippet into Live Playground!`);
};

/* ==========================================================================
   5. Interactive Live Code Playground
   ========================================================================== */
const SNIPPET_PRESETS = {
  python: `# INOVIQ Python Interactive Playground
# Try editing and running this code!

def calculate_mastery(completed_lessons, total=10):
    percentage = (completed_lessons / total) * 100
    return f"{percentage}% completed"

courses = ["Python", "Django", "Flutter", "DevOps", "Web Dev"]
print("--- INOVIQ Course Catalog ---")
for idx, course in enumerate(courses, 1):
    print(f"[{idx}] {course}: {calculate_mastery(idx * 2)}")

print("\\nLearning progress verified locally via SQLite backend.db!")
`,
  javascript: `// INOVIQ Modern JavaScript Sandbox
// Pure ES6+ interactivity in action

const student = {
  name: "Ashwin",
  enrolled: ["Flutter", "Python", "SQLite"],
  isOfflineMode: true
};

function getWelcomeMessage({ name, enrolled, isOfflineMode }) {
  return \`Welcome \${name}! You have \${enrolled.length} courses loaded.\` +
         \`\\nOffline storage status: \${isOfflineMode ? "Active (SQLite)" : "Online"}\`;
}

console.log(getWelcomeMessage(student));
console.log("Enrolled topics:", student.enrolled.join(" · "));
`,
  dart: `// INOVIQ Dart / Flutter Simulator
void main() {
  final app = "INOVIQ Mobile Learning Companion";
  final version = "v9.11 (Internship II)";
  final technologies = ["Flutter 3.x", "Dart 2.17+", "sqflite"];

  print("Starting $app - $version");
  print("Architecture: Edge-to-Edge Material 3 UI");
  
  for (var tech in technologies) {
    print("  ✓ Integrated: $tech");
  }
  
  print("Device Status: Local database initialized at /data/backend.db");
}
`,
  cpp: `// Modern C++ Systems Snippet
#include <iostream>
#include <vector>
#include <string>

int main() {
    std::vector<std::string> stack = {"Kernel", "Graphics", "Engine", "INOVIQ"};
    std::cout << "=== High-Performance C++ Simulation ===" << std::endl;
    
    for (size_t i = 0; i < stack.size(); ++i) {
        std::cout << "Layer " << i + 1 << ": " << stack[i] << " [OK]" << std::endl;
    }
    
    std::cout << "Memory Management: RAII Clean & Safe" << std::endl;
    return 0;
}
`,
  java: `// INOVIQ Enterprise Java Runner
public class Main {
    public static void main(String[] args) {
        String appName = "INOVIQ";
        int coursesCount = 8;
        int lessonsCount = 80;

        System.out.println("JVM Bytecode Initialized for: " + appName);
        System.out.printf("Total Courses: %d | Total Modules: %d%n", coursesCount, lessonsCount);
        System.out.println("Android ART VM Compatibility: Verified");
    }
}
`,
};

let currentPlaygroundLang = 'python';

function initPlayground() {
  const editor = document.getElementById('playground-code-editor');
  const runBtn = document.getElementById('playground-run-btn');
  const resetBtn = document.getElementById('playground-reset-btn');
  const copyBtn = document.getElementById('playground-copy-btn');
  const langTabs = document.querySelectorAll('.lang-tab-btn');

  // Load default snippet
  if (editor) editor.value = SNIPPET_PRESETS.python;

  langTabs.forEach(tab => {
    tab.addEventListener('click', () => {
      langTabs.forEach(t => t.classList.remove('active'));
      tab.classList.add('active');
      const lang = tab.getAttribute('data-lang');
      setPlaygroundLang(lang);
    });
  });

  if (runBtn) {
    runBtn.addEventListener('click', runPlaygroundCode);
  }

  if (resetBtn) {
    resetBtn.addEventListener('click', () => {
      if (editor) editor.value = SNIPPET_PRESETS[currentPlaygroundLang] || '';
      showToast('Playground reset to default preset');
    });
  }

  if (copyBtn) {
    copyBtn.addEventListener('click', () => {
      if (editor) {
        navigator.clipboard.writeText(editor.value).then(() => {
          showToast('Code copied to clipboard!');
        });
      }
    });
  }
}

function setPlaygroundLang(lang, customCode = null) {
  currentPlaygroundLang = lang;
  const editor = document.getElementById('playground-code-editor');
  const langLabel = document.getElementById('playground-editor-lang');

  document.querySelectorAll('.lang-tab-btn').forEach(t => {
    t.classList.toggle('active', t.getAttribute('data-lang') === lang);
  });

  if (langLabel) langLabel.textContent = lang.toUpperCase();
  if (editor) {
    editor.value = customCode || SNIPPET_PRESETS[lang] || '';
  }
}

function runPlaygroundCode() {
  const editor = document.getElementById('playground-code-editor');
  const stdout = document.getElementById('terminal-stdout');
  const execTimeElem = document.getElementById('terminal-exec-time');

  if (!editor || !stdout) return;

  const code = editor.value;
  stdout.innerHTML = '<span class="system-msg">Executing in sandbox...</span>\n';

  const startTime = performance.now();

  try {
    if (currentPlaygroundLang === 'javascript') {
      // Execute JS in a safe isolated capture
      const logs = [];
      const customConsole = {
        log: (...args) => logs.push(args.map(a => typeof a === 'object' ? JSON.stringify(a, null, 2) : String(a)).join(' ')),
        error: (...args) => logs.push(`[ERROR] ${args.join(' ')}`),
        warn: (...args) => logs.push(`[WARN] ${args.join(' ')}`),
      };

      const runner = new Function('console', code);
      runner(customConsole);

      const endTime = performance.now();
      const elapsed = (endTime - startTime).toFixed(1);

      if (execTimeElem) execTimeElem.textContent = `${elapsed} ms`;
      stdout.innerHTML = logs.length > 0
        ? escapeHtml(logs.join('\n'))
        : '<span class="system-msg">Process exited with 0 output logs.</span>';
    } else {
      // Simulate execution for Python, Dart, C++, Java with realistic parsing
      setTimeout(() => {
        const simulatedOutput = simulateCodeRun(code, currentPlaygroundLang);
        const elapsed = (performance.now() - startTime).toFixed(1);
        if (execTimeElem) execTimeElem.textContent = `${elapsed} ms`;
        stdout.innerHTML = simulatedOutput;
      }, 120);
    }
  } catch (err) {
    if (execTimeElem) execTimeElem.textContent = '0 ms';
    stdout.innerHTML = `<span class="error-msg">Runtime Error: ${escapeHtml(err.message)}</span>`;
  }
}

function simulateCodeRun(code, lang) {
  const lines = code.split('\n');
  const outputs = [];

  for (let line of lines) {
    const trimmed = line.trim();
    // Match print statements: print("..."), print(f"..."), std::cout << "..." << std::endl;, System.out.println("...")
    const pyMatch = trimmed.match(/^print\((?:f?["'])(.+?)(?:["'])\)$/);
    const dartMatch = trimmed.match(/^print\(["'](.+?)["']\);?$/);
    const cppMatch = trimmed.match(/std::cout\s*<<\s*["'](.+?)["']/);
    const javaMatch = trimmed.match(/System\.out\.println\(["'](.+?)["']\);?/);

    if (pyMatch) outputs.push(pyMatch[1].replace(/\\n/g, '\n'));
    else if (dartMatch) outputs.push(dartMatch[1]);
    else if (cppMatch) outputs.push(cppMatch[1]);
    else if (javaMatch) outputs.push(javaMatch[1]);
  }

  if (outputs.length > 0) {
    return escapeHtml(outputs.join('\n')) + `\n\n<span class="system-msg">Process completed with exit code 0 (${lang.toUpperCase()} Sandbox)</span>`;
  }

  // Fallback realistic output
  return `=== ${lang.toUpperCase()} Execution Output ===\nCompilation verified successfully.\nAllocated memory: 1.4 MB\nAll assertions passed.\n\n<span class="system-msg">Process completed with exit code 0.</span>`;
}

/* ==========================================================================
   6. SQLite Database & Architecture Inspector
   ========================================================================== */
const INITIAL_USERS = [
  { id: 1, username: 'ashwin_ts', email: 'ashwin@inoviq.com', gender: 'Male', role: 'Intern Engineer' },
  { id: 2, username: 'jessa_j', email: 'jessa@inoviq.com', gender: 'Female', role: 'Intern Engineer' },
  { id: 3, username: 'anzil_tz', email: 'anzil@inoviq.com', gender: 'Male', role: 'Intern Engineer' },
  { id: 4, username: 'abishek_p', email: 'abishek@inoviq.com', gender: 'Male', role: 'Intern Engineer' },
  { id: 5, username: 'ahnas_m', email: 'ahnas@inoviq.com', gender: 'Male', role: 'Project Manager' },
];

function initDatabaseInspector() {
  const queryChips = document.querySelectorAll('.query-chip');
  queryChips.forEach(chip => {
    chip.addEventListener('click', () => {
      const query = chip.getAttribute('data-sql');
      executeSimulatedSQL(query);
    });
  });

  // Run initial query
  executeSimulatedSQL('SELECT * FROM users;');
}

function executeSimulatedSQL(sql) {
  const resultBox = document.getElementById('sql-query-result');
  const queryDisplay = document.getElementById('current-sql-display');

  if (queryDisplay) queryDisplay.textContent = sql;
  if (!resultBox) return;

  if (sql.includes('SELECT * FROM users')) {
    resultBox.innerHTML = `
      <table style="width:100%; border-collapse:collapse; font-size:0.76rem;">
        <tr style="border-bottom: 1px solid rgba(255,255,255,0.1); color: var(--teal-accent);">
          <th>ID</th><th>USERNAME</th><th>EMAIL</th><th>GENDER</th><th>ROLE</th>
        </tr>
        ${INITIAL_USERS.map(u => `
          <tr style="border-bottom: 1px solid rgba(255,255,255,0.03);">
            <td>${u.id}</td><td>${u.username}</td><td>${u.email}</td><td>${u.gender}</td><td>${u.role}</td>
          </tr>
        `).join('')}
      </table>
      <div style="margin-top:8px; color:var(--text-muted); font-size:0.7rem;">5 rows returned in 0.8ms (SQLite backend.db)</div>
    `;
  } else if (sql.includes('SELECT email FROM login')) {
    resultBox.innerHTML = `
      <table style="width:100%; border-collapse:collapse; font-size:0.76rem;">
        <tr style="border-bottom: 1px solid rgba(255,255,255,0.1); color: var(--teal-accent);">
          <th>ID</th><th>EMAIL</th><th>STATUS</th>
        </tr>
        ${INITIAL_USERS.map(u => `
          <tr style="border-bottom: 1px solid rgba(255,255,255,0.03);">
            <td>${u.id}</td><td>${u.email}</td><td>AUTHENTICATED</td>
          </tr>
        `).join('')}
      </table>
      <div style="margin-top:8px; color:var(--text-muted); font-size:0.7rem;">5 credentials verified in 0.4ms</div>
    `;
  } else if (sql.includes('INSERT INTO')) {
    resultBox.innerHTML = `
      <div style="color: #10b981; font-weight:600;">✓ Query OK: 1 row affected (insert id: 6)</div>
      <div style="color: var(--text-muted); margin-top:4px;">SQLite auto-incremented primary key [id=6] committed to backend.db</div>
    `;
  } else if (sql.includes('DELETE FROM')) {
    resultBox.innerHTML = `
      <div style="color: #fbbf24; font-weight:600;">⚠️ Safety Guard Checked: "DELETE" verified.</div>
      <div style="color: var(--text-muted); margin-top:4px;">1 record deleted from 'users' and 'login' tables in backend.db</div>
    `;
  }
}

/* ==========================================================================
   7. Client-side Auth & Registration Simulator Modal
   ========================================================================== */
function initAuthSimulator() {
  const modal = document.getElementById('auth-modal');
  const openBtns = document.querySelectorAll('.open-auth-modal-btn');
  const closeBtn = document.getElementById('auth-modal-close');
  const form = document.getElementById('simulated-signup-form');

  openBtns.forEach(b => {
    b.addEventListener('click', (e) => {
      e.preventDefault();
      if (modal) modal.classList.add('active');
    });
  });

  if (closeBtn && modal) {
    closeBtn.addEventListener('click', () => modal.classList.remove('active'));
    modal.addEventListener('click', (e) => {
      if (e.target === modal) modal.classList.remove('active');
    });
  }

  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();

      const username = document.getElementById('auth-input-username').value.trim();
      const email = document.getElementById('auth-input-email').value.trim();
      const password = document.getElementById('auth-input-password').value;
      const confirm = document.getElementById('auth-input-confirm').value;
      const gender = form.querySelector('input[name="gender"]:checked')?.value || 'Other';
      const errorMsg = document.getElementById('auth-error-display');

      // Validation matching Flutter app rules
      if (!username || !email || !password || !confirm) {
        showAuthError('All fields are required.');
        return;
      }

      if (!email.includes('@') || !email.includes('.')) {
        showAuthError('Please enter a valid email address with @ and .');
        return;
      }

      if (password.length < 6) {
        showAuthError('Password must be at least 6 characters long.');
        return;
      }

      if (password !== confirm) {
        showAuthError('Passwords do not match. Please verify.');
        return;
      }

      // Successful simulated registration!
      errorMsg.classList.remove('visible');
      const newUser = { id: INITIAL_USERS.length + 1, username, email, gender, role: 'Learner' };
      INITIAL_USERS.push(newUser);

      // Update phone simulator profile state
      const avatarName = document.getElementById('v-phone-username');
      const avatarEmail = document.getElementById('v-phone-email');
      const avatarGender = document.getElementById('v-phone-gender');
      if (avatarName) avatarName.textContent = username;
      if (avatarEmail) avatarEmail.textContent = email;
      if (avatarGender) avatarGender.textContent = gender;

      form.reset();
      modal.classList.remove('active');
      showToast(`🎉 Welcome ${username}! Account created in SQLite backend.db!`);
      switchPhoneScreen('profile');
    });
  }
}

function showAuthError(msg) {
  const errorMsg = document.getElementById('auth-error-display');
  if (errorMsg) {
    errorMsg.textContent = msg;
    errorMsg.classList.add('visible');
  }
}

/* ==========================================================================
   8. Knowledge Check Quiz Widget
   ========================================================================== */
let currentQuizIndex = 0;
let quizScore = 0;
let quizAnswered = false;

function initQuiz() {
  renderQuizQuestion();

  const nextBtn = document.getElementById('quiz-next-btn');
  if (nextBtn) {
    nextBtn.addEventListener('click', () => {
      if (currentQuizIndex < QUIZ_QUESTIONS.length - 1) {
        currentQuizIndex++;
        quizAnswered = false;
        renderQuizQuestion();
      } else {
        // Quiz completed
        showQuizSummary();
      }
    });
  }
}

function renderQuizQuestion() {
  const q = QUIZ_QUESTIONS[currentQuizIndex];
  const topicTag = document.getElementById('quiz-topic');
  const countTag = document.getElementById('quiz-question-counter');
  const qText = document.getElementById('quiz-question');
  const optionsWrap = document.getElementById('quiz-options');
  const explanation = document.getElementById('quiz-explanation');
  const nextBtn = document.getElementById('quiz-next-btn');

  if (topicTag) topicTag.textContent = `${q.course} Question`;
  if (countTag) countTag.textContent = `Question ${currentQuizIndex + 1} of ${QUIZ_QUESTIONS.length}`;
  if (qText) qText.textContent = q.question;
  if (explanation) explanation.classList.remove('visible');
  if (nextBtn) nextBtn.style.display = 'none';

  if (optionsWrap) {
    optionsWrap.innerHTML = q.options.map((opt, idx) => `
      <button class="quiz-option-btn" onclick="selectQuizOption(${idx})">
        <span>${String.fromCharCode(65 + idx)}. ${escapeHtml(opt)}</span>
        <span class="quiz-option-icon"></span>
      </button>
    `).join('');
  }
}

window.selectQuizOption = function(selectedIdx) {
  if (quizAnswered) return;
  quizAnswered = true;

  const q = QUIZ_QUESTIONS[currentQuizIndex];
  const buttons = document.querySelectorAll('.quiz-option-btn');
  const explanation = document.getElementById('quiz-explanation');
  const nextBtn = document.getElementById('quiz-next-btn');
  const scoreDisplay = document.getElementById('quiz-score-val');

  buttons.forEach((btn, idx) => {
    btn.setAttribute('disabled', 'true');
    if (idx === q.correct) {
      btn.classList.add('correct');
      btn.querySelector('.quiz-option-icon').textContent = '✓ Correct';
    } else if (idx === selectedIdx) {
      btn.classList.add('incorrect');
      btn.querySelector('.quiz-option-icon').textContent = '✗';
    }
  });

  if (selectedIdx === q.correct) {
    quizScore++;
    if (scoreDisplay) scoreDisplay.textContent = `${quizScore}/${QUIZ_QUESTIONS.length}`;
    showToast('✓ Correct Answer! Well done!');
  } else {
    showToast('Incorrect. Check the explanation below.');
  }

  if (explanation) {
    explanation.textContent = `Explanation: ${q.explanation}`;
    explanation.classList.add('visible');
  }

  if (nextBtn) {
    nextBtn.style.display = 'inline-flex';
    nextBtn.textContent = currentQuizIndex === QUIZ_QUESTIONS.length - 1 ? 'View Final Results' : 'Next Question →';
  }
};

function showQuizSummary() {
  const card = document.querySelector('.quiz-widget-card');
  if (!card) return;

  const pct = Math.round((quizScore / QUIZ_QUESTIONS.length) * 100);
  card.innerHTML = `
    <div style="text-align: center; padding: 2rem 1rem;">
      <div style="font-size: 3.5rem; margin-bottom: 1rem;">${pct >= 80 ? '🏆' : '📚'}</div>
      <h3 style="font-size: 1.8rem; font-weight: 800; margin-bottom: 0.5rem;">Knowledge Check Completed!</h3>
      <p style="color: var(--text-secondary); font-size: 1.1rem; margin-bottom: 1.5rem;">
        You scored <strong>${quizScore}</strong> out of <strong>${QUIZ_QUESTIONS.length}</strong> (${pct}%)
      </p>
      <p style="color: var(--text-muted); font-size: 0.9rem; max-width: 480px; margin: 0 auto 1.8rem;">
        ${pct >= 80 
          ? 'Impressive! You have mastered the fundamentals across Flutter, Python, Django, SQLite, and C++.'
          : 'Great effort! Explore all 8 courses in the Course Catalogue above to deepen your programming mastery.'}
      </p>
      <button class="btn-primary" onclick="restartQuiz()">
        ↻ Retake Knowledge Check
      </button>
    </div>
  `;
}

window.restartQuiz = function() {
  currentQuizIndex = 0;
  quizScore = 0;
  quizAnswered = false;
  location.reload();
};

/* ==========================================================================
   9. Mobile Menu Navigation
   ========================================================================== */
function initMobileMenu() {
  const menuBtn = document.getElementById('mobile-menu-toggle');
  const navLinks = document.querySelector('.nav-links');

  if (menuBtn && navLinks) {
    menuBtn.addEventListener('click', () => {
      const isVisible = navLinks.style.display === 'flex';
      navLinks.style.display = isVisible ? 'none' : 'flex';
      if (!isVisible) {
        navLinks.style.flexDirection = 'column';
        navLinks.style.position = 'absolute';
        navLinks.style.top = '88px';
        navLinks.style.left = '0';
        navLinks.style.width = '100%';
        navLinks.style.background = 'var(--bg-secondary)';
        navLinks.style.padding = '1.5rem';
        navLinks.style.borderBottom = '1px solid var(--border-glass)';
      }
    });

    document.querySelectorAll('.nav-link').forEach(link => {
      link.addEventListener('click', () => {
        if (window.innerWidth <= 768) {
          navLinks.style.display = 'none';
        }
      });
    });
  }
}

/* ==========================================================================
   Utility Helpers
   ========================================================================== */
function showToast(message) {
  let toast = document.getElementById('site-toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'site-toast';
    toast.className = 'toast-notice';
    document.body.appendChild(toast);
  }

  toast.textContent = message;
  toast.classList.add('show');

  clearTimeout(toast._timeout);
  toast._timeout = setTimeout(() => {
    toast.classList.remove('show');
  }, 3200);
}

function escapeHtml(str) {
  if (!str) return '';
  return String(str)
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;')
    .replace(/'/g, '&#039;');
}
