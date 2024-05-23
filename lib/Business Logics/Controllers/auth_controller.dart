import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/UI/Route/route.dart';
import 'package:e_commerce/UI/Style/app_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final box = GetStorage();

  // Registration
  signUp(name, email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.uid.isNotEmpty) {
        CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
        collectionReference
            .doc(email)
            .set({
          'uid': credential.user!.uid,
          'email': email,
          'name': name
        });

        Map user = {
          'uid': credential.user!.uid,
          'email': email,
          'name': name
        };

        box.write('user', user);
        print(box.read('user'));
        Get.back();
        Get.offAndToNamed(bottomNav);
        Get.showSnackbar(AppStyles().customSnackBar('SignUp Successfully!'));
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.back();
        Get.showSnackbar(
            AppStyles().customSnackBar('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        Get.back();
        Get.showSnackbar(AppStyles()
            .customSnackBar('The account already exists for that email.'));
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().customSnackBar(e));
    }
  }

  //Log in
  login(email, password, context) async {
    AppStyles().progressDialog(context);
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (credential.user!.uid.isNotEmpty) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(email)
            .get()
            .then((DocumentSnapshot<Map<String, dynamic>> doc) {
          if (doc.exists) {
            var data = doc.data();//data er moddhe shob data chole asbe
            print(data);
            Map user = {
              'uid': data!['uid'],
              'email': data['email'],
              'name': data['name']
            };
            box.write('user', user);
            print(user);
            Get.back();
            Get.offAndToNamed(bottomNav);
            Get.showSnackbar(AppStyles().customSnackBar('Login successfully'));
          } else {
            Get.showSnackbar(AppStyles()
                .customSnackBar('Document does not exist on the database.'));
          }
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.back();
        Get.showSnackbar(
            AppStyles().customSnackBar('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        Get.back();
        Get.showSnackbar(AppStyles()
            .customSnackBar('Wrong password provided for that user.'));
      }
    }
  }

  //Forget Password
  forgetPassword(email, context) async {
    try {
      AppStyles().progressDialog(context);
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Get.back();
      Get.showSnackbar(
          AppStyles().customSnackBar('Email has been sent to $email'));
    } catch (e) {
      Get.back();
      Get.showSnackbar(AppStyles().customSnackBar('Something is wrong! Please try again.'));
    }
  }

  //Log out
  logout() async {
    _auth.signOut();
  }

  // Google Sign-In
  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      return userCredential.user;
    }
    return null;
  }

  // // Facebook Sign-In
  // Future<User?> signInWithFacebook() async {
  //   final LoginResult result = await FacebookAuth.instance.login();
  //   if (result.status == LoginStatus.success) {
  //     final AccessToken accessToken = result.accessToken!;
  //     final OAuthCredential credential = FacebookAuthProvider.credential(accessToken.token);
  //     final UserCredential userCredential = await _auth.signInWithCredential(credential);
  //     return userCredential.user;
  //   }
  //   return null;
  // }

  // Apple Sign-In

  Future<User?> signInWithApple() async {
    final AuthorizationCredentialAppleID appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final OAuthCredential credential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );
    final UserCredential userCredential = await _auth.signInWithCredential(credential);
    return userCredential.user;
  }



}
