import 'package:fairdraft/pages/MyFriendsPage/controller/my_friends_page_controller.dart';
import 'package:fairdraft/widgets/statewidgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';
import '../../widgets/custom_appbar.dart';
import 'package:intl/intl.dart' as intl;
import '../../widgets/custom_listview.dart';

class MyFriendsPage extends StatelessWidget {
  MyFriendsPage({Key? key}) : super(key: key);

  MyFriendsPageController vc = Get.put(MyFriendsPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "My Friends"),
      body: Obx(() {
        return vc.isLoading.value
            ? Center(
                child: SpinKitPouringHourGlassRefined(
                  color: AppColor().primaryColor,
                  strokeWidth: 1,
                ),
              )
            : vc.friends.isNotEmpty
                ? SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: vc.refreshController,
                    onRefresh: () {
                      vc.getFriends();
                    },
                    onLoading: () {
                      vc.getFriends(isRefresh: false);
                    },
                    child: CustomListView(
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var friend = vc.friends[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 2,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 13.h,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        friend.locked == 1
                                            ? Icon(Icons.lock,
                                                color: AppColor().primaryColor,size: 40,)
                                            : Icon(Icons.lock_open,
                                                color: AppColor().primaryColor,size: 40,),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(friend.name ?? ""),
                                                  Text("("+formatMobile(friend.mobile!)+")"),
                                                ],
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                  formatDate(friend.createdAt!))
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: vc.friends.length),
                  )
                : Center(
                    child: EmptyState(
                      stateImage: const Image(image: AssetImage('assets/empty.png'),),
                      stateMessage: "No friends yet",
                  ));
      }),
    );
  }

  String formatDate(String date) {
    var day = DateTime.parse(date).day.toString();
    var month = intl.DateFormat("MMM").format(DateTime.parse(date));
    var year = DateTime.parse(date).year.toString();
    return day + " " + month + " " + year;
  }

  String formatMobile(String mobile) {
    String maskedMobile = mobile.replaceRange(2, mobile.length - 4, 'xxxx');
    return maskedMobile;
  }
}
