import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/features/offer/models/offers/get_all_offers_to_me_model.dart';
import 'package:osta/features/offer/presentation/widgets/offers/not_found_and_found_offers_widget.dart';
import 'package:osta/features/offer/presentation/widgets/offers/offer_widget.dart';
import 'package:osta/utils/constants/exports.dart';

// class OffersScreen extends StatelessWidget {
//   const OffersScreen({super.key, required this.orderId});
//   final int orderId;
//
//   @override
//   Widget build(BuildContext context) {
//     /// Offers States (Waiting - Not Found).
//     return Scaffold(
//       backgroundColor: OColors.greyScale50,
//       body: BlocProvider(
//         create: (context) => OffersOrdersCubit()..getAllOffersByMeFunction(orderId: orderId),
//         child: BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
//           listener: (context, state) {
//             if(state is AcceptOffersSuccessState) {
//               OffersOrdersCubit.get(context).getAllOffersByMeFunction(orderId: orderId);
//               context.pushNamedAndRemoveUntil(ORoutesName.inboxRoute, predicate: (route) => false, arguments: {
//                 'orderId': orderId,
//               });
//             } else if(state is AcceptOffersErrorState) {
//               ODeviceUtils.showSnackBar(context: context, message: 'You have an a problem', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
//             } else if(state is RejectOffersSuccessState) {
//               OffersOrdersCubit.get(context).getAllOffersByMeFunction(orderId: orderId);
//               context.pushReplacementNamed(ORoutesName.navigationMenuRoute, arguments: 2);
//             }
//             if(state is RejectOffersErrorState) {
//               ODeviceUtils.showSnackBar(context: context, message: 'You have an a problem', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
//             }
//           },
//           builder: (context, state) {
//             var offersOrdersCubit = OffersOrdersCubit.get(context);
//
//             return Padding(
//               padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
//               child: Column(
//                 children: [
//                   /// App Bar
//                   AppBarWidget(leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))), title: 'Offers', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),
//
//                   /// Make Space
//                   SizedBox(height: 24.h),
//
//                   SizedBox(
//                     height: 41.h,
//                     width: double.infinity,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('Offers for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
//                         Container(
//                           height: 4.h,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: OColors.primaryColor500,
//                             borderRadius: BorderRadius.circular(100.r),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   state is GetAllOrdersLoadingState || offersOrdersCubit.getAllOffersToMeModel.result == null ?
//                       LoadingWidget(iconColor: OColors.primaryColor500) :
//                   // const Center(child: NotFoundAndFoundOffersWidget(emoji: OImages.foundIcon, title: 'Waiting for offers', description: 'Don\'t worry, we will find you Osta as soon as possible. Receive the offers and choose the most suitable for you. We wish you an enjoyable experience')) :
//                   offersOrdersCubit.getAllOffersToMeModel.result!.isEmpty || state is GetAllOrdersErrorState ?
//                   const NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: 'Not Found', description: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.')
//                       : Expanded(
//                     child: ListView.builder(
//                       itemCount: offersOrdersCubit.getAllOffersToMeModel.result!.length,
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         var offerList = offersOrdersCubit.getAllOffersToMeModel.result;
//                         List<Services> services = offerList![index].provider!.services!;
//                         String serviceNames = services.map((service) => service.name).join(', ');
//
//                         /// Make The Fist Letter is UpperCase
//                         serviceNames = serviceNames.replaceAllMapped(
//                           RegExp(r'\b(\w)'),
//                               (match) => match.group(0)!.toUpperCase(),
//                         );
//
//                         return OfferWidget(
//                             priceOffer: offerList[index].price!,
//                             onTapOnRejectButton: () {
//                               offersOrdersCubit.rejectOffersByMeFunction(offerId: offerList[index].id!);
//                             },
//                             onTapOnAcceptButton: () {
//                               offersOrdersCubit.acceptOffersByMeFunction(offerId: offerList[index].id!);
//                             },
//                             widgetInRejectButton: state is RejectOffersLoadingState ? Lottie.asset(OImages.loadingTwo) : Text('Reject', style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)),
//                             widgetInAcceptButton: state is AcceptOffersLoadingState ? Lottie.asset(OImages.loadingTwo) : Text('Accept', style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)),
//                             distance: offerList[index].distance!,
//                             serviceName: serviceNames,
//                             firstName: offerList[index].provider!.firstName!,
//                             lastName: offerList[index].provider!.lastName!,
//                             timingArrive: offerList[index].arrivalTime!,
//                             containerGradient: offerList[index].price == 0 ? AppGradients.redGradient : AppGradients.whiteGradient,
//                             textsColor: offerList[index].price == 0 ? OColors.whiteColor : OColors.greyScale700 ,
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//
//     /// Offers States (Waiting - Not Found).
//     // return SingleChildScrollView(
//     //   child: Padding(
//     //     padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
//     //     child: Column(
//     //       children: [
//     //
//     //         /// App Bar
//     //         AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Offers', actions: Container(), widthOfText: 280.w),
//     //
//     //         /// Make Space
//     //         SizedBox(height: 24.h),
//     //
//     //         SizedBox(
//     //           height: 41.h,
//     //           width: double.infinity,
//     //           child: Column(
//     //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     //             children: [
//     //               Text('Offers for you', style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
//     //               Container(
//     //                 height: 4.h,
//     //                 width: double.infinity,
//     //                 decoration: BoxDecoration(color: OColors.primaryColor500, borderRadius: BorderRadius.circular(100.r)),
//     //               ),
//     //             ],
//     //           ),
//     //         ),
//     //
//     //         /// Not Found Widget
//             // const NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: 'Not Found', description: 'Sorry, the keyword you entered cannot be found, please check again or search with another keyword.'),
//     //
//     //         /// Found Widget
//     //         const NotFoundAndFoundOffersWidget(emoji: OImages.foundIcon, title: 'Waiting for offers', description: 'Don\'t worry, we will find you Osta as soon as possible. Receive the offers and choose the most suitable for you. We wish you an enjoyable experience'),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key, required this.orderId});
  final int orderId;

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  @override
  void initState() {
    OffersOrdersCubit.get(context)
        .getAllOffersByMeFunction(orderId: widget.orderId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// Offers States (Waiting - Not Found).
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
        listener: (context, state) {
          if (state is AcceptOffersSuccessState) {
            OffersOrdersCubit.get(context)
                .getAllOffersByMeFunction(orderId: widget.orderId);
            context.pushNamedAndRemoveUntil(ORoutesName.inboxRoute,
                predicate: (route) => false,
                arguments: {
                  'orderId': widget.orderId,
                });
          } else if (state is AcceptOffersErrorState) {
            ODeviceUtils.showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!
                    .translate('youHaveAnAProblem')!,
                textStyle: OStyles.bodyLargeRegular,
                textColor: OColors.whiteColor,
                bgColor: OColors.error);
          } else if (state is RejectOffersSuccessState) {
            OffersOrdersCubit.get(context)
                .getAllOffersByMeFunction(orderId: widget.orderId);
            context.pushReplacementNamed(ORoutesName.navigationMenuRoute,
                arguments: 2);
          }
          if (state is RejectOffersErrorState) {
            ODeviceUtils.showSnackBar(
                context: context,
                message: AppLocalizations.of(context)!
                    .translate('youHaveAnAProblem')!,
                textStyle: OStyles.bodyLargeRegular,
                textColor: OColors.whiteColor,
                bgColor: OColors.error);
          }
        },
        builder: (context, state) {
          var offersOrdersCubit = OffersOrdersCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
            child: Column(
              children: [
                /// App Bar
                AppBarWidget(
                    leading: InkWellWidget(
                        onTap: () => context.pop(),
                        child: const Icon((Icons.arrow_back))),
                    title: AppLocalizations.of(context)!.translate('offers')!,
                    actions: SvgPicture.asset(OImages.moreIcon2),
                    widthOfText: 280.w),

                /// Make Space
                SizedBox(height: 24.h),

                SizedBox(
                  height: 41.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          AppLocalizations.of(context)!
                              .translate('offersForYou')!,
                          style: OStyles.bodyXLargeSemiBold
                              .copyWith(color: OColors.primaryColor500)),
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

                state is GetAllOffersLoadingState ||
                        offersOrdersCubit.getAllOffersToMeModel.offersList ==
                            null
                    ? LoadingWidget(iconColor: OColors.primaryColor500)
                    :
                    // const Center(child: NotFoundAndFoundOffersWidget(emoji: OImages.foundIcon, title: 'Waiting for offers', description: 'Don\'t worry, we will find you Osta as soon as possible. Receive the offers and choose the most suitable for you. We wish you an enjoyable experience')) :
                    offersOrdersCubit
                                .getAllOffersToMeModel.offersList!.isEmpty ||
                            state is GetAllOrdersErrorState
                        ? NotFoundAndFoundOffersWidget(
                            emoji: OImages.notFoundIcon,
                            title: AppLocalizations.of(context)!
                                .translate('notFound')!,
                            description: AppLocalizations.of(context)!
                                .translate('sorryTheKeyWord')!)
                        : Expanded(
                            child: ListView.builder(
                              itemCount: offersOrdersCubit
                                  .getAllOffersToMeModel.offersList!.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var offerList = offersOrdersCubit
                                    .getAllOffersToMeModel.offersList;
                                List<Services> services =
                                    offerList![index].provider!.services!;
                                String serviceNames = services
                                    .map((service) => service.name)
                                    .join(', ');

                                /// Make The Fist Letter is UpperCase
                                serviceNames = serviceNames.replaceAllMapped(
                                  RegExp(r'\b(\w)'),
                                  (match) => match.group(0)!.toUpperCase(),
                                );

                                return OfferWidget(
                                  offerModel: offerList[index],
                                );
                              },
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
