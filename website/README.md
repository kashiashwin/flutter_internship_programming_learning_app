# 🌐 INOVIQ — Official Web Platform & Interactive Learning Showcase

An interactive, responsive web application built for the **INOVIQ Programming Learning App** project.

## 🚀 Features

- **📱 Interactive Phone Simulator**: Experience the Flutter app directly in the browser across 4 virtual screens (Welcome, Home Course Catalog, Course Detail, and Profile).
- **📚 8 Comprehensive Curricula**: Python, Django, C++, Java, Flutter, Web Development, Game Development, and DevOps.
- **📖 Interactive Course Reader Studio**: Sticky Table of Contents, 80 structured lessons, code snippets, bullet points, and live completion progress tracking saved to `localStorage`.
- **💻 Live Code Playground Sandbox**: Run and test Python, JavaScript, Dart, C++, and Java snippets in a sandboxed execution terminal.
- **🗄️ SQLite Architecture & Database Inspector**: Interactive schema visualizer for `users` and `login` tables with an interactive SQL query runner.
- **🔐 Client-Side Auth Simulator**: Test registration and validation rules (email syntax, 6+ character password, confirm match, gender selection) matching the Flutter app.
- **🧠 Interactive Knowledge Check**: 5-question multi-choice quiz with immediate feedback and detailed explanations.
- **🌓 Obsidian Dark & Teal Light Themes**: Seamless theme toggle with fluid transitions and glassmorphic styling.
- **👥 Internship Team & Leadership Spotlight**: Highlights all 7 team members and project managers.

---

## 🏃 Quick Start

### Option 1: Open Directly in Any Web Browser
Simply double-click [`index.html`](./index.html) or open it in Chrome, Edge, Firefox, or Safari. No build step or installation required!

### Option 2: Run with Python Local Server
```bash
# From the project root
python -m http.server 3000 --directory website
```
Then visit: `http://localhost:3000`

### Option 3: Run with Node (npx)
```bash
npx serve website -l 3000
```

---

## 📁 File Structure

```
website/
├── index.html          # Main HTML structure with semantic tags and accessibility
├── styles.css          # Glassmorphism, Material 3 teal theme, and animations
├── course-data.js      # All 8 courses, 80 lessons, team info, and quiz questions
├── app.js              # Interactive phone mockup, code playground, and database inspector
├── assets/
│   ├── images/
│   │   └── company_logo.png
│   └── icons/
│       ├── app_icon.png
│       ├── pyic.svg, djic.svg, cppic.svg, javaic.svg
│       ├── flutic.svg, csic.svg, gic.svg, dvic.svg
```

---

© 2026 INOVIQ — Built by the Internship Team.
