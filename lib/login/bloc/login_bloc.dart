import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:GTNexpress/bloc/authentication_bloc.dart';
import 'package:GTNexpress/user_repository.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      // yield LoginLoading();
      yield LoginLoading();
      try {
        final user = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
        // yield LoginLoading();
      } catch (error) {
        yield LoginFaliure(error: "Tên tài khoản hoặc mật khẩu sai!");
      }
    }
  }
}
