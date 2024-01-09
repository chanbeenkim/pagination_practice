import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:pagination_practice/repositories/user_repository.dart';

import '../user/user.dart';

class UserController extends GetxController {
  final UserRepository _userRepository = UserRepository();
  int page = 1;
  final int limit = 80;
  var hasMore = true.obs;
  var users = <User>[].obs;

  Future getUser() async {
    try {
      List<User> response = await _userRepository.fetchUsers();
      if (response.length < limit) {
        hasMore.value = false;
      }
      users.addAll(response);
      page++;
    } catch (e) {
      if (kDebugMode) print(e.toString());
    }
  }

  Future refreshData() async {
    page = 1;
    hasMore.value = true;
    users.value = [];
    await getUser();
  }
}
