import '../../../../utils/constants/exports.dart';

class ButtomNavigationBarCancelBooking extends StatelessWidget {
  ButtomNavigationBarCancelBooking({super.key, required this.onYesCancelButton, required this.onNoCancelButton});

  void Function() onNoCancelButton;
  void Function() onYesCancelButton;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 370.h,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
        child: Column(
          children: [
            /// Make Space
            SizedBox(height: 35.h),

            SizedBox(width: double.infinity, height: 29.h, child: Text('Cancel Booking', style: OStyles.h4Bold.copyWith(color: OColors.alertsAndStatusError), textAlign: TextAlign.center)),

            /// Make Space
            SizedBox(height: 24.h),

            Container(width: double.infinity, height: 1.w, color: OColors.greyScale200,),

            /// Make Space
            SizedBox(height: 24.h),

            SizedBox(width: double.infinity, height: 104.h, child: Column(
              children: [
                SizedBox(width: double.infinity, height: 53.h,child: Text('Are you sure want to cancel your service booking?', style: OStyles.h5Bold.copyWith(color: OColors.greyScale800), textAlign: TextAlign.center)),
                /// Make Space
                SizedBox(height: 11.h),
                SizedBox(width: double.infinity, height: 40.h,child: Text('Only 80% of the money you can refund from your payment according to our policy', style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale800), textAlign: TextAlign.center)),

              ],
            )),

            /// Make Space
            SizedBox(height: 24.h),

            Container(width: double.infinity, height: 1.w, color: OColors.greyScale200,),

            /// Make Space
            SizedBox(height: 24.h),

            /// Two Buttons (Cancel - Yes)
            SizedBox(
              width: double.infinity,
              height: 58.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SecondButtonWidget(bgColor: OColors.primaryColor100, widget: Text('Cancel', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500)), onTap: onNoCancelButton),
                  SecondButtonWidget(bgColor: OColors.primaryColor500, widget: Text('Yes, Cancel Booking', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)), onTap: onYesCancelButton),
                ],
              ),
            ),
          ],
        )
    );
  }
}
