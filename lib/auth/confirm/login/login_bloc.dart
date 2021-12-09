import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_day/auth/confirm/login/login_event.dart';
import 'package:project_one_day/auth/confirm/login/login_state.dart';
import 'package:project_one_day/auth_credentials.dart';
import 'package:project_one_day/auth_cubit.dart';
import 'package:project_one_day/auth_repository.dart';
import 'package:project_one_day/form_submission_status.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // Username updated
    if (event is LoginUsernameChanged) {
      yield state.copyWith(username: event.username);

      // Password updated
    } else if (event is LoginPasswordChanged) {
      yield state.copyWith(password: event.password);

      // Form submitted
    } else if (event is LoginSubmitted) {
      yield state.copyWith(formStatus: FormSubmitting());

      try {
        final userId = await authRepo.login(
          username: state.username,
          password: state.password,
        );
        yield state.copyWith(formStatus: SubmissionSuccess());

        authCubit.launchSession(AuthCredentials(
          username: state.username,
          userId: userId,
          email: '',
          password: '',
        ));
      } catch (e) {
        yield state.copyWith(formStatus: SubmissionFailed("$e"));
      }
    }
  }
}
