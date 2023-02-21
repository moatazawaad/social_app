import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_social_app/models/social_user_model.dart';
import 'package:udemy_social_app/modules/social_register/social_register_cubit/state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      // emit(SocialRegisterSuccessState());
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      phone: phone,
      name: name,
      email: email,
      uId: uId,
      image:
          'https://img.freepik.com/free-photo/portrait-arabian-saudi-man-young-male-model-smiling-pointing_155003-23526.jpg?w=740&t=st=1667572866~exp=1667573466~hmac=672204f6c277d16abc04f896e93742b09d3611ea13de4a1868b3dc62ea36d118',
      cover:
          'https://img.freepik.com/free-photo/half-length-portrait-arabian-saudi-man-dark-blue-space-young-male-model-smiling-pointing_155003-26662.jpg?w=740&t=st=1667572679~exp=1667573279~hmac=1146e335db77b9bb27f194124972e9311a242af6c85e93987ff7f08f40b9a460',
      isEmailVerified: false,
      bio: 'write your bio ...',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    // معناها عكس قيمتها اعكس القيمه الى هى فيها
    isPassword = !isPassword;

    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterShowPasswordVisibilityState());
  }
}
