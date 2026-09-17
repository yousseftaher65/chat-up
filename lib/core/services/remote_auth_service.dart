import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:chat_up/features/auth/shared/data/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

abstract class RemoteAuthService {
  Future<UserModel> login({required String email, required String password});
  Future<UserModel> loginWithGoogle();
  Future<UserModel> signup({
    required String email,
    required String password,
    required String fullname,
  });

  Future<void> logout();
}

@Injectable(as: RemoteAuthService)
class RemoteAuthServiceImpl implements RemoteAuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  RemoteAuthServiceImpl({
    required firebase_auth.FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  }) : _firebaseAuth = firebaseAuth,
       _googleSignIn = googleSignIn;

  @override
  Future<UserModel> loginWithGoogle() async {
    try {
      final googleSignInAccount = await _googleSignIn.authenticate();
      final googleAuth = googleSignInAccount.authentication;
      final idToken = googleAuth.idToken;

      if (idToken == null) throw Exception('ID token is null');

      final credential = firebase_auth.GoogleAuthProvider.credential(
        idToken: idToken,
      );

      final firebaseUser = await _firebaseAuth.signInWithCredential(credential);
      final loggedInUser = firebaseUser.user;

      if (loggedInUser == null) throw Exception('User not found');

      final userAdapter = FirebaseAuthUserAdapter();

      return userAdapter.adapt(loggedInUser);
    } on Exception catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final firebase = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (firebase.user == null) throw Exception('User not found');

    final userAdapter = FirebaseAuthUserAdapter();

    return userAdapter.adapt(firebase.user!);
  }

  @override
  Future<void> logout() {
    return _firebaseAuth.signOut();
  }

  @override
  Future<UserModel> signup({
    required String email,
    required String password,
    required String fullname,
  }) async {
    final firebaseUser = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await firebaseUser.user?.updateDisplayName(fullname);
    await firebaseUser.user?.reload();

    if (firebaseUser.user == null) throw Exception('Invalid Credentials');

    final userAdapter = FirebaseAuthUserAdapter();

    return userAdapter.adapt(_firebaseAuth.currentUser!);
  }
}

class FirebaseAuthUserAdapter {
  UserModel adapt(firebase_auth.User user) {
    return UserModel(
      email: user.email ?? '',
      fullname: user.displayName ?? '',
      id: user.uid,
    );
  }
}
