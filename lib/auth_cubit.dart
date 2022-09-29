import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/auth_repository.dart';
import 'package:todoapp/auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final authRepo = AuthRepository();

  AuthCubit() : super(UnknownAuthState());

  void signIn() async {
    try{
      final userId = await authRepo.webSignIn();
      if (userId != null && userId.isNotEmpty) {
        emit(Authenticated(userId: userId));
      }else {
        emit(Unauthenticated());
      }
    }on Exception{
      emit(Unauthenticated());
    }
  }
  void signOut() async {
    try{
      await authRepo.signOut();
      emit(Unauthenticated());
    }on Exception{
      emit(Unauthenticated());
    }

  }

  void attemptAutoSignIn() async {
    try{
      final userId = await authRepo.webSignIn();
      if (userId != null && userId.isNotEmpty) {
        emit(Authenticated(userId: userId));
      }else {
        emit(Unauthenticated());
      }
    }on Exception{
      emit(Unauthenticated());
    }

  }
}