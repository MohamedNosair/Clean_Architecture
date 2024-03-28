import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/appTheme.dart';
import 'features/posts/prsentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'features/posts/prsentation/bloc/posts/posts_bloc.dart';
import 'features/posts/prsentation/page/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
          BlocProvider(create: (context) => di.sl<AddDeleteUpdatePostBloc>()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: appTheme,
          home: const PostsPage(),
        ));
  }
}
