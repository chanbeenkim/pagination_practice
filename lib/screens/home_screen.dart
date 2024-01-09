import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pagination_practice/controllers/user_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController state = Get.put(UserController());
    final ScrollController scrollController = ScrollController();
    state.getUser();

    Future onRefresh() async {
      state.refreshData();
    }

    void onScroll() {
      double maxScroll = scrollController.position.maxScrollExtent;
      double currentScroll = scrollController.position.pixels;

      if (maxScroll == currentScroll && state.hasMore.value) {
        state.getUser();
      }
    }

    scrollController.addListener(onScroll);

    return Scaffold(
      appBar: AppBar(
        title: const Text("PagiNation"),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: onRefresh,
        child: Obx(
          () => ListView.builder(
            controller: scrollController,
            itemCount: state.hasMore.value
                ? state.users.length + 1
                : state.users.length,
            itemBuilder: (context, index) {
              if (index < state.users.length) {
                return ListTile(
                  shape: const Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(state.users[index].avatar ?? ""),
                  ),
                  title: Text(state.users[index].name ?? ""),
                  subtitle: Text(state.users[index].email ?? ""),
                );
              } else {
                return const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
