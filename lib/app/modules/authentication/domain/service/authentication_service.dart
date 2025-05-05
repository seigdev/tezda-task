import 'package:firebase_auth/firebase_auth.dart';
import 'package:tezda_task/app/shared/shared.dart';

class AuthenticationService {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUp(
      String email, String fullName, String phone, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await addUserToDatabase(credential, email, fullName, phone);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e);
    }
    throw AppException("Oops! Try Again Later");
  }

  Future<UserCredential> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e);
    }
    throw AppException("Oops! Try Again Later");
  }

  Future<void> addUserToDatabase(
      UserCredential credential, String email, String fullName, String phone) {
    return FIRESTORE.post(
      "users",
      credential.user!.uid,
      {
        "full_name": fullName,
        "email": email,
        "phone": phone,
      },
    ).then((value) {
      showSuccessToast("Account Created Successfully.");
    }).catchError((onError) {
      showSuccessToast("Unable to Create Account.");
    });
  }

  Future signOut() async {
    await firebaseAuth.signOut();
  }
}
