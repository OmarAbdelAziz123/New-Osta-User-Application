import '../../../../utils/constants/exports.dart';

class DetailsBooking extends StatelessWidget {
  const DetailsBooking({Key? key}) : super(key: key);

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
        Image.asset(OImages.map,height: 217,width: 340),
        SizedBox(height: 16.h),
        ThirdButtonWidget(isRejected: false, widgetInButton: Text('View E-Receipt', style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)), textStyle: OStyles.bodyMediumSemiBold.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 340.w, height: 32.h,borderRadius: 20.r, onTap: () {  },)

      ],
    );
  }
}
