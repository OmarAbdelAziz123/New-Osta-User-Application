import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/presentation/screens/empty_upcoming_screen.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget2.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/show_location/show_location_for_user_screen.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

import '../../../../utils/constants/exports.dart';

class CompletedScreen extends StatefulWidget {
  const CompletedScreen({super.key});

  @override
  State<CompletedScreen> createState() => _CompletedScreenState();
}

class _CompletedScreenState extends State<CompletedScreen> {
  bool isExpanded = false;

  // late BookingCubit bookingCubit;

  @override
  void initState() {
    // BookingCubit.get(context).getOrdersByFilterFunction(status: 'done');
    super.initState();
    // bookingCubit = BookingCubit();
    // bookingCubit.getOrdersByFilterFunction(status: 'done');
    BookingCubit.get(context).getOrdersByFilterFunction(status: 'done');
  }

  @override
  void dispose() {
    // bookingCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: BlocBuilder<BookingCubit, BookingState>(
        builder: (context, state) {
          var acceptedOrdersCubit = BookingCubit.get(context);

          return state is GetOrderByFilterLoadingState
              ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
              : acceptedOrdersCubit.getOrdersByFilterModel == null ||
                      acceptedOrdersCubit.getOrdersByFilterModel.result ==
                          null ||
                      acceptedOrdersCubit.getOrdersByFilterModel.result!.data ==
                          null ||
                      acceptedOrdersCubit
                          .getOrdersByFilterModel.result!.data!.isEmpty
                  ? const EmptyUpcomingScreen(
                      title: 'You have no upcoming booking',
                      description:
                          'You do not have a upcoming booking. Make a new booking by clicking the button home',
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                        itemCount: acceptedOrdersCubit
                            .getOrdersByFilterModel.result!.data!.length,
                        itemBuilder: (context, index) {
                          var ordersList = acceptedOrdersCubit
                              .getOrdersByFilterModel.result!.data;

                          // return MyBookingContainerWidget2(
                          //   // bookingImage: OConstants.bookingImage[index],
                          //   providerImage: ordersList![index].images == null || ordersList[index].images!.contains('https://osta.magdsofteg.xyz/storage/39/1.jpeg') || ordersList[index].images!.isEmpty ? Lottie.asset(OImages.loadingImages) : ordersList[index].images![0].isEmpty ? Image.asset(OImages.myBooking1, fit: BoxFit.scaleDown) : Image.network(ordersList[index].images![0], fit: BoxFit.scaleDown),
                          //   bookingJob: ordersList[index].service!.category!,
                          //   bookingName: ordersList[index].service!.name!,
                          //   containerColor: OColors.primaryColor500,
                          //   buttonText: ordersList[index].status!,
                          //   onTap: () {
                          //     // inboxCubit.
                          //     context.pushNamed(ORoutesName.inboxRoute, arguments: {
                          //       'orderId': ordersList[index].id,
                          //     });
                          //   },
                          // );
                          return RefreshIndicator(
                            onRefresh: () => acceptedOrdersCubit
                                .getOrdersByFilterFunction(status: 'done'),
                            child: MyBookingContainerWidget2(
                              // bookingImage: OConstants.bookingImage[index],
                              providerImage: ordersList![index].images == null || ordersList[index].images!.contains('https://osta.magdsofteg.xyz/storage/39/1.jpeg') || ordersList[index].images!.isEmpty
                                  ? Lottie.asset(OImages.noImage)
                                  : ordersList[index].images![0].isEmpty
                                      ? Image.asset(OImages.myBooking1,
                                          fit: BoxFit.scaleDown)
                                      : Image.network(
                                          ordersList[index].images![0],
                                          fit: BoxFit.scaleDown),
                              bookingJob: ODeviceUtils.capitalizeFirstLetter(ordersList[index].service!.category!),
                              bookingName: ordersList[index].service!.name!,
                              containerColor: OColors.success,
                              buttonText: ordersList[index].status! == 'done'
                                  ? 'Done'
                                  : 'Done',
                              showDetailsBooking: isExpanded,
                              locationDescription:
                                  ordersList[index].locationDesc ?? 'Location description is empty',
                              price: ordersList[index].price == 0
                                  ? 0
                                  : ordersList[index].price?.toDouble(),
                              mapWidget: ShowLocationForUserScreen(map: {
                                'lat':
                                    ordersList[index].locationLatitude == '0'
                                        ? '0'
                                        : ordersList[index].locationLatitude,
                                'lng':
                                    ordersList[index].locationLongitude == '0'
                                        ? '0'
                                        : ordersList[index].locationLongitude,
                                'name': ordersList[index]
                                        .locationDesc
                                        .toString() ??
                                    '',
                              }),
                              onYesCancelButton: () {
                                logError('Error');

                              },
                              onTap: () async {
                                // inboxCubit.
                                context.pushNamed(ORoutesName.inboxRoute,
                                    arguments: {
                                      'orderId': ordersList[index].id,
                                    });
                              },
                              isAccepted: false,
                              isCompleted: true,
                              thirdButtonWidget: ThirdButtonWidget(
                                isRejected: false,
                                widgetInButton: Text('View E-Receipts', style: OStyles.bodyMediumSemiBold.copyWith(color: Colors.white)),
                                textStyle: OStyles.bodyMediumSemiBold,
                                containerColor: OColors.primaryColor500,
                                width: double.infinity,
                                height: ODeviceUtils.getScreenHeight(context) / 28,
                                borderRadius: 100.r,
                                onTap: () {
                                  context.pushNamed(ORoutesName.receiptRoute, arguments: {
                                    'orderId': ordersList[index].id.toString(),
                                  });
                                },
                              ),
                              viewReceiptTap: () {
                                logError('Error');
                                context.pushNamed(ORoutesName.receiptRoute, arguments: {
                                  'orderId': ordersList[index].id.toString(),
                                });
                              },
                              viewReceiptTap2: () {
                                logError('Error');
                              },
                            ),
                          );
                          // return MyBookingContainerWidget(
                          //   providerImage: ordersList![index].images == null || ordersList[index].images!.contains('https://osta.magdsofteg.xyz/storage/39/1.jpeg') || ordersList[index].images!.isEmpty ? Lottie.asset(OImages.noImage) : ordersList[index].images![0].isEmpty ? Image.asset(OImages.myBooking1, fit: BoxFit.scaleDown) : Image.network(ordersList[index].images![0], fit: BoxFit.scaleDown),
                          //   bookingJob: ordersList![index].service!.category!,
                          //   bookingName: ordersList[index].service!.name!,
                          //   containerColor: OColors.success,
                          //   buttonText: ordersList[index].status! == 'done' ? 'Done' : 'done',
                          // );
                        },
                      ),
                      onRefresh: () => acceptedOrdersCubit
                          .getOrdersByFilterFunction(status: 'done'),
                    );
        },
      ),
    );
  }
}
