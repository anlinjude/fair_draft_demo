import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/pages/HomePage/controller/home_controller.dart';
import 'package:fairdraft/pages/HomePage/widgets/wallet_topup_widget.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';

import '../../../constants/app_colors.dart';
import '../../../widgets/custom_box.dart';

// ignore: must_be_immutable
class WalletWidget extends StatelessWidget {
  WalletWidget({Key? key}) : super(key: key);

  HomeController vc = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: CustomBox(
        height: 25.h,
        width: 90.w,
        borderRadius: 25,
        padding: 20,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                //
                CustomBox(
                  height: 7.h,
                  width: 15.w,
                  borderRadius: 20,
                  color: AppColor().primaryColor,
                  boxShadow: [
                    BoxShadow(
                        color: AppColor().primaryColor[500]!,
                        blurRadius: 10,
                        offset: const Offset(0, 3)),
                  ],
                  child: const Center(
                    child: Icon(
                      Icons.account_balance_wallet,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),

                //
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0, left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Wallet',
                        style: Theme.of(context).textTheme.headline5,
                      ).bold().textColor(Colors.black),
                      Text(
                        'Collect credit points',
                        style: Theme.of(context).textTheme.headline6,
                      )
                    ],
                  ),
                )
              ],
            ),

            //
            Expanded(
              child: Center(child: Obx(() {
                return Text(
                  '${vc.user.value.mobile}',
                  style: const TextStyle(shadows: [
                    BoxShadow(
                        color: Color(0xff000000),
                        offset: Offset(0, 0.5),
                        blurRadius: 1),
                  ]),
                ).bold().fontSize(17.sp).letterSpacing(4);
              })),
            ),

            //
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.w,top: 2.h),
                      child: Text(
                        'Available',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          '\u{20B9}${vc.user.value.walletPoint}',
                          style: Theme.of(context).textTheme.headline4,
                        ).bold().textColor(Colors.black),
                      );
                    })
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 3.w,top: 2.h),
                      child: Text(
                        'Locked',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    Obx(() {
                      return Padding(
                        padding: EdgeInsets.only(left: 3.w),
                        child: Text(
                          '\u{20B9}${vc.user.value.lockedPoint}',
                          style: Theme.of(context).textTheme.headline4,
                        ).bold().textColor(Colors.black),
                      );
                    })
                  ],
                ),

                //
                Padding(
                  padding: EdgeInsets.only(top: 1.h),
                  child: CustomButton(
                    height: 7.h,
                    width: 15.w,
                    borderRadius: 20,
                    color: AppColor().primaryColor,
                    boxShadows: [
                      BoxShadow(
                          color: AppColor().primaryColor[500]!,
                          blurRadius: 10,
                          offset: const Offset(0, 3)
                      ),
                    ],
                    onTap: () async {
                      /*showModalBottomSheet<dynamic>(
                          isDismissible: true,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          isScrollControlled: true,
                          enableDrag: true,
                          context: context,
                          builder: (context){
                            return const WalletTopupWidget();
                          }
                      );*/
                     /* final FlutterShareMe flutterShareMe = FlutterShareMe();
                      await flutterShareMe.shareToWhatsApp(msg: vc.user.value.shareText!);*/
                      Share.share(vc.user.value.shareText!);
                    },
                    child: const Center(
                      child: Icon(
                        Icons.share,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
