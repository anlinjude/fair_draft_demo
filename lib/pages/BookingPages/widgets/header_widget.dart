import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(top: 1.h),
            child: Text(
              'Set Date & Time',
              style: Theme.of(context).textTheme.headline3,
            ).textColor(Colors.black),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(left: 0.w, right: 6.w, top: 1.h),
            child: Text(
              'Pick preferred date and time for booking.We will do our best to match your selection.',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.left,
            ),
          ),
        ),
        SizedBox(
          height: 5.h,
        )
      ],
    );
  }
}
