import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/presentation/screens/empty_upcoming_screen.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/my_booking_container_widget/my_booking_container_widget2.dart';
import 'package:osta_user_app/features/booking/presentation/widgets/show_location/show_location_for_user_screen.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import '../../../../utils/constants/exports.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  bool isExpanded = false;
  // late BookingCubit bookingCubit;

  @override
  void initState() {
    super.initState();
    BookingCubit.get(context).getOrdersByFilterFunction(status: 'pending');
    // BookingCubit.get(context).getOrdersByFilterFunction(status: 'accepted');
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
              : acceptedOrdersCubit.getOrdersByFilterModel.orderModelList ==
                          null ||
                      acceptedOrdersCubit
                              .getOrdersByFilterModel.orderModelList!.data ==
                          null ||
                      acceptedOrdersCubit
                          .getOrdersByFilterModel.orderModelList!.data!.isEmpty
                  ? EmptyUpcomingScreen(
                      title: AppLocalizations.of(context)!
                          .translate('youHaveNoCompleteBooking')!,
                      description: AppLocalizations.of(context)!
                          .translate('youDoNotHaveACounterBooking')!,
                    )
                  : RefreshIndicator(
                      onRefresh: () => BookingCubit.get(context)
                          .getOrdersByFilterFunction(status: 'pending'),
                      child: ListView.builder(
                        itemCount: acceptedOrdersCubit.getOrdersByFilterModel
                            .orderModelList!.data!.length,
                        itemBuilder: (context, index) {
                          var ordersList = acceptedOrdersCubit
                              .getOrdersByFilterModel.orderModelList!.data;

                          logSuccess(
                              '===================== ${ordersList![index].locationDesc}');

                          return OrderWidget(
                            orderModel: ordersList[index],
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
