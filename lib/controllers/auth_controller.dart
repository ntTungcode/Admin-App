import 'package:emart_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class AuthController extends GetxController{
  var isloading = false.obs;

  //Text Controllers
  var emailController = TextEditingController();
  var passwordController =  TextEditingController();

  //Login method
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);
      currentUser = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  //signout method
  signoutMethod(context) async{
    try {
      await auth.signOut();
    }catch (e) {
      VxToast.show(context,msg: e.toString());
    }
  }
}