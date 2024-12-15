import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kopilism/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kopilism/frontend/screens/sign_in.dart';
import 'package:kopilism/theme/app_theme.dart';
import 'package:kopilism/backend/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(414, 896), // Set base design size for iPhone Pro/Pro Max
      builder: (context, child) {
        return MaterialApp(
          title: 'Kopilism App',
          theme: AppTheme.lightTheme, // Use custom light theme
          home: const DoubleBackToExitWrapper(child: SignIn()),
          debugShowCheckedModeBanner: false,
          routes: getAppRoutes(),
          onUnknownRoute: (settings) {
            return MaterialPageRoute(
              builder: (context) => const NotFoundScreen(),
            );
          },
        );
      },
    );
  }
}

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('404 - Not Found')),
      body: const Center(child: Text('Page not found!')),
    );
  }
}

class DoubleBackToExitWrapper extends StatefulWidget {
  final Widget child;

  const DoubleBackToExitWrapper({super.key, required this.child});

  @override
  State<DoubleBackToExitWrapper> createState() =>
      _DoubleBackToExitWrapperState();
}

class _DoubleBackToExitWrapperState extends State<DoubleBackToExitWrapper> {
  DateTime? _lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        final shouldExit = _lastBackPressed == null ||
            now.difference(_lastBackPressed!) > const Duration(seconds: 2);

        if (shouldExit) {
          _lastBackPressed = now;
          ScaffoldMessenger.of(context).showSnackBar( 
            const SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true; // Exit the app
      },
      child: widget.child,
    );
  }
}
