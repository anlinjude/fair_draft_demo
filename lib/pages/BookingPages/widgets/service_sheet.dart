import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:fairdraft/pages/BookingPages/models/sub_service.dart';
import 'package:fairdraft/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../constants/app_colors.dart';
import '../../../widgets/custom_box.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_listview.dart';
import '../controller/booking_controller.dart';
import '../models/options.dart';

// ignore: must_be_immutable
class ServiceSheet extends StatelessWidget {
  ServiceSheet(this.subServices, {Key? key}) : super(key: key);

  BookingController vc = Get.find<BookingController>();
  List<SubService> subServices = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(
              mainAxisSize: MainAxisSize.max,
              children: subServices.map((subservice) {
                return

                    //
                    subservice.type == "multiple" || subservice.type == "single"
                        ? Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 5.w, top: 1.h),
                                  child: SizedBox(
                                    width: 250.w,
                                    child: Text(
                                      subservice.title!,
                                      style: Theme.of(context).textTheme.headline4,
                                    ).textColor(Colors.black).fontWeight(FontWeight.w600),
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.h),
                              CustomListView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Obx(() {
                                          return CustomBox(
                                            padding: 10,
                                            width: 80.w,
                                            height: 7.h,
                                            color: const Color(0xffeceff1),
                                            borderRadius: 10,
                                            child: Center(
                                              child: CheckboxListTile(
                                                dense: true,
                                                visualDensity: const VisualDensity(vertical: -4),
                                                controlAffinity: ListTileControlAffinity.leading,
                                                shape: const CircleBorder(),
                                                onChanged: (val) {
                                                  vc.chooseOptions(
                                                      val!,
                                                      subservice.options![index],
                                                      subservice);
                                                },
                                                title: Text(subservice.options![index].title!),
                                                value: vc.selectedOptions.value.contains(subservice.options![index]),
                                              ),
                                            ),
                                          );
                                        }),
                                        SizedBox(height: 2.h),
                                      ],
                                    );
                                  },
                                  itemCount: subservice.options!.length),
                            ],
                          )

                        //radio list
                        : subservice.type == "radio"
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //title
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.w, top: 1.h),
                                      child: SizedBox(
                                        width: 250.w,
                                        child: Text(
                                          subservice.title!,
                                          style: Theme.of(context).textTheme.headline4,
                                        ).textColor(Colors.black).fontWeight(FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  //
                                  Padding(
                                    padding: EdgeInsets.only(left: 10.w),
                                    child: SizedBox(
                                      height: 7.h,
                                      child: CustomListView(
                                          scrollDirection: Axis.horizontal,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: subservice.options!.length,
                                          itemBuilder: (context, index) {
                                            return Obx(() {
                                              return ConstrainedBox(
                                                constraints: BoxConstraints.tightFor(width: 25.w, height: 7.w),
                                                child: RadioListTile<Option>(
                                                    dense: true,
                                                    contentPadding: EdgeInsets.zero,
                                                    onChanged: (value) {vc.radioButtonPressed(subservice,value!);},
                                                    groupValue: vc.radioMap[subservice.id],
                                                    value: subservice.options![index],
                                                    title: Transform.translate(
                                                        offset: const Offset(-15, 0),
                                                        child: Text(subservice.options![index].title!))),
                                              );
                                            });
                                          },
                                      ),
                                    ),
                                  )
                                ],
                              )

                            //input field
                            : Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 5.w, top: 1.h),
                                      child: SizedBox(
                                        width: 250.w,
                                        child: Text(
                                          subservice.title!,
                                          style:
                                              Theme.of(context).textTheme.headline4,
                                        ).textColor(Colors.black).fontWeight(FontWeight.w600),
                                      ),
                                    ),
                                  ),

                                  //tatto textfield
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, right: 10.w,top: 2.h),
                                    child: CustomTextField(
                                      controller: vc.tattooTEC,
                                      borderRadius: 10,
                                      textInputType: TextInputType.text,
                                      hintText: 'Tattoo text',
                                      onChanged: (input) {
                                        vc.addTattooText(input, subservice);
                                      },
                                    ),
                                  )
                                ],
                              );
              }).toList(),
            ),

            //
            Center(
              child: Obx(() {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 3,
                    child: CustomButton(
                      width: 50.w,
                      height: 6.h,
                      borderRadius: 10,
                      highlightColor: Colors.black12,
                      color: vc.selectedOptions.isNotEmpty
                          ? AppColor().proceedColor
                          : AppColor().notYet,
                      onTap: vc.selectedOptions.isNotEmpty
                          ? () {
                              Get.back();
                            }
                          : null,
                      child: Center(
                        child: Text(
                          'Confirm',
                          style: Theme.of(context).textTheme.headline4,
                        ).textColor(Colors.white),
                      ),
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
