import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suri_checking_event_app/core/helper/size_helper.dart';
import 'package:suri_checking_event_app/core/remote/dio/dio_client.dart';
import 'package:suri_checking_event_app/core/remote/dio/logging_interceptor.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:suri_checking_event_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:suri_checking_event_app/features/auth/domain/repositories/auth_repositories.dart';
import 'package:suri_checking_event_app/features/auth/domain/usecase/auth_usecase.dart';
import 'package:suri_checking_event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:suri_checking_event_app/features/event/data/datasources/event_remote_data_source.dart';
import 'package:suri_checking_event_app/features/event/data/datasources/kol_remote_date_source.dart';
import 'package:suri_checking_event_app/features/event/data/repositories/event_repository_impl.dart';
import 'package:suri_checking_event_app/features/event/data/repositories/kol_repository_impl.dart';
import 'package:suri_checking_event_app/features/event/domain/repositories/event_repositories.dart';
import 'package:suri_checking_event_app/features/event/domain/repositories/kol_repositories.dart';
import 'package:suri_checking_event_app/features/event/domain/usecase/event_usecase.dart';
import 'package:suri_checking_event_app/features/event/domain/usecase/kol_usecase.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/gift/data/datasources/gift_remote_date_source.dart';
import 'package:suri_checking_event_app/features/gift/data/repositories/gift_repository_impl.dart';
import 'package:suri_checking_event_app/features/gift/domain/repositories/gift_repositories.dart';
import 'package:suri_checking_event_app/features/gift/domain/usecase/gift_usecase.dart';
import 'package:suri_checking_event_app/features/gift/presentation/bloc/gift_bloc.dart';
import 'package:suri_checking_event_app/features/home/data/datasources/home_remote_data_source.dart';
import 'package:suri_checking_event_app/features/home/data/repositories/home_repository_impl.dart';
import 'package:suri_checking_event_app/features/home/domain/repositories/home_repositories.dart';
import 'package:suri_checking_event_app/features/home/domain/usecase/home_usecase.dart';
import 'package:suri_checking_event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/data/datasources/sponsor_remote_data_source.dart';
import 'package:suri_checking_event_app/features/sponsor/data/repositories/sponsor_repository_impl.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/repositories/sponsor_repositories.dart';
import 'package:suri_checking_event_app/features/sponsor/domain/usecase/sponsor_usecase.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_bloc.dart';
import 'package:suri_checking_event_app/features/user/data/datasources/user_remote_data_source.dart';
import 'package:suri_checking_event_app/features/user/data/repositories/user_repository_impl.dart';
import 'package:suri_checking_event_app/features/user/domain/repositories/user_repositories.dart';
import 'package:suri_checking_event_app/features/user/domain/usecase/user_usecase.dart';
import 'package:suri_checking_event_app/features/user/presentation/bloc/user_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton<LoggingInterceptor>(() => LoggingInterceptor());

  sl.registerSingleton<SharedPreferenceHelper>(
      SharedPreferenceHelper(sharedPreferences));

  sl.registerSingleton<SizeHelper>(SizeHelper());
  sl.registerSingleton<DioClient>(DioClient());

  // Presentation layer
  sl.registerFactory(() => AuthBloc(authUseCases: sl()));
  sl.registerFactory(() => MainBloc());
  sl.registerFactory(() =>
      EventBloc(homeUseCases: sl(), eventUseCases: sl(), kolUseCases: sl()));
  sl.registerFactory(() => HomeBloc(homeUseCases: sl()));
  sl.registerFactory(() => SponsorBloc(sponsorUseCases: sl()));
  sl.registerFactory(() => GiftBloc(giftUseCases: sl()));
  sl.registerFactory(() => UserBloc(userUseCases: sl()));

  // Domain layer
  sl.registerFactory(() => AuthUseCases(authRepository: sl()));
  sl.registerFactory(() => HomeUseCases(homeRepository: sl()));
  sl.registerFactory(() => EventUseCases(eventRepository: sl()));
  sl.registerFactory(() => SponsorUseCases(sponsorRepository: sl()));
  sl.registerFactory(() => KOLUseCases(kolRepository: sl()));
  sl.registerFactory(() => GiftUseCases(giftRepository: sl()));
  sl.registerFactory(() => UserUseCases(userRepository: sl()));

  // Data layer
  sl.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(authRemoteDataSource: sl()));
  sl.registerFactory<AuthRemoteDataSource>(() => AuthDataSourceImpl());

  sl.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(homeRemoteDataSource: sl()));
  sl.registerFactory<HomeRemoteDataSource>(() => HomeDataSourceImpl());

  sl.registerFactory<EventRepository>(
      () => EventRepositoryImpl(eventRemoteDataSource: sl()));
  sl.registerFactory<EventRemoteDataSource>(() => EventDataSourceImpl());

  sl.registerFactory<SponsorRepository>(
      () => SponsorRepositoryImpl(sponsorRemoteDataSource: sl()));
  sl.registerFactory<SponsorRemoteDataSource>(() => SponsorDataSourceImpl());

  sl.registerFactory<KOLRepository>(
      () => KOLRepositoryImpl(kolRemoteDataSource: sl()));
  sl.registerFactory<KOLRemoteDataSource>(() => KOLDataSourceImpl());

  sl.registerFactory<GiftRepository>(
      () => GiftRepositoryImpl(giftRemoteDataSource: sl()));
  sl.registerFactory<GiftRemoteDataSource>(() => GiftDataSourceImpl());

  sl.registerFactory<UserRepository>(
      () => UserRepositoryImpl(userRemoteDataSource: sl()));
  sl.registerFactory<UserRemoteDataSource>(() => UserDataSourceImpl());
}
