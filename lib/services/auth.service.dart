import 'package:petshop_front/services/auth_user.dart';
import 'package:petshop_front/services/auth_provider.dart';

import 'package:petshop_front/services/firebase_auth_provider.dart';

class AuthService implements AuthProvider{
  final AuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());
  @override
  AuthUser? get authUser => provider.authUser;
  
  @override
  Future<AuthUser> logIn({required String email, required String password}) => provider.logIn(email: email, password: password);
  @override
  Future<void> logOut() => provider.logOut();
  @override
  Future<void> sendEmailVerification() => provider.sendEmailVerification();
  @override
  Future<AuthUser> signUp({required String email, required String password}) => provider.signUp(email: email, password: password);
  
  @override
  Future<void> initialize() => provider.initialize();

}