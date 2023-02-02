import 'package:appwrite/models.dart' as model;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitter_clone/apis/auth_api.dart';
import 'package:twitter_clone/apis/user_api.dart';
import 'package:twitter_clone/core/utils/messengers/messenger.dart';
import 'package:twitter_clone/core/utils/navigation/navigation.dart';
import 'package:twitter_clone/features/auth/view/login_view.dart';
import 'package:twitter_clone/features/auth/view/signup_view.dart';
import 'package:twitter_clone/features/home/view/home_view.dart';
import 'package:twitter_clone/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, bool>((ref) {
  final authApi = ref.watch(authApiProvider);
  final userApi = ref.watch(userApiProvider);
  return AuthController(authApi, userApi);
});

final currentUserAccoundProvider = FutureProvider(
  (ref) => ref.watch(authControllerProvider.notifier).currentUser(),
);

final userDetailsProvider = FutureProvider.family(
  (ref, String uid) => ref.watch(authControllerProvider.notifier).getUserData(uid),
);

final currentUserDetailsProvider = FutureProvider((ref) {
    final currentUserId = ref.watch(currentUserAccoundProvider).value!.$id;
    final userDetails = ref.watch(userDetailsProvider(currentUserId));
    return userDetails.value;
},);

class AuthController extends StateNotifier<bool> {
  final IAuthAPI _authAPI;
  final IUserApi _userApi;
  AuthController(this._authAPI, this._userApi) : super(false);

  // get current user
  Future<model.Account?> currentUser() => _authAPI.currentUser();

  void signUp({
    required String email,
    required String password,
  }) async {
    state = true; // isLoading = true

    final res = await _authAPI.signUp(email: email, password: password);

    state = false; // stop loading state

    res.fold(
      (failure) => Messanger.showSnackBar(failure.message),
      (account) {
        final user = UserModel(
          uid: account.$id,
          email: email,
          name: email.split('@').first,
          followers: const [],
          following: const [],
          profilePic: '',
          bannerPic: '',
          bio: '',
          isVerified: false,
        );
        _userApi.saveUser(user);

        Messanger.showSnackBar('User Created Succesfully, Login to continue');
        Navigation.route
            .pushNamedAndRemoveUntil(LoginView.routeName, (route) => true);
      },
    );
  }

  void signIn({
    required String email,
    required String password,
  }) async {
    state = true; // loading state

    final res = await _authAPI.signIn(email: email, password: password);

    state = false; // stop loading

    res.fold(
      (failure) => Messanger.showSnackBar(failure.message),
      (succes) {
        Messanger.showSnackBar('signIn success');
        Navigation.route
            .pushNamedAndRemoveUntil(HomeView.routeName, (route) => true);
      },
    );
  }

  Future<UserModel> getUserData(String uid) async {
    final document = await _userApi.getUser(uid);
    final updatedUser = UserModel.fromMap(document.data);
    return updatedUser;
  }

  void logout() async {
    final res = await _authAPI.signOut();
    res.fold((l) => null, (r) {
      Navigation.route.restorablePushNamedAndRemoveUntil(
        SignUpView.routeName,
        (route) => false,
      );
    });
  }
}
