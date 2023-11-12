import 'package:fairdraft/requests/user_requests.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/my_friend_Model.dart';

class MyFriendsPageController extends GetxController{

  RxBool isLoading = false.obs;
  List<Friend> friends = [];
  RefreshController refreshController = RefreshController();
  int page = 1;

  //
  getFriends({bool isRefresh = true}) async {

    if(isRefresh){
      page = 1;
      isLoading.value = true;
      friends.clear();
    }else{
      page = page+1;
    }
    try{
      var result = await UserRequests().getFriendsRequest(page: page);
      if(result is List<Friend>){
        friends.addAll(result);
      }
      throw result;
    }catch(e){
      print(e);
    }
    refreshController.refreshCompleted();
    refreshController.loadComplete();
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    getFriends();
  }
}