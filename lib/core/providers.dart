import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/constants/appwrite_constants.dart';

final appwriteClientProvider = Provider((ref) {
  final client = Client(endPoint: AppwriteConstants.endpoint, selfSigned: true)
      .setProject(AppwriteConstants.projectId);
  return client;
});

final appwriteAccoundProvider = Provider((ref) {
  final client = ref.read(appwriteClientProvider);
  return Account(client);
});

final appwriteDatabaseProvider = Provider((ref) {
  final client = ref.read(appwriteClientProvider);
  return Databases(client);
});
