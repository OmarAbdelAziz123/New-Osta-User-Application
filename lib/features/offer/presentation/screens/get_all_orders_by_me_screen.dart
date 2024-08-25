import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/features/offer/presentation/widgets/offers/not_found_and_found_offers_widget.dart';
import 'package:osta/features/offer/presentation/widgets/orders/order_widget.dart';
import 'package:osta/utils/constants/exports.dart';

class GetAllOrdersByMeScreen extends StatefulWidget {
  const GetAllOrdersByMeScreen({super.key});

  @override
  State<GetAllOrdersByMeScreen> createState() => _GetAllOrdersByMeScreenState();
}

class _GetAllOrdersByMeScreenState extends State<GetAllOrdersByMeScreen> {

  @override
  void initState() {
    if(OffersOrdersCubit.get(context).getAllOrdersToMeModel.result == null) OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: BlocBuilder<OffersOrdersCubit, OffersOrdersState>(
        builder: (context, state) {
          var offersOrdersCubit = OffersOrdersCubit.get(context);

          return Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
            child: Column(
              children: [
                /// App Bar
                AppBarWidget(
                    leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown),
                    title: AppLocalizations.of(context)!.translate('myOrders')!, actions: Container(),
                    widthOfText: 280.w),

                /// Make Space
                SizedBox(height: 24.h),

                SizedBox(
                  height: 41.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppLocalizations.of(context)!.translate('ordersForYou')!, style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.primaryColor500)),
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

                offersOrdersCubit.getAllOrdersToMeModel == null
                    || offersOrdersCubit.getAllOrdersToMeModel.result == null
                    || offersOrdersCubit.getAllOrdersToMeModel.result!.data == null
                    ? Center(child: LoadingWidget(iconColor: OColors.primaryColor500))
                    :  offersOrdersCubit.getAllOrdersToMeModel.result!.data!.isEmpty ?
                NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: AppLocalizations.of(context)!.translate('notFound')!, description: AppLocalizations.of(context)!.translate('sorryTheKeyWord')!)
                    : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () {
                      return offersOrdersCubit.getAllOrdersByMeFunction();
                    },
                    child: ListView.builder(
                      itemCount: offersOrdersCubit.getAllOrdersToMeModel.result!.data!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var orderList = offersOrdersCubit.getAllOrdersToMeModel.result!.data;
                        List<String> imageUrls = [];
                        for (var element in orderList![index].images!) {
                          imageUrls.add(element);
                        }

                        print(imageUrls);
                        return orderList[index].status == 'pending' ? OrderWidget(
                          warranty: orderList[index].warrantyId == null ? 'Warranty' : orderList[index].warrantyId == '1' ? '30 days' : orderList[index].warrantyId == '2' ? '60 days' : orderList[index].warrantyId == '3' ? '90 days' : 'Warranty',
                          serviceName: orderList[index].service!.name!,
                          maxAllowedPrice: orderList[index].maxAllowedPrice.toString(),
                          status: orderList[index].status ?? 'Status',
                          imageUrls: imageUrls,
                          description: orderList[index].desc,
                          orderRef: orderList[index].id!,
                          onTap: () => context.pushNamed(ORoutesName.offersRoute, arguments: orderList[index].id),
                          totalPendingOffers: orderList[index].totalPendingOffers!,
                        ) : NotFoundAndFoundOffersWidget(emoji: OImages.notFoundIcon, title: AppLocalizations.of(context)!.translate('notFoundPendingOrders')!, description: AppLocalizations.of(context)!.translate('sorryTheKeyWord')!);
                      },
                    ),
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
