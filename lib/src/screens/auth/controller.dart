import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:the_barber/src/common/base/loading_widget.dart';
import 'package:the_barber/src/common/entities/entities.dart';
import 'package:the_barber/src/common/firebase/firebase_reference.dart';
import 'package:the_barber/src/common/routes/names.dart';
import 'package:the_barber/src/common/store/user.dart';
import 'package:the_barber/src/common/utils/utils.dart';
import 'package:the_barber/src/common/widgets/widget.dart';
import 'package:the_barber/src/screens/auth/index.dart';

import '../../common/services/services.dart';

class AuthController extends GetxController {
  final state = AuthState();
  AuthController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'openid',
      // 'email',
      // 'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  onPressed() {
    Get.showOverlay(
        loadingWidget: const Loading(isContainer: true),
        asyncFunction: () {
          return handleGoogleSignIn();
        });
  }

  handleGoogleSignIn() async {
    try {
      var user = await _googleSignIn.signIn();
      if (user != null) {
        //* ---- Get User Google Authentication
        final googleAuth = await user.authentication;
        //* ---- Get User Credentials of Google
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );
        //* ---- SignIn with Credentials
        await auth.signInWithCredential(credential);

        //= ---- Storing User Data
        String displayName = user.displayName ?? user.email;
        String id = user.id;
        String email = user.email;
        String photoUrl = user.photoUrl ?? '';
        UserLoginResponseEntity userProfile = UserLoginResponseEntity();
        userProfile.displayName = displayName;
        userProfile.accessToken = id;
        userProfile.email = email;
        userProfile.photoUrl = photoUrl;

        //* --- Store UserProfile in Local Storage ----
        UserStore.to.saveProfile(userProfile);

        //* --- Check if user firebase is exist or not ----
        var userBase = await userRF
            .withConverter(
                fromFirestore: UserData.fromFirestore,
                toFirestore: (UserData userData, options) =>
                    userData.toFirestore())
            .where("id", isEqualTo: id)
            .get();

        //* --- If not exist ----
        if (userBase.docs.isEmpty) {
          final data = UserData(
            id: id,
            name: displayName,
            email: email,
            photourl: photoUrl,
            location: '',
            fcmtoken: '',
            addtime: Timestamp.now(),
            completeProfile: false,
            phoneNumber: '',
          );

          //* --- Add data in collection ----
          await userRF
              .withConverter(
                  fromFirestore: UserData.fromFirestore,
                  toFirestore: (UserData userData, options) =>
                      userData.toFirestore())
              .add(data);
        }

        toastInfo(msg: "Login Success");
        await StorageServices.to.setBool(LOGIN_STATE, true);
        //Get.to(() => const Homescreen());
        Get.offAllNamed(AppRoutes.HOME);
      }
    } catch (e) {
      toastInfo(msg: "Error", backgroundColor: Colors.red);
    }
  }

  //* ------------------ SignOut ------------------

  signOut() async {
    try {
      await _googleSignIn.signOut();
      toastInfo(msg: "Logout Success");
      await StorageServices.to.setBool(LOGIN_STATE, false);
      //Get.offAllNamed(AppRoutes.SIGNIN);
    } catch (e) {
      toastInfo(msg: "Error", backgroundColor: Colors.red);
    }
  }
}
