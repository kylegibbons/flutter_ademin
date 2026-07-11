import 'package:flutter/material.dart';
import 'package:flutter_ademin/demo/page/faqs/faqs_models.dart';

final List<FaqCategory> mockFaqCategories = [
  FaqCategory(
    title: "General Questions",
    icon: Icons.help_outline,
    items: [
      FaqItem(
        question: "What is Flutter?",
        answer:
            "Flutter is an open-source UI software development toolkit created by Google. It is used to develop applications for Android, iOS, Linux, Mac, Windows, and the web from a single codebase.",
      ),
      FaqItem(
        question: "How to get started with Flutter?",
        answer:
            "To get started with Flutter, install the Flutter SDK and set up your development environment. Visit the official Flutter website for installation instructions and tutorials.",
      ),
      FaqItem(
        question: "What is Dart?",
        answer:
            "Dart is a client-optimized programming language for apps on multiple platforms. It is used to write Flutter apps, offering features like hot reload and rich libraries.",
      ),
      FaqItem(
        question: "What is hot reload in Flutter?",
        answer:
            "Hot reload allows developers to instantly see changes made in the code without restarting the app. It greatly speeds up the development process.",
      ),
      FaqItem(
        question: "Where can I find Flutter documentation?",
        answer:
            "You can find the official Flutter documentation at https://flutter.dev/docs, which includes guides, API references, and other useful resources.",
      ),
    ],
  ),

  FaqCategory(
    title: "Manage Account",
    icon: Icons.person_outline,
    items: [
      FaqItem(
        question: "How do I create a Flutter account?",
        answer:
            "To create a Flutter account, you need to sign in with your Google account or create a new one on the Flutter website. Visit the official Flutter site and follow the registration process to set up your account.",
      ),
      FaqItem(
        question: "Can I use Flutter without an account?",
        answer:
            "Yes, you can use Flutter to build apps without an account. However, having an account allows you to manage your project settings, access premium services, and connect with the Flutter community.",
      ),
      FaqItem(
        question: "How do I reset my Flutter account password?",
        answer:
            "To reset your password, visit the Flutter account recovery page. Enter your registered email address, and you'll receive instructions on how to reset your password and regain access to your account.",
      ),
      FaqItem(
        question: "Is there a Flutter developer certification?",
        answer:
            "Currently, Flutter does not offer an official certification. However, there are various third-party platforms offering Flutter courses that might provide certificates. Flutter’s official documentation and community resources are great ways to learn and showcase your skills.",
      ),
      FaqItem(
        question: "How do I update my Flutter account details?",
        answer:
            "You can update your Flutter account details by logging into the Flutter dashboard. Once logged in, you can change your email, password, and other profile information from the account settings section.",
      ),
    ],
  ),

  FaqCategory(
    title: "Privacy & Security",
    icon: Icons.security_outlined,
    items: [
      FaqItem(
        question: "How secure is Flutter for building apps?",
        answer:
            "Flutter is a secure framework for building apps, as it follows best practices for security and uses platform-specific encryption mechanisms. However, like any app development framework, it's essential to implement additional security measures such as data encryption, secure storage, and proper authentication in your app.",
      ),
      FaqItem(
        question: "How can I secure user data in my Flutter app?",
        answer:
            "To secure user data in your Flutter app, you should use secure storage solutions like the `flutter_secure_storage` package. Additionally, always ensure that sensitive information is encrypted, and use secure network communication protocols like HTTPS for API calls.",
      ),
      FaqItem(
        question: "Does Flutter support secure authentication?",
        answer:
            "Yes, Flutter supports secure authentication methods, such as OAuth 2.0, Firebase Authentication, and two-factor authentication (2FA). You can use these methods to implement secure login and user authentication in your app.",
      ),
      FaqItem(
        question: "How can I prevent unauthorized access?",
        answer:
            "To prevent unauthorized access, ensure that your app uses secure authentication mechanisms like OAuth, Firebase Auth, or JWT (JSON Web Tokens). Also, consider using access control rules and permissions to protect sensitive data and functionality within the app.",
      ),
      FaqItem(
        question: "Is my Flutter app vulnerable to attacks?",
        answer:
            "While Flutter provides a secure development environment, no app is immune to attacks. To minimize vulnerabilities, follow security best practices such as input validation, avoiding storing sensitive data on the device, using encrypted communication, and regularly updating dependencies to patch any known security issues.",
      ),
    ],
  ),

  FaqCategory(
    title: "Performance",
    icon: Icons.speed,
    items: [
      FaqItem(
        question: "How can I improve the performance of my Flutter app?",
        answer:
            "To optimize your Flutter app's performance, focus on reducing the widget tree complexity, using `const` constructors where possible, avoiding unnecessary rebuilds with `Provider` or `Riverpod`, and leveraging the `flutter_devtools` for profiling. You can also use the `ListView.builder` for efficient rendering of large lists and avoid rendering heavy UI elements off-screen.",
      ),
      FaqItem(
        question: "How can I reduce app launch time in Flutter?",
        answer:
            "To reduce app launch time, minimize the app's initial build, load only essential resources on startup, and use deferred loading for non-essential resources. You can also use the `Flutter performance` tab in DevTools to analyze startup time and optimize your app's initialization process.",
      ),
      FaqItem(
        question: "How do I prevent jank in my Flutter app?",
        answer:
            "To prevent jank, ensure that you're avoiding long-running operations on the main thread. Use `FutureBuilder` or `StreamBuilder` for asynchronous operations and perform heavy tasks in separate isolates. You can also use the `flutter_devtools` to identify and fix jank in your app.",
      ),
      FaqItem(
        question: "What are lazy loading techniques in Flutter?",
        answer:
            "Lazy loading in Flutter can be implemented with widgets like `ListView.builder` and `GridView.builder`, which load only the items visible on the screen. This reduces memory usage and improves scrolling performance by loading data in chunks as needed.",
      ),
      FaqItem(
        question:
            "How can I use Flutter's Isolate for performance improvements?",
        answer:
            "Isolates in Flutter allow you to run heavy computations in the background without blocking the main thread. Use isolates to offload expensive tasks like network requests or complex data processing, and ensure that the UI remains responsive while performing these tasks.",
      ),
    ],
  ),

  FaqCategory(
    title: "Best Practices",
    icon: Icons.rule,
    items: [
      FaqItem(
        question:
            "What are some best practices for writing clean Flutter and Dart code?",
        answer:
            "Some best practices for writing clean Flutter and Dart code include using `const` constructors, organizing your project into clear directories (e.g., models, views, controllers), following Dart's effective dart guidelines, and adhering to SOLID principles for good software design. Additionally, use packages like `flutter_lints` to enforce linting and maintain consistency in your codebase.",
      ),
      FaqItem(
        question: "How should I handle errors and exceptions in Flutter?",
        answer:
            "To handle errors and exceptions in Flutter, use `try-catch` blocks around code that can throw exceptions, and make sure to log or report errors using tools like `Sentry` or Firebase Crashlytics. Also, consider using custom error screens to gracefully handle uncaught exceptions and provide feedback to users.",
      ),
      FaqItem(
        question:
            "What are Flutter hooks and how can they improve code readability?",
        answer:
            "Flutter hooks, provided by the `flutter_hooks` package, allow you to manage state and lifecycle in a more functional and concise way. They help you eliminate boilerplate code, such as setting up and disposing of controllers, improving readability and reducing the amount of code in your widget trees.",
      ),
      FaqItem(
        question:
            "How can I improve my Dart code with effective asynchronous programming?",
        answer:
            "Dart provides robust support for asynchronous programming with `async`, `await`, and `Future`. Use `async` for non-blocking operations and avoid blocking the main thread. Leverage `Stream` for continuous data and `FutureBuilder` to update the UI when async operations complete.",
      ),
      FaqItem(
        question: "What is the importance of code linting in Flutter projects?",
        answer:
            "Code linting helps enforce a consistent coding style, catch potential errors early, and improve code quality. By using tools like `flutter_lints`, you can automatically check your code for common issues, ensure that best practices are followed, and maintain readability and maintainability across your project.",
      ),
    ],
  ),

  FaqCategory(
    title: "Widgets & UI",
    icon: Icons.widgets_outlined,
    items: [
      FaqItem(
        question: "How can I use custom widgets and layouts in Flutter?",
        answer:
            "Custom widgets in Flutter allow you to create reusable and maintainable UI components. You can create custom widgets by extending `StatelessWidget` or `StatefulWidget` and combining different Flutter layout widgets like `Row`, `Column`, `Stack`, and `Container` to achieve the desired UI structure. You can also use `CustomPainter` for more advanced graphics rendering and customize the UI to fit your app's unique design.",
      ),
      FaqItem(
        question: "How can I create a responsive layout in Flutter?",
        answer:
            "To create responsive layouts in Flutter, use widgets like `MediaQuery` to access screen size, `LayoutBuilder` to determine the available space, and `Flexible` or `Expanded` to adapt widget sizes. You can also use packages like `flutter_screenutil` to handle different screen sizes and resolutions effectively.",
      ),
      FaqItem(
        question:
            "How do I manage complex UIs with multiple child widgets in Flutter?",
        answer:
            "To manage complex UIs with multiple child widgets, use layout widgets like `Column`, `Row`, and `Stack` to organize content. You can also break down complex UI into smaller reusable custom widgets to improve code readability and make it easier to maintain and test individual components.",
      ),
      FaqItem(
        question:
            "What is the difference between `StatelessWidget` and `StatefulWidget`?",
        answer:
            "`StatelessWidget` is used for static content that doesn't require changes during the widget's lifetime. `StatefulWidget`, on the other hand, is used when you need to manage mutable state, and the widget needs to rebuild itself when state changes, such as when handling user interactions.",
      ),
      FaqItem(
        question: "How can I handle animations and transitions in Flutter?",
        answer:
            "Flutter provides several options for animations, such as `AnimatedContainer`, `TweenAnimationBuilder`, and the `AnimationController` with `AnimatedBuilder`. For complex transitions, you can use `PageRouteBuilder` or `Hero` widgets to create smooth transitions between different screens and UI elements.",
      ),
    ],
  ),
];
