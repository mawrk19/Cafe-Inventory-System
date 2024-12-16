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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime? _lastBackPressTime;

  Future<bool> _handleBackButton() async {
    final currentTime = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        _lastBackPressTime == null ||
            currentTime.difference(_lastBackPressTime!) > const Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      _lastBackPressTime = currentTime;
      // Show a snackbar to inform the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896), // Set base design size for iPhone Pro/Pro Max
      builder: (context, child) {
        return MaterialApp(
          title: 'Kopilism App',
          theme: AppTheme.lightTheme,
          home: WillPopScope(
            onWillPop: _handleBackButton,
            child: const SignIn(),
          ),
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
