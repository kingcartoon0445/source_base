import 'package:flutter/material.dart';
import 'package:source_base/presentation/screens/auth/login_screen.dart';
import 'package:source_base/presentation/screens/auth/register_screen.dart';
import 'package:source_base/presentation/screens/home/home_screen.dart';

class AppRoutes {
  // Định nghĩa các route name
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  // Đăng ký các route
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        register: (context) => const RegisterScreen(),
        home: (context) => const HomeScreen(),
      };
}
