class AppwriteConstants {
  static const projectId = 'leske-twitter';
  static const databaseId = '63d3b5ce98f42965356c';
  static const endpoint = 'http://192.168.182.79:80/v1/';

  static const userCollectionId = 'user-collection';
  static const String tweetsCollection = 'tweet-collection';
  static const String notificationsCollection = 'notifications-collection';

  static const String imagesBucket = 'image-bucket';

  static getImagePath(String imageId) =>
      '$endpoint/storage/buckets/$imagesBucket/files/$imageId/view?project=$projectId&mode=admin';
}
