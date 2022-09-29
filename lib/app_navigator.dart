import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/auth_view.dart';
import 'package:todoapp/loading_view.dart';
import 'package:todoapp/todo_cubit.dart';
import 'package:todoapp/todos_view.dart';

import 'auth_cubit.dart';
import 'auth_state.dart';

class AppNavigator extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          if(state is Unauthenticated) MaterialPage(child: AuthView()),
          if(state is Authenticated)
            MaterialPage(
                child: BlocProvider(
                  create: (context) => TodoCubit(userId: state.userId)..getTodos()..observeTodo(),
                  child: TodosView(),
                )
            ),
          if(state is UnknownAuthState) MaterialPage(child: LoadingView()),
        ],
        onPopPage: (route, result) => route.didPop(result)
      );
    });

  }
}