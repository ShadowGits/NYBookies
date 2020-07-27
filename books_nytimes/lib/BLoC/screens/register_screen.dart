import 'package:books_nytimes/BLoC/blocs/register/register.dart';
import 'package:books_nytimes/BLoC/models/user_repository.dart';
import 'package:books_nytimes/BLoC/utilities/constants.dart';
import 'package:books_nytimes/BLoC/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  RegisterScreen({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    heightBlockSize = displaySafeHeightBlocks(context);
    widthBlockSize = displaySafeWidthBlocks(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context) => RegisterBloc(userRepository: _userRepository),
          child: RegisterForm(),
        ),
      ),
    );
  }
}
