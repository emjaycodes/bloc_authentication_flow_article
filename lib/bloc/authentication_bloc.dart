
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../models/user.dart';
import '../services/authentication.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';


final AuthService authService = AuthService();

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitialState()) {
    on<AuthenticationEvent>((event, emit) {});

    on<SignUpUser>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
          final UserModel? user =
          await authService.signUpUser(event.email, event.password);
      if (user != null) {
        emit(AuthenticationSuccessState(user));
        
      } else {
        emit(const AuthenticationFailureState('create user failed'));
        print(state.toString());
        print('error');
      }
      } catch (e) {
        print(e.toString());
      }
     emit(AuthenticationLoadingState(isLoading: false));
    });

     on<SignOut>((event, emit) async {
      emit(AuthenticationLoadingState(isLoading: true));
      try {
        authService.signOutUser();
      } catch (e) {
        print('error');
        print(e.toString());
      } 
       emit(AuthenticationLoadingState(isLoading: false));
     });
}
}
