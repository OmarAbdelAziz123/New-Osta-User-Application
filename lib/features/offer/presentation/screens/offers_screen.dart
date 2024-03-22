import 'package:osta_user_app/common/widgets/buttons/third_button_widget.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/offers/not_found_and_found_offers_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return SingleChildScrollView(
    //   child: Padding(
    //     padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
    //     child: Column(
    //       children: [
    //         /// App Bar
    //         AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Offers', actions: Container(), widthOfText: 280.w),
    //
    //         /// Make Space
    //         SizedBox(height: 24.h),
    //
    //         Container(
    //           height: 41.h,
    //           width: double.infinity,
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('Offers for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
    //               Container(
    //                 height: 4.h,
    //                 width: double.infinity,
    //                 decoration: BoxDecoration(
    //                   color: OColors.primaryColor500,
    //                   borderRadius: BorderRadius.circular(100.r),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //
    //         /// Make Space
    //         SizedBox(height: 24.h),
    //
    //         Padding(
    //           padding: EdgeInsets.only(bottom: 28.h, top: 5.h),
    //           child: Container(
    //             height: 192.h,
    //             width: double.infinity,
    //             decoration: BoxDecoration(
    //               color: OColors.whiteColor,
    //               borderRadius: BorderRadius.circular(32.r),
    //               boxShadow: [AppBoxShadows.cardShadowTwo],
    //             ),
    //             child: Row(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Expanded(flex: 2, child: Image.asset(OImages.ostaImage)),
    //                 SizedBox(width: 20.w),
    //                 Expanded(flex: 4, child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text('House Cleaning', style: OStyles.h6Bold),
    //                     SizedBox(height: 10.h),
    //                     Text('Jenny Wilson', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
    //                     SizedBox(height: 10.h),
    //                     /// Stars
    //                     Row(
    //                       children: [
    //                         Text('4.7', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
    //                         SizedBox(width: 5.w),
    //                         SvgPicture.asset(OImages.starIcon2),
    //                       ],
    //                     ),
    //                     SizedBox(height: 10.h),
    //                     Text('Jenny has completed 11 orders away from you 7 km', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700), maxLines: 2, overflow: TextOverflow.ellipsis),
    //                     SizedBox(height: 21.h),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         ThirdButtonWidget(isRejected: true, buttonText: 'Reject', textStyle: OStyles.bodyXSmallBold, containerColor: OColors.primaryColor100),
    //                       ],
    //                     ),
    //                   ],
    //                 ),
    //                 ),
    //                 Expanded(flex: 4, child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text('House Cleaning', style: OStyles.h6Bold),
    //                     SizedBox(height: 10.h),
    //                     TextRich1Widget(text1: 'Jenny offers you an offer worth ', text2: '230', styleOfText1: OStyles.h4Bold, styleOfText2: OStyles.h6Bold.copyWith(color: OColors.primaryColor500)),
    //                     SizedBox(height: 21.h),
    //                     Row(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         ThirdButtonWidget(isRejected: false, buttonText: 'Accept', textStyle: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500),
    //                       ],
    //                     ),
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.only(bottom: 28.h, top: 5.h),
    //           child: Container(
    //             height: 192.h,
    //             width: double.infinity,
    //             padding: EdgeInsets.only(left: 20.w, right: 20.sp, top: 12.h),
    //             decoration: BoxDecoration(
    //               color: Colors.red,
    //               borderRadius: BorderRadius.circular(32.r),
    //               boxShadow: [AppBoxShadows.cardShadowTwo],
    //             ),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Image.asset(OImages.ostaImage),
    //                     SizedBox(width: 20.w),
    //                     Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                       children: [
    //                         Text('House Cleaning', style: OStyles.h6Bold),
    //                         Text('Jenny Wilson', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
    //                         /// Stars
    //                         Row(
    //                           children: [
    //                             Text('4.7', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
    //                             SizedBox(width: 5.w),
    //                             SvgPicture.asset(OImages.starIcon2),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                     Row(),
    //                   ],
    //                 ),
    //                 SizedBox(height: 10.h),
    //
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Container(
    //                       width: 150.w,
    //                       child: Text('Jenny has completed 11 orders away from you 7 km', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700), maxLines: 2, overflow: TextOverflow.ellipsis),
    //                     ),
    //                     Container(
    //                       width: 150.w,
    //                       child: TextRich1Widget(text1: 'Jenny offers you an offer worth ', text2: '230', styleOfText1: OStyles.h4Bold, styleOfText2: OStyles.h6Bold.copyWith(color: OColors.primaryColor500)),
    //                     ),
    //                   ],
    //                 ),
    //                 Row(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            /// App Bar
            AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Offers', actions: Container(), widthOfText: 280.w),

            /// Make Space
            SizedBox(height: 24.h),

            SizedBox(
              height: 41.h,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Offers for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
                  Container(
                    height: 4.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: OColors.primaryColor500,
                      borderRadius: BorderRadius.circular(100.r),
                    ),
                  ),
                ],
              ),
            ),

            /// Not Found Widget
            // const NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: 'Not Found', description: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.'),

            /// Found Widget
            const NotFoundAndFoundOffersWidget(emoji: OImages.foundIcon, title: 'Waiting for offers', description: 'Don\'t worry, we will find you Osta as soon as possible. Receive the offers and choose the most suitable for you. We wish you an enjoyable experience'),
          ],
        ),
      ),
    );
  }
}

