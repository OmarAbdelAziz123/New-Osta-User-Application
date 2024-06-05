import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget2.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import '../../../../utils/constants/exports.dart';

class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var inboxCubit = OffersOrdersCubit.get(context);

        return SizedBox(
          width: double.infinity,
          child: BlocProvider(
            create: (context) =>
            BookingCubit()..getOrdersByFilterFunction(status: 'accepted'),
            child: BlocBuilder<BookingCubit, BookingState>(
              builder: (context, state) {
                var acceptedOrdersCubit = BookingCubit.get(context);

                return state is GetOrderByFilterLoadingState
                    ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
                    : acceptedOrdersCubit.getOrdersByFilterModel == null ||
                    acceptedOrdersCubit.getOrdersByFilterModel.result == null ||
                    acceptedOrdersCubit.getOrdersByFilterModel.result!.data == null ||
                    acceptedOrdersCubit.getOrdersByFilterModel.result!.data!.isEmpty
                    ? Text('Empty')
                    : ListView.builder(
                  itemCount: acceptedOrdersCubit.getOrdersByFilterModel.result!.data!.length,
                  itemBuilder: (context, index) {
                    var ordersList = acceptedOrdersCubit.getOrdersByFilterModel.result!.data;

                    return MyBookingContainerWidget2(
                      // bookingImage: OConstants.bookingImage[index],
                      providerImage: ordersList![index].images == null || ordersList[index].images!.isEmpty ? Lottie.asset(OImages.loadingImages) : ordersList[index].images![0].isEmpty ? Image.asset(OImages.myBooking1, fit: BoxFit.scaleDown) : Image.network(ordersList[index].images![0], fit: BoxFit.scaleDown),
                      bookingJob: ordersList[index].service!.category!,
                      bookingName: ordersList[index].service!.name!,
                      containerColor: OColors.primaryColor500,
                      buttonText: ordersList[index].status!,
                      onTap: () {
                        // inboxCubit.
                        context.pushNamed(ORoutesName.inboxRoute, arguments: {
                          'orderId': ordersList[index].id,
                        });
                      },
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
