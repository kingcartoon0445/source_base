import 'package:get_it/get_it.dart';
import 'package:source_base/core/api/dio_client.dart';
import 'package:source_base/data/datasources/local/storage_service.dart';
import 'package:source_base/data/datasources/remote/api_service.dart';
import 'package:source_base/data/repositories/user_repository.dart';
import 'package:source_base/presentation/blocs/auth/auth_bloc.dart';
import 'package:source_base/presentation/blocs/theme/theme_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Khởi tạo GetIt singleton
final GetIt getIt = GetIt.instance;

// Thiết lập các dependency
Future<void> setupServiceLocator() async {
  // Services
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // API Client
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  getIt.registerLazySingleton<StorageService>(
      () => StorageService(getIt<SharedPreferences>()));
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<DioClient>()));

  // Repositories
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(
        apiService: getIt<ApiService>(),
        storageService: getIt<StorageService>(),
      ));

  // BLoCs
  getIt.registerFactory<ThemeBloc>(() => ThemeBloc());
  getIt.registerFactory<AuthBloc>(
      () => AuthBloc(userRepository: getIt<UserRepository>()));
}
