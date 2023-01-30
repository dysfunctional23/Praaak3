import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_six_lab/main.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> onAuthUser(String name, String password) async {
    if (name == 'admin' && password == 'admin') {
      emit(AuthAdmin());
    }
    if (name == '' && password == '') {
      emit(AuthInitial());
    }
    if (name == ' ' && password == ' ') {
      emit(NeedRegistrate());
    }
    if (MyApp.users.where((element) => element.name == name).isNotEmpty) {
      emit(AuthLoaded());
    }
  }
}
