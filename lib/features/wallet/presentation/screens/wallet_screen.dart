import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/features/wallet/managers/wallet_cubit.dart';
import 'package:osta_user_app/features/wallet/models/transactions_model.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/hex_color.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {

  @override
  void initState() {
    WalletCubit.get(context).walletFunction();
    WalletCubit.get(context).getAllTransactionsFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletCubit, WalletState>(
      builder: (context, state) {
        var walletCubit = WalletCubit.get(context);

        return Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
          child: Column(
            children: [
              /// App Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppLocalizations.of(context)!.translate('wallet')!, style: OStyles.bodySmallBold.copyWith(fontSize: 15.sp, color: HexColor('212121'))),
                ],
              ),

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
                                // text: '1500',
                                text: walletCubit.walletModel.result == null ? '...' : walletCubit.walletModel.result!.balance,
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
                child: state is TransactionsLoadingState || walletCubit.getAllTransactionsModel.result == null
                   ? LoadingWidget(iconColor: OColors.primaryColor500)
                       : walletCubit.getAllTransactionsModel.result!.isEmpty
                    ? Container(
                  // color: Colors.red,
                  child: Lottie.asset('assets/images/lotties/emptyTransactions.json'),
                )
                    : ListView.separated(
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var allTransactions = walletCubit.getAllTransactionsModel.result ?? [];

                    return TransactionWidget(
                      imageTransaction: allTransactions[index].type == 'withdraw' ? OImages.sendMoneyIcon : OImages.postMoneyIcon,
                      price: allTransactions[index].amount.toString() ?? "0",
                      description: allTransactions[index].description ?? '',
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10.h);
                  },
                  itemCount: walletCubit.getAllTransactionsModel.result?.length ?? 0,
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
        );
      },
    );
  }
}


class TransactionWidget extends StatelessWidget {
  const TransactionWidget({super.key, required this.imageTransaction, required this.price, required this.description});

  final String imageTransaction, price, description;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: ODeviceUtils.getScreenHeight(context) / 5,
      padding: EdgeInsets.symmetric(vertical: 21.h, horizontal: 20.w),
      margin: EdgeInsets.symmetric(horizontal: 1.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: HexColor('EEEEEE'),
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Image.asset(imageTransaction, height: 25.h),
          SizedBox(width: 25.w),
          SizedBox(
            width: ODeviceUtils.getScreenWidth(context) / 2.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppLocalizations.of(context)!.translate('balanceHasBeenCharged')!, style: OStyles.bodyXLargeBold.copyWith(fontSize: 14.sp, color: HexColor('212121'))),
                // Text(AppLocalizations.of(context)!.translate('trialContent')!, style: OStyles.bodyXLargeBold.copyWith(fontSize: 10.sp, color: HexColor('212121'))),
                Text(description, style: OStyles.bodyXLargeBold.copyWith(fontSize: 10.sp, color: HexColor('212121'))),
              ],
            ),
          ),
          SizedBox(width: 20.w),
          Text.rich(
              TextSpan(
                  text: price,
                  style: OStyles.bodyLargeBold.copyWith(color: OColors.greenColor, fontSize: 17.sp),
                  children: <InlineSpan>[
                    TextSpan(
                      text: ' \$',
                      style: OStyles.bodyLargeBold.copyWith(color: HexColor('000000'), fontSize: 17.sp),
                    )
                  ]
              )
          ),
        ],
      ),
    );
  }
}
