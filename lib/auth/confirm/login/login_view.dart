// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_day/auth/confirm/login/login_bloc.dart';
import 'package:project_one_day/auth/confirm/login/login_event.dart';
import 'package:project_one_day/auth/confirm/login/login_state.dart';
import 'package:project_one_day/auth_cubit.dart';
import 'package:project_one_day/auth_repository.dart';
import 'package:project_one_day/form_submission_status.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _textcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String error = "";
  final _auth = FirebaseAuth.instance;
  bool _ishidden = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _loginForm(),
            SizedBox(height: 20),
            _showSignUpButton(context),
          ],
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _usernameField(),
                _passwordField(),
                SizedBox(
                  height: 20,
                ),
                Text(error, style: TextStyle(color: Colors.red)),
                _loginButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextFormField(
          controller: _textcontroller,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Email',
          ),
          validator: (value) {
            if (state.username.isEmpty ||
                state.username.length <= 3 ||
                !state.username.contains('@')) {
              return "*Required a valid emailid";
            }
            return null;
          },
          onChanged: (value) {
            _email = value;
            context.read<LoginBloc>().add(
                  LoginUsernameChanged(username: value),
                );
          });
    });
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      void toggleSwitchView() {
    setState(() {
      _ishidden = !_ishidden;
    });
  }
      return TextFormField(
        obscureText: _ishidden,
        decoration: InputDecoration(
          icon: Icon(Icons.lock),
          hintText: 'Password',
          suffixIcon: InkWell(
            onTap: toggleSwitchView,
            child: Icon(
              _ishidden ? Icons.visibility_off : Icons.visibility,
            ),
          ),
        ),
        validator: (value) {
          if (state.password.isEmpty) {
            return "*Required a valid password";
          }
          if (state.password.length < 5) {
            return "*Password is too small";
          }
        },
        onChanged: (value) {
          _password = value;
          context.read<LoginBloc>().add(
                LoginPasswordChanged(password: value),
              );
        },
      );
    });
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  try {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        email: _email, password: _password);
                    if (result != null) {
                      context.read<LoginBloc>().add(LoginSubmitted());
                    }
                  } catch (e) {
                    setState(() {
                      error = "could not sign in using these credentials.";
                    });
                  }
                }
              },
              child: Text('Login'),
            );
    });
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text('Don\'t have an account? Sign up.'),
        onPressed: () => context.read<AuthCubit>().showSignUp(),
      ),
    );
  }

  

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
