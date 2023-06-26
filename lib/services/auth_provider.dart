import 'package:petshop_front/services/auth_user.dart';

abstract class AuthProvider
{
  AuthUser? get authUser;
  Future<void> initialize();
  Future<AuthUser> logIn({required String email, required String password});
  Future<AuthUser> signUp({required String email, required String password});
  Future<void> logOut();
  Future<void> sendEmailVerification();
}