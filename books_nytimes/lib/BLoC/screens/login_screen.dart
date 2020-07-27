import 'package:books_nytimes/BLoC/blocs/login/login.dart';
import 'package:books_nytimes/BLoC/models/user_repository.dart';
import 'package:books_nytimes/BLoC/utilities/constants.dart';
import 'package:books_nytimes/MVVM/utils/size_config.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final UserRepository _userRepository;

  LoginScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    heightBlockSize = displaySafeHeightBlocks(context);
    widthBlockSize = displaySafeWidthBlocks(context);
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
      ),
    );
  }
}
