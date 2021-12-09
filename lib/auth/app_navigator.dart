import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_one_day/auth/session_cubit.dart';
import 'package:project_one_day/auth/session_state.dart';
import 'package:project_one_day/auth/session_view.dart';
import 'package:project_one_day/auth_cubit.dart';
import 'package:project_one_day/auth_navigator.dart';

import 'loading_view.dart';

class AppNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState) MaterialPage(child: LoadingView()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context)  =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: AuthNavigator(),
              ),
            ),
  
          // Show session flow
          if (state is Authenticated) MaterialPage(child: SessionView())
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
