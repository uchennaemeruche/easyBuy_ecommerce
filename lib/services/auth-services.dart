import 'package:e_commerce_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  MyUser _userFromFirebaseUser(User user) {
    return user != null
        ? MyUser(
            email: user.email,
            uid: user.uid,
            name: user.displayName,
            password: '',
          )
        : null;
  }

  Stream<MyUser> get user {
    return firebaseAuth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future<MyUser> signInWithGoogle() async {
    try {
      print("Starting...");
      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the user from the UserCredential
      final User user =
          (await firebaseAuth.signInWithCredential(credential)).user;
      print("Done");
      print("User: $user");
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      print(e.message);
      return null;
    }

    // return user;
  }

  Future<MyUser> signInWithEmailAndPassword(email, password) async {
    try {
      print("SIgn in in...");
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      print(userCredential);
      if (userCredential != null) {
        print("User found");
      } else {
        print("Not found");
      }
      print("Done");
      return _userFromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print(e.code);
      }
      return null;
    }
  }

  Future signOut() async {
    try {
      return await firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // User user = FirebaseAuth.instance.currentUser;

  // var actionCodeSettings = ActionCodeSettings(
  //     url: 'https://www.example.com/?email=${user.email}',
  //     dynamicLinkDomain: "example.page.link",
  //     androidPackageName: "com.asktech.e_commerce_app",
  //     androidInstallApp: true,
  //     androidMinimumVersion: "12",
  //     iOSBundleId: "com.asktech.eCommerceApp",
  //     handleCodeInApp: true);

  Future signupWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      print("Creating account...");
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user.updateProfile(displayName: name);

      await userCredential.user.sendEmailVerification(ActionCodeSettings(
          url: 'hhttps://easybuystore.page.link/?email=$email',
          dynamicLinkDomain: "easybuystore.page.link",
          androidPackageName: "com.asktech.e_commerce_app",
          androidInstallApp: true,
          androidMinimumVersion: "21",
          iOSBundleId: "com.asktech.eCommerceApp",
          handleCodeInApp: true));
      print("User credential");
      print("userCredential Email: ${userCredential.user.email}");
      print("EMail: $email");
      print("NAME: $name");

      User user = userCredential.user;
      print(_userFromFirebaseUser(user));
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
  }
}
