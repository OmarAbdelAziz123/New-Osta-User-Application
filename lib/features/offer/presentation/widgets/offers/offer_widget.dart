import 'package:osta_user_app/utils/constants/exports.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 230.h,
      padding: EdgeInsets.only(top: 13.h, bottom: 13.h, left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [AppBoxShadows.cardShadowTwo],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(OImages.ostaImage),
                  SizedBox(width: 20.w),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('House Cleaning', style: OStyles.h6Bold),
                      Text('Jenny Wilson', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
                      Text('4.7 ✰', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),

                    ],
                  ),
                  SizedBox(width: 30.w),

                  Text('The best offer', style: OStyles.bodySmallBold.copyWith(color: OColors.disabledButton, height: 2.5.h)),
                ],
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ODeviceUtils.getScreenWidth(context) / 2.6,
                  child: Text('Jenny has completed 11 orders away from you 7 km Jenny has completed 11 orders away from you 7 km', style: OStyles.bodySmallBold.copyWith(color: OColors.greyScale700), overflow: TextOverflow.ellipsis, maxLines: 3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ODeviceUtils.getScreenWidth(context) / 2.6,
                      child: Text('Jenny offers you an offer worth', style: OStyles.h6Bold, overflow: TextOverflow.ellipsis, maxLines: 2),
                    ),
                    Text('200', style: OStyles.h6Bold.copyWith(color: OColors.gradientPurple1), overflow: TextOverflow.ellipsis, maxLines: 2),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ThirdButtonWidget(isRejected: true, buttonText: 'Reject', textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.gradientRed1), containerColor: OColors.primaryColor100, width: 120.w, height: 26.h, borderRadius: 6.r),
                ThirdButtonWidget(isRejected: false, buttonText: 'Accept', textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 120.w, height: 26.h, borderRadius: 6.r),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
