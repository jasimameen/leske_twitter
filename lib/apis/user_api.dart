import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart' as model;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:twitter_clone/constants/constants.dart';
import 'package:twitter_clone/core/errors/failures.dart';
import 'package:twitter_clone/core/providers.dart';
import 'package:twitter_clone/core/type_defs.dart';
import 'package:twitter_clone/models/user_model.dart';

final userApiProvider =
    Provider((ref) => UserApi(ref.read(appwriteDatabaseProvider)));

abstract class IUserApi {
  FutureEither<void> saveUser(UserModel user);
  Future<model.Document> getUser(String uid);
  FutureEitherVoid updateUser(UserModel user);
  Future<List<model.Document>> searchUserByName(String name);
  Stream<RealtimeMessage> getLatestUserProfile();
  FutureEitherVoid followUser(UserModel user);
  FutureEitherVoid addToFollowing(UserModel user);
}

class UserApi implements IUserApi {
  final Databases _databases;

  UserApi(this._databases);

  @override
  FutureEitherVoid saveUser(UserModel user) async {
    try {
      _databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: user.uid,
        data: user.toMap(),
      );

      return right(null);
    } on AppwriteException catch (err, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: err,
          library: 'Appwrite User DB',
          context: ErrorDescription(err.message ?? 'Db exception'),
        ),
      );

      return left(Failure(err.message ?? 'Something went wrong', stackTrace));
    }
  }

  @override
  Future<model.Document> getUser(String uid) async {
    return _databases.getDocument(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollectionId,
      documentId: uid,
    );
  }

  @override
  FutureEitherVoid updateUser(UserModel user) async {
    try {
      _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: user.uid,
        data: user.toMap(),
      );

      return right(null);
    } on AppwriteException catch (err, stackTrace) {
      FlutterError.reportError(
        FlutterErrorDetails(
          exception: err,
          library: 'Appwrite User DB',
          context: ErrorDescription(err.message ?? 'Db exception'),
        ),
      );

      return left(Failure(err.message ?? 'Something went wrong', stackTrace));
    }
  }

  @override
  Future<List<model.Document>> searchUserByName(String name) async {
    final res = await _databases.listDocuments(
      databaseId: AppwriteConstants.databaseId,
      collectionId: AppwriteConstants.userCollectionId,
      queries: [
        Query.search('name', name),
      ],
    );

    return res.documents;
  }

  @override
  FutureEitherVoid addToFollowing(UserModel user) async {
    try {
      await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: user.uid,
        data: {
          'following': user.following,
        },
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  FutureEitherVoid followUser(UserModel user) async {
    try {
      await _databases.updateDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.userCollectionId,
        documentId: user.uid,
        data: {
          'followers': user.followers,
        },
      );
      return right(null);
    } on AppwriteException catch (e, st) {
      return left(
        Failure(
          e.message ?? 'Some unexpected error occurred',
          st,
        ),
      );
    } catch (e, st) {
      return left(Failure(e.toString(), st));
    }
  }

  @override
  Stream<RealtimeMessage> getLatestUserProfile() {
    return const Stream.empty();
  }
}
