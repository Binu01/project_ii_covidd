import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class firebaseServices{

  final auth = FirebaseAuth.instance;
  final  GoogleSignIn _googleSignIn= GoogleSignIn();

  sigInWithGoogle()async{

    try{
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if(googleSignInAccount != null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await auth.signInWithCredential(authCredential);
      }

    }on FirebaseAuthException  catch(e){
      print(e.message);
      throw e;

    }
  }

  signOut()async{
    await auth.signOut();
    await _googleSignIn.signOut();

  }


}