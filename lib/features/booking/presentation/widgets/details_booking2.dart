import 'package:osta_user_app/common/widgets/buttons/button_with_border.dart';
import 'package:osta_user_app/common/widgets/buttons/third_button_widget.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/buttom_navigation_bar_cancel_booking.dart';

import '../../../../utils/constants/exports.dart';

class DetailsBooking2 extends StatelessWidget {
  const DetailsBooking2({Key? key, required this.locationDescription, required this.price, required this.onYesCancelButton, this.mapWidget, this.thirdButtonWidget, required this.viewReceiptTap}) : super(key: key);

  final String locationDescription;
  final double price;
  final Widget? mapWidget;
  final Widget? thirdButtonWidget;
  final void Function() onYesCancelButton, viewReceiptTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Price", style: OStyles.bodyMediumMedium),
            // Text("Date & Time",style: OStyles.bodyMediumMedium),
            Text(price.toString(), style: OStyles.bodyLargeSemiBold),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Location", style: OStyles.bodyMediumMedium),
            Text(locationDescription, style: OStyles.bodyLargeSemiBold),
          ],
        ),
        SizedBox(height: 16.h),
        // Image.asset(OImages.map, height: 217.h, width: 340.w),
        mapWidget == null ? thirdButtonWidget! : Container(
          height: ODeviceUtils.getScreenHeight(context) / 4,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(24.r),
          ),
          child: mapWidget,
        ),
        SizedBox(height: 16.h),
        if(mapWidget != null) Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ButtonWithBorderWidget(
                width: 164.w,
                height: 32.h,
                textButton: "Cancel Booking",
                onTap: () {
                  ODeviceUtils.showCustomBottomSheet(
                    context: context,
                    widget: ButtomNavigationBarCancelBooking(
                      onNoCancelButton: () => context.pop(),
                      onYesCancelButton: onYesCancelButton,
                    ),
                  );
                }),
            ThirdButtonWidget(
              isRejected: false,
              widgetInButton: Text('View E-Receipt',
                  style: OStyles.bodyXSmallSemiBold
                      .copyWith(color: OColors.whiteColor)),
              textStyle: OStyles.bodyMediumSemiBold
                  .copyWith(color: OColors.whiteColor),
              containerColor: OColors.primaryColor500,
              width: 164.w,
              height: 32.h,
              borderRadius: 20.r,
              onTap: viewReceiptTap,
            ),
          ],
        )
      ],
    );
  }
}
