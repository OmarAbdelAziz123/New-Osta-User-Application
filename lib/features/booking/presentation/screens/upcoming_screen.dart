import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/presentation/screens/empty_upcoming_screen.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget2.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/show_location/show_location_for_user_screen.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../utils/constants/exports.dart';

class UpcomingScreen extends StatefulWidget {
  const UpcomingScreen({super.key});

  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  bool isExpanded = false;
  // late BookingCubit bookingCubit;

  @override
  void initState() {
    // BookingCubit().getOrdersByFilterFunction(status: 'accepted');
    super.initState();
    // bookingCubit = BookingCubit();
    BookingCubit.get(context).getOrdersByFilterFunction(status: 'accepted');
    // BookingCubit.get(context).getReceiptFunction(orderId: widget.orderId);
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
              acceptedOrdersCubit.getOrdersByFilterModel.result == null ||
              acceptedOrdersCubit.getOrdersByFilterModel.result!.data == null ||
              acceptedOrdersCubit.getOrdersByFilterModel.result!.data!.isEmpty
              ? EmptyUpcomingScreen(
            title: AppLocalizations.of(context)!.translate('youHaveNoCompleteBooking')!,
            description: AppLocalizations.of(context)!.translate('youDoNotHaveACounterBooking')!,
          )
              : RefreshIndicator(
            onRefresh: () => BookingCubit.get(context).getOrdersByFilterFunction(status: 'accepted'),
            child: ListView.builder(
              itemCount: acceptedOrdersCubit.getOrdersByFilterModel.result!.data!.length,
              itemBuilder: (context, index) {
                var ordersList = acceptedOrdersCubit.getOrdersByFilterModel.result!.data;

                logSuccess('===================== ${ordersList![index].locationDesc}');

                return MyBookingContainerWidget2(
                  // bookingImage: OConstants.bookingImage[index],
                  providerImage: ordersList[index].images == null || ordersList[index].images!.contains('https://osta.magdsofteg.xyz/storage/39/1.jpeg') || ordersList[index].images!.isEmpty ? Lottie.asset(OImages.noImage) : ordersList[index].images![0].isEmpty ? Image.asset(OImages.myBooking1, fit: BoxFit.scaleDown) : Image.network(ordersList[index].images![0], fit: BoxFit.scaleDown),
                  bookingJob: ODeviceUtils.capitalizeFirstLetter(ordersList[index].service!.category!),
                  bookingName: ODeviceUtils.capitalizeFirstLetter(ordersList[index].service!.name!),
                  containerColor: OColors.primaryColor500,
                  buttonText: ordersList[index].status! == 'accepted' ? 'Accepted' : 'accepted',
                  showDetailsBooking: isExpanded,
                  locationDescription: ordersList[index].locationDesc ?? AppLocalizations.of(context)!.translate('locationDescriptionIsEmpty')!,
                  price: ordersList[index].price == 0 ? 0 : ordersList[index].price?.toDouble(),
                  mapWidget: ShowLocationForUserScreen(map: {
                    'lat': ordersList[index].locationLatitude == '0' ? '0' : ordersList[index].locationLatitude,
                    'lng': ordersList[index].locationLongitude ==  '0'? '0' : ordersList[index].locationLongitude,
                    'name': ordersList[index].locationDesc.toString() ?? '',
                  }),
                  /// pop
                  onYesCancelButton: () {
                    logWarning('Yes');
                  },
                  /// Go to Inbox Screen
                  onTap: () async {
                    context.pushNamed(ORoutesName.inboxRoute, arguments: {
                      'orderId': ordersList[index].id.toString(),
                      // 'userName': ordersList[index].order!.user!.name!,
                      // 'status': ordersList[index].order!.status!,
                      // 'phone': ordersList[index].order!.user!.phone!,
                      'locationLatitude': ordersList[index].locationLongitude,
                      'locationLongitude': ordersList[index].locationLongitude!,
                      'name': ordersList[index].locationDesc ?? '',
                      'maxAllowedPrice': ordersList[index].maxAllowedPrice ?? '',
                    });
                  },
                  isAccepted: true,
                  isCompleted: false,
                  thirdButtonWidget: ThirdButtonWidget(
                    isRejected: false,
                    widgetInButton: GestureDetector(
                      onTap: () {
                        logWarning('Yes');
                      },
                      child: Text('df', style: OStyles.bodyMediumSemiBold.copyWith(color: Colors.white)),
                    ),
                    textStyle: OStyles.bodyMediumSemiBold,
                    containerColor: OColors.primaryColor500,
                    width: double.infinity,
                    height: ODeviceUtils.getScreenHeight(context) / 8,
                    borderRadius: 100.r,
                    onTap: () {
                      logWarning('Yes');
                    },
                  ),
                  viewReceiptTap: () {
                    context.pushNamed(ORoutesName.receiptRoute, arguments: {
                      'orderId': ordersList[index].id.toString(),
                    });
                  },
                  viewReceiptTap2: () {

                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
