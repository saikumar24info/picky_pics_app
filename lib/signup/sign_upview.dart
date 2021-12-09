// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_day/auth_cubit.dart';
import 'package:project_one_day/auth_repository.dart';
import 'package:project_one_day/form_submission_status.dart';
import 'package:project_one_day/signup/sign_up_bloc.dart';
import 'package:project_one_day/signup/sign_up_event.dart';
import 'package:project_one_day/signup/sign_up_state.dart';
class SignUpView extends StatefulWidget {
  const SignUpView({ Key? key }) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  var _email = '';
  var _password = "";
  var _username = '';
  bool _ishidden = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            _signUpForm(),
            _showLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
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
                _emailField(),
                _passwordField(),
                SizedBox(
                  height: 20,
                ),
                _signUpButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            icon: Icon(Icons.person),
            hintText: 'Username',
          ),
          validator: (value) {
            if (state.username.isEmpty ||
                state.username.length <= 3 ||
                state.username.contains('#') ||
                state.username.contains('@') ||
                state.username.contains('%') ||
                state.username.contains('&') ||
                state.username.contains('^') ||
                state.username.contains('*') ||
                state.username.contains('?') ||
                state.username.contains('!') ||
                state.username.contains(RegExp(r'[0-9]'))) {
              return "*Required valid username";
            }
            return null;
          },
          onChanged: (value) {
            _username = value;
            context.read<SignUpBloc>().add(
                  SignUpUsernameChanged(username: value),
                );
          });
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
          decoration: InputDecoration(
            icon: Icon(Icons.mail),
            hintText: 'Email',
          ),
          validator: (value) => state.isValidEmail ? null : '*Invalid email',
          onChanged: (value) {
            _email = value;
            context.read<SignUpBloc>().add(
                  SignUpEmailChanged(email: value),
                );
          });
    });
  }

  Widget _passwordField() {
   
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      void toggleSwitch(){
     setState((){
         _ishidden=!_ishidden;
     });
   }
      return TextFormField(
          obscureText: _ishidden,
          decoration: InputDecoration(
            icon: Icon(Icons.lock),
            hintText: 'Password',
            suffix: InkWell(
                onTap: toggleSwitch,
                child: Icon(
                   _ishidden ? Icons.visibility_off : Icons.visibility)),
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
            context.read<SignUpBloc>().add(
                  SignUpPasswordChanged(password: value),
                );
          });
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _auth.createUserWithEmailAndPassword(
                      email: _email, password: _password);
                  FirebaseFirestore.instance
                      .collection("details")
                      .add({"username": _username, "emailid": _email});
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: Text('Sign Up'),
            );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: Text('Already have an account? Sign in.'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

 
  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
