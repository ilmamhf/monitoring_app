import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthService {
  
}


loginCheck() {
    if (FirebaseAuth.instance.currentUser != null) {
      // FirebaseAuth.instance.currentUser!.email;
      return true;
    } else {
      return false;
    }
  }

