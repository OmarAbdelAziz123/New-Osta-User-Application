import 'package:osta_user_app/utils/constants/log_util.dart';

import '../../../../../utils/constants/exports.dart';
import '../details_booking2.dart';

class MyBookingContainerWidget2 extends StatefulWidget {
  MyBookingContainerWidget2({
    Key? key,
    this.showDetailsBooking = false,
    required this.providerImage,
    required this.bookingJob,
    required this.bookingName,
    required this.containerColor,
    required this.buttonText,
    required this.onTap,
    required this.isAccepted,
    required this.locationDescription,
    required this.price,
    required this.onYesCancelButton, required this.mapWidget, this.isCompleted, required this.thirdButtonWidget, required this.viewReceiptTap, required this.viewReceiptTap2
  }) : super(key: key);

  final String bookingJob, bookingName, buttonText;
  final Color containerColor;
  bool? showDetailsBooking;
  bool? isAccepted;
  Widget providerImage;
  void Function() onTap;
  final String? locationDescription;
  final double? price;
  final bool? isCompleted;
  final Widget mapWidget;
  final Widget thirdButtonWidget;
  final void Function() onYesCancelButton, viewReceiptTap, viewReceiptTap2;

  @override
  State<MyBookingContainerWidget2> createState() => _MyBookingContainerWidget2State();
}

class _MyBookingContainerWidget2State extends State<MyBookingContainerWidget2> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.sp),
      width: double.infinity,
      // height: widget.showDetailsBooking! ? ODeviceUtils.getScreenHeight(context) / 1.6 : ODeviceUtils.getScreenHeight(context) / 4.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: OColors.whiteColor,
        boxShadow: [AppBoxShadows.cardShadowTwo],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Container(
                  height: 100.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: widget.providerImage,
                ),
                SizedBox(width: 16.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.bookingJob, style: OStyles.h6Bold),
                    SizedBox(height: 12.h),
                    Text(widget.bookingName, style: OStyles.bodySmallMedium),
                    SizedBox(height: 12.h),
                    ThirdButtonWidget(
                      isRejected: false,
                      widgetInButton: Text(widget.buttonText, style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)),
                      textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor),
                      containerColor: widget.containerColor,
                      width: 76.w,
                      height: 30.h,
                      borderRadius: 6.r,
                      onTap: () {},
                    ),
                  ],
                ),
                const Spacer(),
                if(widget.isAccepted!) InkWellWidget(
                  onTap: widget.onTap,
                  child: SvgPicture.asset(OImages.smsLogo, width: 100.w, height: 50),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            const Divider(thickness: 0.5),

            AnimatedCrossFade(
              firstChild: Container(),
              secondChild: !widget.isCompleted! 
                  ?  DetailsBooking2(
                locationDescription: widget.locationDescription ?? 'Location description is empty',
                price: widget.price ?? 0,
                onYesCancelButton: widget.onYesCancelButton,
                mapWidget: widget.mapWidget,
                viewReceiptTap: widget.viewReceiptTap,
              )
                  : DetailsBooking2(
                locationDescription: widget.locationDescription ?? 'Location description is empty',
                price: widget.price ?? 0,
                onYesCancelButton: widget.onYesCancelButton,
                thirdButtonWidget: widget.thirdButtonWidget,
                viewReceiptTap: widget.viewReceiptTap2,
              ),
              crossFadeState: widget.showDetailsBooking! ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 500),
            ),


            SizedBox(height: 16.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  widget.showDetailsBooking = !widget.showDetailsBooking!;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      color: OColors.whiteColor,
                      child: SvgPicture.asset(widget.showDetailsBooking! ? OImages.arrowUpIOS : OImages.arrowDownIOS),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
