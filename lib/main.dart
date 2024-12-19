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

  Future<bool> _handleBackButton() async {
    // Add your back button handling logic here
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          const Size(414, 896), // Set base design size for iPhone Pro/Pro Max
      builder: (context, child) {
        return Builder(
          builder: (context) {
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
