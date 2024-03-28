import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/network/network_inf.dart';
import 'features/posts/data/data_sources/local_data_source.dart';
import 'features/posts/data/data_sources/remote_data_source.dart';
import 'features/posts/data/repositories/posts_repo_impl.dart';
import 'features/posts/domain/repositories/posts_repo.dart';
import 'features/posts/domain/use_cases/add_post.dart';
import 'features/posts/domain/use_cases/delete_post.dart';
import 'features/posts/domain/use_cases/get_all_posts.dart';
import 'features/posts/domain/use_cases/update_post.dart';
import 'features/posts/prsentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/prsentation/bloc/posts/posts_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! feature posts
  /// Bloc
  sl.registerFactory(() => PostsBloc(getAllPosts: sl()));
  sl.registerFactory(
    () => AddDeleteUpdatePostBloc(
        addPost: sl(), deletePost: sl(), updatePost: sl()),
  );

  /// Use cases
  /// registerLazySingleton هيا توقم بانشاء الغرض لما احتاجه
  /// registerSingleton تقوم بانشاء الغرض عند فتح التطبيق
  sl.registerLazySingleton(() => GetAllPostUseCases(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));

  /// Reposatories
  sl.registerLazySingleton<PostRepository>(() => PostRepoImpl(
        localeDataSource: sl(),
        networkInfo: sl(),
        remoteDataSource: sl(),
      ));

  /// DataSources
  sl.registerLazySingleton<PostLocaleDataSource>(
      () => PostLocaleDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSource(client: sl()));
  //! Care
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
