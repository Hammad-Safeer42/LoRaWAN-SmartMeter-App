import 'package:flutter/material.dart';
import 'package:fyp_v101/app/api/firebsaerefrences.dart';
import 'package:fyp_v101/app/api/model/appbasismodel.dart';
import 'package:fyp_v101/app/api/model/usermodel.dart';
import 'package:fyp_v101/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthController extends GetxController {
  var rememberMe = false.obs;
  late FirebaseAuth auth;
  final _user = Rxn<User>();
  late Stream<User?> authStateChanges;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  var userdata = Rxn<UserProfile>();
  var appdata = Rxn<AppBasis>();
  var isloading = true.obs;
  @override
  void onInit() {
    initAuth();

    super.onInit();
  }

  void initAuth() async {
    auth = FirebaseAuth.instance;

    authStateChanges = auth.authStateChanges();

    authStateChanges.listen((User? user) async {
      _user.value = user;

      if (user != null) {
        isloading.value = true;

        await getData2(user.uid);
      } else {
        isloading.value = false;
        navigateToLogin();
      }
    });
  }

  Future<void> getData2(String id) async {
    await appbasic.doc('appdata').get().then((value) {
      var model = AppBasis.fromJson(value.data()!);

      appdata.value = model;
    });
    await stafFR.doc(id).get().then((customer) async {
      if (customer.data() != null) {
        var model = UserProfile.fromJson(customer.data()!);
        userdata.value = model;
        await setValue("meterid", model.meterId);
        navigateToHome();
      } else {
        // Handle the case when customer data is null
        // For example, show an error message or take appropriate action
      }
    });
  }

  Future<void> loginWithEmail(BuildContext context) async {
    try {
      await auth.signInWithEmailAndPassword(
          email: username.text, password: password.text);
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        toast("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        toast("Wrong password provided for that user.");
      } else {
        toast("No user found for that email.");
      }
    }
  }

  Future<void> signOut(BuildContext? context) async {
    try {
      if (auth.currentUser != null) {
        if (context != null) {
          showConfirmDialog(context, "Are you sure to log out now?",
              onAccept: () async {
            isloading.value = true;
            try {
              await auth.signOut();
            } catch (e) {
              toast(e.toString());
            }
          });
        }
      }
    } on FirebaseAuthException catch (e) {
      isloading.value = false;
      toast(e.toString());
    }
  }

  bool isLogedIn() {
    return auth.currentUser != null;
  }

  void navigateToHome() {
    Get.offNamed(
      Routes.HOME,
    );
  }

  void navigateToLogin() {
    Get.offNamed(Routes.AUTH);
  }
}
