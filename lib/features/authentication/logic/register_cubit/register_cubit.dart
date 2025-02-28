import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/Failure.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> signIn(String email, String password) async {
    emit(RegisterLoading());
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      emit(RegisterFailure(Failure.getMessageFromErrorCode(e.code)));
    }
  }
}
