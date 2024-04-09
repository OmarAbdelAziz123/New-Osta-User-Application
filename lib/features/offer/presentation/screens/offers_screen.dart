import 'package:osta_user_app/features/offer/presentation/widgets/offers/not_found_and_found_offers_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    /// Offers States (Waiting - Not Found).
    // return Padding(
    //   padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
    //   child: Column(
    //     children: [
    //       /// App Bar
    //       AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Offers', actions: Container(), widthOfText: 280.w),
    //
    //       /// Make Space
    //       SizedBox(height: 24.h),
    //
    //       SizedBox(
    //         height: 41.h,
    //         width: double.infinity,
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             Text('Offers for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
    //             Container(
    //               height: 4.h,
    //               width: double.infinity,
    //               decoration: BoxDecoration(
    //                 color: OColors.primaryColor500,
    //                 borderRadius: BorderRadius.circular(100.r),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: 4,
    //           shrinkWrap: true,
    //           itemBuilder: (context, index) {
    //             return OfferWidget();
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    // );

    /// Offers States (Waiting - Not Found).
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
                    decoration: BoxDecoration(color: OColors.primaryColor500, borderRadius: BorderRadius.circular(100.r)),
                  ),
                ],
              ),
            ),

            /// Not Found Widget
            const NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: 'Not Found', description: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.'),

            /// Found Widget
            // const NotFoundAndFoundOffersWidget(emoji: OImages.foundIcon, title: 'Waiting for offers', description: 'Don\'t worry, we will find you Osta as soon as possible. Receive the offers and choose the most suitable for you. We wish you an enjoyable experience'),
          ],
        ),
      ),
    );
  }
}