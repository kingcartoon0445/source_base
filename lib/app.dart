import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:source_base/config/routes.dart';
import 'package:source_base/di/service_locator.dart';
import 'package:source_base/presentation/blocs/auth/auth_bloc.dart';
import 'package:source_base/presentation/blocs/theme/theme_bloc.dart';
import 'package:source_base/presentation/screens/auth/login_screen.dart';

import 'presentation/blocs/theme/theme_state.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Đăng ký các BLoC
        BlocProvider<ThemeBloc>(
          create: (_) => getIt<ThemeBloc>(),
        ),
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          // Xây dựng ứng dụng với chủ đề từ ThemeBloc
          return MaterialApp(
            title: 'Flutter Demo',
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: state.themeData, // Sử dụng theme từ state
            routes: AppRoutes.routes,
            home: const LoginScreen(),
          );
        },
      ),
    );
  }
}
