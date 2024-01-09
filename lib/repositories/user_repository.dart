import '../user/user.dart';
import 'package:get/get.dart';

class UserRepository extends GetConnect {
  final String _baseUrl =
      "https://659cfc1d633f9aee79085721.mockapi.io/api/v1/pagination";

  Future<List<User>> fetchUsers() async {
    final response = await get(_baseUrl);

    final data = response.body;
    return List<User>.from(data.map((e) => User.fromJson(e)));
  }
}
