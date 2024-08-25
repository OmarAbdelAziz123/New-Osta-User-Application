import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta/features/booking/managers/booking_cubit.dart';
import 'package:osta/features/booking/presentation/screens/empty_upcoming_screen.dart';
import 'package:osta/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget.dart';
import 'package:osta/features/booking/presentation/widgets/my_booking_container_widget/order_widget.dart';
import 'package:osta/features/booking/presentation/widgets/show_location/show_location_for_user_screen.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/utils/constants/log_util.dart';

import '../../../../utils/constants/exports.dart';

class CurrentScreen extends StatefulWidget {
  const CurrentScreen({super.key});

  @override
  State<CurrentScreen> createState() => _CurrentScreenState();
}

class _CurrentScreenState extends State<CurrentScreen> {
  bool isExpanded = false;

  // late BookingCubit bookingCubit;

  @override
  void initState() {
    super.initState();
    BookingCubit.get(context).getOrdersByFilterFunction(status: 'accepted');
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
                      acceptedOrdersCubit
                              .getOrdersByFilterModel.orderModelList ==
                          null ||
                      acceptedOrdersCubit
                              .getOrdersByFilterModel.orderModelList!.data ==
                          null ||
                      acceptedOrdersCubit
                          .getOrdersByFilterModel.orderModelList!.data!.isEmpty
                  ? EmptyUpcomingScreen(
                      title: AppLocalizations.of(context)!
                          .translate('youHaveNoUpComingBooking')!,
                      description: AppLocalizations.of(context)!
                          .translate('youDoNotHaveAUpcomingBooking')!,
                    )
                  : RefreshIndicator(
                      child: ListView.builder(
                        itemCount: acceptedOrdersCubit.getOrdersByFilterModel
                            .orderModelList!.data!.length,
                        itemBuilder: (context, index) {
                          var ordersList = acceptedOrdersCubit
                              .getOrdersByFilterModel.orderModelList!.data;
                          return RefreshIndicator(
                              onRefresh: () => acceptedOrdersCubit
                                  .getOrdersByFilterFunction(status: 'done'),
                              child: OrderWidget(
                                orderModel: ordersList?[index],
                              ));
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
