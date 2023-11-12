import 'package:fairdraft/constants/app_colors.dart';
import 'package:fairdraft/services/validator_service.dart';
import 'package:fairdraft/widgets/custom_button.dart';
import 'package:fairdraft/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalletTopupWidget extends StatelessWidget {
  const WalletTopupWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 30.h,
      color: Colors.white,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              //
              CustomTextField(
                  textInputType: TextInputType.number,
                  borderColor: AppColor().primaryColor,
                  validator: FormValidator.validateName,
                  fillColor: Colors.white,
                  borderRadius: 10,
                  hintText: 'Enter amount',
              ),

              //
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: CustomButton(
                  width: 100.w,
                  height: 6.h,
                  color: AppColor().primaryColor,
                  borderRadius: 10,
                  highlightColor: Colors.black12,
                  onTap: (){},
                  child: Center(
                    child: Text(
                      'TOP-UP WALLET',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
    );
  }
}
