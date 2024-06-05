import 'package:osta_user_app/common/widgets/buttons/button_with_border.dart';
import 'package:osta_user_app/common/widgets/buttons/third_button_widget.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/buttom_navigation_bar_cancel_booking.dart';

import '../../../../utils/constants/exports.dart';

class DetailsBooking2 extends StatelessWidget {
  const DetailsBooking2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Date & Time",style: OStyles.bodyMediumMedium),
            Text("Dec 12, 2024 | 13:00 - 15:00 PM",style: OStyles.bodyLargeSemiBold),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Text("Location",style: OStyles.bodyMediumMedium),
            Text("1691 Carpenter Pass",style: OStyles.bodyLargeSemiBold),
          ],
        ),
        SizedBox(height: 16.h),
        Image.asset(OImages.map,height: 217.h,width: 340.w),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             ButtonWithBorderWidget(
                 width: 164.w,
                 height: 32.h,
                 textButton: "Cancel Booking",onTap: (){
               ODeviceUtils.showCustomBottomSheet(context: context, widget: const ButtomNavigationBarCancelBooking());
            } ),
            ThirdButtonWidget(isRejected: false, widgetInButton: Text('View E-Receipt', style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)), textStyle: OStyles.bodyMediumSemiBold.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 164.w, height: 32.h,borderRadius: 20.r, onTap: () {  },),
          ],
        )

      ],
    );
  }
}
