import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/core/errors/failures.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/type_defs.dart';

final authApiProvider = Provider((ref) {
  final account = ref.watch(appwriteAccoundProvider);
  return AuthApiImpl(account);
});

abstract class IAuthAPI {
  /// get current userdata from db
  Future<model.Account?> currentUser();

  FutureEither<model.Account> signUp({
    required String email,
    required String password,
  });

  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  });

  FutureEitherVoid signOut();
}

// Accound is used for AuthServices
// model.Account is For Accound
class AuthApiImpl implements IAuthAPI {
  final Account _account;

  /// pass Accound Service as Parameter
  AuthApiImpl(this._account);

  @override
  Future<model.Account?> currentUser() async {
    try {
      // Get currently logged in user data as JSON object.
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<model.Account> signUp(
      {required String email, required String password}) async {
    try {
      final userAccount = await _account.create(
        userId: ID.unique(), // autogenerate id inside appwrite
        email: email,
        password: password,
      );

      return right(userAccount);
    } on AppwriteException catch (err, stackTrace) {
      return left(
        Failure(err.message ?? 'something went wrong', stackTrace),
      );
    } catch (err, stackTrace) {
      return left(
        Failure(err.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEither<model.Session> signIn(
      {required String email, required String password}) async {
    try {
      final session =
          await _account.createEmailSession(email: email, password: password);
      return right(session);
    } on AppwriteException catch (err, stackTrace) {
      return left(
        Failure(err.message ?? 'something went wrong', stackTrace),
      );
    } catch (err, stackTrace) {
      return left(
        Failure(err.toString(), stackTrace),
      );
    }
  }

  @override
  FutureEitherVoid signOut() async {
    try {
      /// delete current session
      await _account.deleteSession(sessionId: 'current');
      return right(null);
    } on AppwriteException catch (e, stackTrace) {
      return left(
        Failure(e.message ?? 'Some unexpected error occurred', stackTrace),
      );
    } catch (e, stackTrace) {
      return left(
        Failure(e.toString(), stackTrace),
      );
    }
  }
}
