import 'package:fairdraft/pages/MyTransactionsPage/controller/my_transactions_controller.dart';
import 'package:fairdraft/widgets/custom_appbar.dart';
import 'package:fairdraft/widgets/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import '../../constants/app_colors.dart';

class MyTransactionsPage extends StatelessWidget {
  MyTransactionsPage({super.key});

  MyTransactionsController vc = Get.put(MyTransactionsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Points"),
      body: Obx(() {
        return !vc.isLoading.value
            ? SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              controller: vc.refreshController,
              onRefresh: () {
                vc.getTransactions();
              },
              onLoading: () {
                vc.getTransactions(isRefresh: false);
              },
              child: CustomListView(
                physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var transaction = vc.transactions[index];
                    bool amountIsNegative = (transaction.amount as num).isNegative;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 13.h,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [

                                  Expanded(
                                      flex: 1,
                                      child: Column(
                                        children: [
                                          transaction.locked == 1
                                              ? Icon(Icons.lock,
                                            color:
                                            AppColor().primaryColor,size: 30,)
                                              : Icon(Icons.lock_open,
                                              color:
                                              AppColor().primaryColor,size: 30),
                                          const SizedBox(height: 5),
                                          Center(
                                            child: Text(
                                              transaction.amount.toString(),
                                              style: TextStyle(fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                color: amountIsNegative?Colors.red:Colors.green
                                              ),),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(transaction.message!,maxLines: 2,overflow: TextOverflow.ellipsis),
                                        const SizedBox(height: 10),
                                        Text(formatDate(
                                            transaction.updatedAt!))
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
                  itemCount: vc.transactions.length),
            )
            : Center(
                child: SpinKitPouringHourGlassRefined(
                  color: AppColor().primaryColor,
                  strokeWidth: 1,
                ),
              );
      }),
    );
  }

  String formatDate(String date) {
    var day = DateTime.parse(date).day.toString();
    var month = intl.DateFormat("MMM").format(DateTime.parse(date));
    var year = DateTime.parse(date).year.toString();
    return day + " " + month + " " + year;
  }
}
