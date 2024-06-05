import 'package:osta_user_app/utils/constants/exports.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({super.key, required this.priceOffer, required this.onTapOnRejectButton, required this.onTapOnAcceptButton, required this.widgetInRejectButton, required this.widgetInAcceptButton, required this.distance, required this.serviceName, required this.firstName, required this.lastName, required this.timingArrive, required this.containerGradient, required this.textsColor});

  final int priceOffer;
  final Color textsColor;
  final void Function() onTapOnRejectButton, onTapOnAcceptButton;
  final Widget widgetInRejectButton, widgetInAcceptButton;
  final String serviceName, firstName, lastName, timingArrive, distance;
  final Gradient containerGradient;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 230.h,
      height: ODeviceUtils.getScreenHeight(context).h / 3,
      padding: EdgeInsets.only(top: 13.h, bottom: 13.h, left: 20.w),
      margin: EdgeInsets.only(bottom: 18.h),
      decoration: BoxDecoration(
        // color: Colors.red,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [AppBoxShadows.cardShadowTwo],
        gradient: containerGradient,
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
                      Text(serviceName, style: OStyles.h6Bold),
                      Text('$firstName $lastName', style: OStyles.bodySmallMedium.copyWith(color: textsColor)),
                      Text('4.7 ✰', style: OStyles.bodySmallMedium.copyWith(color: textsColor)),
                    ],
                  ),
                  const Spacer(),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('The best offer', style: OStyles.bodySmallBold.copyWith(color: OColors.disabledButton, height: 2.5.h)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 8.w),
                            decoration: BoxDecoration(
                              color: OColors.primaryColor500,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100.r),
                                bottomLeft: Radius.circular(100.r),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Will comes $timingArrive', style: OStyles.bodySmallBold.copyWith(color: OColors.whiteColor, height: 2.5.h))
                              ],
                            ),
                          )
                        ],
                      ),
                      Text('', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
                    ],
                  ),
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
                  child: Text('The distance between provider and you is $distance km', style: OStyles.bodySmallBold.copyWith(color: textsColor), overflow: TextOverflow.ellipsis, maxLines: 3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: ODeviceUtils.getScreenWidth(context) / 2.6,
                      child: Text('Jenny offers you an offer worth', style: OStyles.h6Bold, overflow: TextOverflow.ellipsis, maxLines: 2),
                    ),
                    Text(priceOffer.toString(), style: OStyles.h6Bold.copyWith(color: OColors.gradientPurple1), overflow: TextOverflow.ellipsis, maxLines: 2),
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
                ThirdButtonWidget(
                    isRejected: true,
                  widgetInButton: widgetInRejectButton,
                    textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.gradientRed1),
                    containerColor: OColors.primaryColor100, width: 120.w,
                    height: 26.h,
                    borderRadius: 6.r,
                  onTap: onTapOnRejectButton,
                ),
                ThirdButtonWidget(
                    isRejected: false,
                    widgetInButton: widgetInAcceptButton,
                    textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor),
                    containerColor: OColors.primaryColor500,
                    width: 120.w,
                    height: 26.h,
                    borderRadius: 6.r,
                  onTap: onTapOnAcceptButton,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
