import 'package:osta/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/hex_color.dart';

class WalletScreenInProfile extends StatefulWidget {
  const WalletScreenInProfile({super.key});

  @override
  State<WalletScreenInProfile> createState() => _WalletScreenInProfileState();
}

class _WalletScreenInProfileState extends State<WalletScreenInProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            /// App Bar
            TopRowInAllScreens(titleOfScreenWidget: Text(AppLocalizations.of(context)!.translate('wallet')!, style: OStyles.h4Bold), onTap: () => context.pop()),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(AppLocalizations.of(context)!.translate('wallet')!, style: OStyles.bodySmallBold.copyWith(fontSize: 15.sp, color: HexColor('212121'))),
            //   ],
            // ),

            /// Make Space
            SizedBox(height: 32.h),

            // Container(
            //   width: ODeviceUtils.getScreenWidth(context),
            //   height: ODeviceUtils.getScreenHeight(context) / 4,
            //   decoration: BoxDecoration(
            //     color: OColors.whiteColor,
            //     borderRadius: BorderRadius.circular(30.r),
            //     gradient: LinearGradient(
            //       colors: [
            //         OColors.whiteColor,
            //         OColors.whiteColor,
            //       ],
            //     ),
            //     boxShadow: [
            //       BoxShadow(
            //         color: HexColor('#00000012'),
            //         offset: Offset(0, 3.h),
            //         blurRadius: 20.r,
            //       ),
            //     ],
            //   ),
            //   child: Center(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Text.rich(
            //             TextSpan(
            //                 text: '1500',
            //                 style: OStyles.bodyLargeBold.copyWith(color: HexColor('7C21FF'), fontSize: 102.sp),
            //                 children: <InlineSpan>[
            //                   TextSpan(
            //                     text: ' \$',
            //                     style: OStyles.bodyLargeBold.copyWith(color: HexColor('5A5A5A'), fontSize: 25.sp),
            //                   )
            //                 ]
            //             )
            //         ),
            //         Text('Wallet balance', style: OStyles.bodySmallBold.copyWith(fontSize: 16.sp, color: HexColor('5A5A5A'))),
            //       ],
            //     ),
            //   ),
            // ),

            Container(
              height: ODeviceUtils.getScreenHeight(context) / 4,
              child: Card(
                shadowColor: OColors.whiteColor,
                color: OColors.whiteColor,
                elevation: 3.sp,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                          TextSpan(
                              text: '1500',
                              style: OStyles.bodyLargeBold.copyWith(color: HexColor('7C21FF'), fontSize: 102.sp),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: ' \$',
                                  style: OStyles.bodyLargeBold.copyWith(color: HexColor('5A5A5A'), fontSize: 25.sp),
                                )
                              ]
                          )
                      ),
                      Text('Wallet balance', style: OStyles.bodySmallBold.copyWith(fontSize: 16.sp, color: HexColor('5A5A5A'))),
                    ],
                  ),
                ),
              ),
            ),

            /// Make Space
            SizedBox(height: 33.h),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(AppLocalizations.of(context)!.translate('previousPayment')!, style: OStyles.bodySmallBold.copyWith(fontSize: 21.sp, color: HexColor('212121'))),
                  Text(AppLocalizations.of(context)!.translate('all')!, style: OStyles.bodySmallBold.copyWith(fontSize: 11.sp, color: HexColor('AA70FF'))),
                ],
              ),
            ),

            /// Make Space
            SizedBox(height: 27.h),

            // TransactionWidget(
            //   imageTransaction: OImages.sendMoneyIcon,
            //   price: '1150',
            // ),

            Container(
              // color: Colors.red,
              height: ODeviceUtils.getScreenHeight(context) / 3,
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return TransactionWidget(
                    imageTransaction: OConstants.transactionsIcons[index],
                    price: '1150',
                    description: AppLocalizations.of(context)!.translate('trialContent')!,
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10.h);
                },
                itemCount: OConstants.transactionsIcons.length,
              ),
            ),

            /// Make Space
            SizedBox(height: 20.h),

            MainButtonWidget(
              centerWidgetInButton: Text(AppLocalizations.of(context)!.translate('rechargeBalance')!, style: OStyles.bodySmallBold.copyWith(fontSize: 15.sp, color: Colors.white)),
              margin: EdgeInsets.zero,
              buttonColor: OColors.primaryColor500,
              boxShadow: [AppBoxShadows.buttonShadowOne],
            ),
          ],
        ),
      ),
    );
  }
}
