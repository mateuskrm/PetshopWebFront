import 'package:firebase_core/firebase_core.dart';

import 'package:petshop_front/firebase_options.dart';
import 'package:petshop_front/services/auth_user.dart';
import 'package:petshop_front/services/auth_provider.dart';
import 'package:petshop_front/services/auth_excepetions.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider
{
  @override
  AuthUser? get authUser {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return AuthUser.fromFirebase(user);
    }else{
      return null;
    }
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) async{
      try{
       await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       final user = authUser;
       if(user != null){
         return user;
       }else{
          throw UserNotLoggedInException();
       }
      }on FirebaseAuthException catch(e){
        if(e.code == 'user-not-found'){
          throw UserNotFoundException();
        }else if(e.code == 'wrong-password'){
          throw WrongPasswordException();
        }else{
          throw GenericAuthException();
        }
      }catch(_){
        throw GenericAuthException();
      }
  }

  @override
  Future<void> logOut() {
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      return FirebaseAuth.instance.signOut();
    }else{
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<void> sendEmailVerification() async{
    final user = FirebaseAuth.instance.currentUser;
    if(user != null){
      await user.sendEmailVerification();
    }else{ 
      throw UserNotLoggedInException();
    }
  }

  @override
  Future<AuthUser> signUp({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      final user = authUser;
      if(user != null){
       return user;
      }else{
        throw UserNotLoggedInException();
      }
    }on FirebaseAuthException catch(e){    
     if(e.code == 'email-already-in-use'){
       throw EmailAlreadyInUseException();
      }else if(e.code == 'invalid-email'){
        throw InvalidEmailException();
      }else if(e.code == 'weak-password'){
        throw WeakPasswordException();
      }else{
        throw GenericAuthException();
      }   
    }catch(_){
      throw GenericAuthException();
    }
  }
  
  @override
  Future<void> initialize() async{
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
    );
  }

}