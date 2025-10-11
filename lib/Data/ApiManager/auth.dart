import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizara/Data/Models/user_model.dart';

class AuthService{

  Future<UserModel> signUp(String email,String password, String role) async{
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      UserModel newUser = UserModel(email: email, uid: result.user!.uid, role: role);

      await FirebaseFirestore.instance.collection("users").doc(newUser.uid).set(newUser.toMap());
      return newUser;
    }
    catch(e){
      print(e);
      return UserModel(email: "", uid: "", role: "");
    }
  }

  Future<UserModel> signIn(String email,String password) async{
    try{
      UserCredential result = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(result.user!.uid).get();
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    }catch(e){
      print(e);
      return UserModel(email: "", uid: "", role: "");
    }
  }


  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }


}