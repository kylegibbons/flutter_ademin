import 'package:flutter/foundation.dart';
import 'package:flutter_ademin/constants/values.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final userDataProvider = NotifierProvider<UserDataController, UserDataState>(
  UserDataController.new,
);

@immutable
class UserDataState {
  const UserDataState({required this.userProfileImageUrl, required this.username});

  const UserDataState.initial() : this(userProfileImageUrl: '', username: '');

  final String userProfileImageUrl;
  final String username;

  UserDataState copyWith({String? userProfileImageUrl, String? username}) {
    return UserDataState(
      userProfileImageUrl: userProfileImageUrl ?? this.userProfileImageUrl,
      username: username ?? this.username,
    );
  }
}

class UserDataController extends Notifier<UserDataState> {
  @override
  UserDataState build() {
    return const UserDataState.initial();
  }

  Future<void> loadAsync() async {
    final sharedPref = await SharedPreferences.getInstance();

    state = state.copyWith(
      username: sharedPref.getString(StorageKeys.username) ?? '',
      userProfileImageUrl:
          sharedPref.getString(StorageKeys.userProfileImageUrl) ?? '',
    );
  }

  Future<void> setUserDataAsync({
    String? userProfileImageUrl,
    String? username,
  }) async {
    final sharedPref = await SharedPreferences.getInstance();
    var nextState = state;

    if (userProfileImageUrl != null &&
        userProfileImageUrl != state.userProfileImageUrl) {
      nextState = nextState.copyWith(userProfileImageUrl: userProfileImageUrl);
      await sharedPref.setString(
        StorageKeys.userProfileImageUrl,
        userProfileImageUrl,
      );
    }

    if (username != null && username != state.username) {
      nextState = nextState.copyWith(username: username);
      await sharedPref.setString(StorageKeys.username, username);
    }

    if (nextState != state) {
      state = nextState;
    }
  }

  Future<void> clearUserDataAsync() async {
    final sharedPref = await SharedPreferences.getInstance();

    await sharedPref.remove(StorageKeys.username);
    await sharedPref.remove(StorageKeys.userProfileImageUrl);

    state = const UserDataState.initial();
  }

  bool isUserLoggedIn() {
    return state.username.isNotEmpty;
  }
}
