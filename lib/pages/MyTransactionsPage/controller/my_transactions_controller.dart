import 'package:fairdraft/requests/user_requests.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../models/transaction_model.dart';

class MyTransactionsController extends GetxController{

  RxBool isLoading = false.obs;
  List<Transaction> transactions = [];
  RefreshController refreshController = RefreshController();
  int page = 1;

  //
  getTransactions({bool isRefresh = true}) async {

    if(isRefresh){
      page = 1;
      transactions.clear();
      isLoading.value = true;
    }else{
      page = page+1;
    }
    try{
      var result = await UserRequests().transactionsRequest(page: page);
      if(result is List<Transaction>){
        transactions.addAll(result);
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
    getTransactions();
  }
}