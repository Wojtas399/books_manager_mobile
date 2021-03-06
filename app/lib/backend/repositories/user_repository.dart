import 'package:app/backend/services/avatar_service.dart';
import 'package:app/backend/services/user_service.dart';
import 'package:app/interfaces/avatar_interface.dart';
import 'package:app/interfaces/user_interface.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository extends UserInterface {
  late final UserService _userService;
  late final AvatarService _avatarService;

  UserRepository({
    required UserService userService,
    required AvatarService avatarService,
  }) {
    _userService = userService;
    _avatarService = avatarService;
  }

  @override
  Stream<DocumentSnapshot>? subscribeUserData() {
    return _userService.subscribeUserData();
  }

  @override
  String? getEmail() {
    return _userService.getEmail();
  }

  @override
  Future<String> getAvatarUrl({required String avatarPath}) async {
    try {
      return await _userService.getAvatarUrl(avatarPath: avatarPath);
    } catch (error) {
      throw error;
    }
  }

  @override
  changeAvatar({required AvatarInterface avatar}) async {
    try {
      AvatarType? avatarType = _avatarService.getAvatarType(avatar);
      if (avatarType != null) {
        await _userService.changeAvatar(
          type: avatarType,
          avatarImgPath: _avatarService.getImgFilePath(avatar),
        );
      }
    } catch (error) {
      throw error;
    }
  }

  @override
  changeUsername({required String newUsername}) async {
    try {
      await _userService.changeUsername(newUsername: newUsername);
    } catch (error) {
      throw error;
    }
  }

  @override
  changeEmail({
    required String newEmail,
    required String password,
  }) async {
    try {
      await _userService.changeEmail(newEmail: newEmail, password: password);
    } catch (error) {
      throw error;
    }
  }

  @override
  changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _userService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (error) {
      throw error;
    }
  }
}
