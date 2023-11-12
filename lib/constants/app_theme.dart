import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'app_colors.dart';

class AppTheme{

  ThemeData appTheme(){
    return ThemeData(
        //fontFamily: GoogleFonts.ibmPlexSerif().fontFamily,
        //fontFamily: GoogleFonts.krub().fontFamily,
        //fontFamily: GoogleFonts.montserrat().fontFamily,
        //fontFamily: GoogleFonts.poppins().fontFamily,
        fontFamily: GoogleFonts.roboto().fontFamily,
        /*fontFamily: 'Lato',*/
        //fontFamily: GoogleFonts.notoSans().fontFamily,
        //fontFamily: GoogleFonts.oswald().fontFamily,
        primarySwatch: AppColor().primaryColor,
        primaryColor: AppColor().primaryColor,
        primaryColorDark: AppColor().primaryColor,
        textSelectionTheme: const TextSelectionThemeData(
          selectionColor: Colors.grey,
          cursorColor: Colors.black,
        ),
        iconTheme: IconThemeData(
          color: AppColor().bgColor
        ),
        backgroundColor: Colors.white,
        cardColor: Colors.grey[50],
        textTheme:  TextTheme(
          headline6: TextStyle(
              color: Colors.grey[600],
              fontSize: 10.sp,
              fontWeight: FontWeight.w400
          ),
          headline5: TextStyle(
              color: Colors.grey[700],
              fontSize: 12.sp
          ),
          headline4: TextStyle(
              color: Colors.grey[700],
              fontSize: 14.sp,
              fontWeight: FontWeight.w500),
          headline3: TextStyle(
            color: Colors.grey[800],
            fontSize: 17.sp,
              fontWeight: FontWeight.w600,
          ),
          headline2:  TextStyle(
            color: Colors.grey[900],
            fontSize: 19.sp,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: const TextStyle(
            color: Colors.grey,
          ),
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.transparent,
        ),
        // brightness: Brightness.light,
        // CUSTOMIZE showDatePicker Colors
        dialogBackgroundColor: Colors.white,
        colorScheme: ColorScheme.light(
          primary: AppColor().primaryColor,
          secondary: AppColor().primaryColor,
          brightness: Brightness.light,
        ),
        buttonTheme:  ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            buttonColor: AppColor().primaryColor,
        ),
        highlightColor: Colors.transparent,
        drawerTheme: const DrawerThemeData(
            backgroundColor: Colors.white
        ),
      splashFactory: InkRipple.splashFactory,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(AppColor().primaryColor),
      )
    );
  }
}