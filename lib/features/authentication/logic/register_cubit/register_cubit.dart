import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failure.dart';

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

  Future<UserCredential?> signUpWithGoogle() async {
    emit(RegisterLoading());

    try {
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      if (gUser == null) return null;
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      emit(RegisterSuccess());
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      debugPrint(Failure.getMessageFromErrorCode(e.code));
      emit(RegisterFailure(Failure.getMessageFromErrorCode(e.code)));
    }
    return null;
  }
}
