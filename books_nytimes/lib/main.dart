import 'package:books_nytimes/BLoC/blocs/authentication/authentication_bloc.dart';
import 'package:books_nytimes/BLoC/models/user_repository.dart';
import 'package:books_nytimes/BLoC/utilities/simple_bloc_observer.dart';
import 'package:books_nytimes/MVVM/screens/book_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'BLoC/screens/login_screen.dart';
import 'MVVM/viewmodels/book_list_view_model.dart';
//
//void main() {
//  runApp(MyApp());
//}
//
//class MyApp extends StatelessWidget {
//  // This widget is the root of your application.
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      title: 'Flutter Demo',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//        visualDensity: VisualDensity.adaptivePlatformDensity,
//      ),
//      home: MyHomePage(),
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MultiProvider(
//      providers: [
////        ChangeNotifierProvider(
////          create: (_) => BookTypeListViewModel(),
////        ),
//        ChangeNotifierProvider(
//          create: (_) => BookListViewModel(),
//        )
//      ],
//      child: BookListScreen(),
//    );
//  }
//}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookListViewModel(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
            userRepository: userRepository,
          )..add(AuthenticationStarted()),
        ),
      ],
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationFailure) {
            return LoginScreen(userRepository: _userRepository);
          }
          if (state is AuthenticationSuccess) {
            return BookListScreen(
              user: state.user,
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
