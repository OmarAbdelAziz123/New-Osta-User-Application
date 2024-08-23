import 'package:osta_user_app/features/offer/presentation/widgets/offers/offer_widget.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

import '../../../../../utils/constants/exports.dart';
import '../../../../home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import '../../../../offer/presentation/widgets/inbox/audio_player_widget.dart';
import '../../../models/get_orders_by_filter_model.dart';
import '../details_booking2.dart';

class OrderWidget extends StatefulWidget {
  OrderWidget({
    Key? key,
    this.orderModel,
  }) : super(key: key);

  OrderModel? orderModel;

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool showDetailsBooking = false;
  @override
  Widget build(BuildContext context) {
    logSuccess("msg order ${widget.orderModel?.toJson()}");
    return AnimatedCrossFade(
      firstChild: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.w,
        ),
        // padding: EdgeInsets.all(20.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: OColors.whiteColor,
          border: Border.all(color: OColors.grey),
          boxShadow: [
            BoxShadow(
                color: const Color(0x22000012),
                blurRadius: 10.h,
                spreadRadius: 3.h)
          ],
        ),
        child: ShrinkOrderView(
          onTap: () {
            setState(() {
              showDetailsBooking = !showDetailsBooking;
            });
          },
          orderModel: widget.orderModel,
          showDetailsBooking: showDetailsBooking,
        ),
      ),
      secondChild: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 24.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                // margin: EdgeInsets.symmetric(
                //   horizontal: 24.w,
                //   vertical: 24.w,
                // ),
                // padding: EdgeInsets.all(20.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: OColors.whiteColor,
                  border: Border.all(color: OColors.grey),
                  boxShadow: [
                    BoxShadow(
                        color: const Color(0x22000012),
                        blurRadius: 10.h,
                        spreadRadius: 3.h)
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ShrinkOrderView(
                        onTap: () {
                          setState(() {
                            showDetailsBooking = !showDetailsBooking;
                          });
                        },
                        orderModel: widget.orderModel,
                        showDetailsBooking: showDetailsBooking,
                      ),
                      AnimatedCrossFade(
                        firstChild: Container(),
                        secondChild: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (widget.orderModel?.subServices != null &&
                                  widget.orderModel!.subServices!.isNotEmpty)
                                SizedBox(
                                  height: 65.h,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: widget
                                            .orderModel?.subServices?.length ??
                                        0,
                                    itemBuilder: (context, index) =>
                                        SubServicesWidget(
                                      subServiceName: widget.orderModel
                                              ?.subServices?[index].name ??
                                          '',
                                      onTap: () {},
                                      numberOfPieces:
                                          "${widget.orderModel?.subServices?[index].quantity ?? '0'}",
                                      onPressed: () {},
                                    ),
                                    separatorBuilder: (context, index) =>
                                        SizedBox(
                                      width: 10.w,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: 15.h,
                              ),
                              if (widget.orderModel?.desc != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        AppLocalizations.of(context)
                                                ?.translate('serviceDetails') ??
                                            'Service Details',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      height: 6.h,
                                    ),
                                    Text(widget.orderModel?.desc ?? "",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(fontSize: 14.sp)),
                                  ],
                                ),
                              if (widget.orderModel?.voiceDesc != null &&
                                  widget.orderModel!.voiceDesc != '')
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 12.h),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: OColors.grey,
                                  ),
                                  child: AudioPlayerWidget(
                                    url: widget.orderModel!.voiceDesc!,
                                    isMe: false,
                                    isInbox: false,
                                  ),
                                ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 12.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: OColors.grey,
                                ),
                                child: Text(
                                    widget.orderModel?.status == 'pending'
                                        ? "The requests will be displayed on the same screen"
                                        : widget.orderModel?.status ==
                                                'accepted'
                                            ? "Current"
                                            : "Finished",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: OColors.redColor)),
                              ),
                            ],
                          ),
                        ),
                        crossFadeState: showDetailsBooking
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.orderModel?.offers != null &&
                  widget.orderModel!.offers!.isNotEmpty)
                ListView.separated(
                  itemCount: widget.orderModel!.isThereMore!
                      ? widget.orderModel!.offers!.length + 1
                      : widget.orderModel!.offers!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => index != 2
                      ? OfferWidget(
                          offerModel: widget.orderModel?.offers?[index],
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 12.h),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.w, vertical: 20.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: OColors.primary,
                          ),
                          child: Text(
                            "More",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: OColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  separatorBuilder: (context, index) => SizedBox(
                    height: 10.h,
                  ),
                ),
            ],
          ),
        ),
      ),
      crossFadeState: showDetailsBooking
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

class IconTitleValueWidget extends StatelessWidget {
  const IconTitleValueWidget({
    super.key,
    this.icon,
    required this.title,
    required this.value,
    this.valueSuffix,
    this.valueColor,
  });

  final String? icon;
  final String title;
  final String value;
  final String? valueSuffix;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (icon != null) SvgPicture.asset(icon!),
            SizedBox(width: 10.w),
            Text(AppLocalizations.of(context)?.translate('$title') ?? 'title',
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey)),
          ],
        ),
        Text.rich(
          style: TextStyle(
            color: valueColor ?? OColors.blackColor,
            fontSize: 17.sp,
            fontWeight: FontWeight.w800,
          ),
          TextSpan(text: value, children: [
            if (valueSuffix != null)
              TextSpan(
                text: valueSuffix,
                style: TextStyle(
                  color: OColors.blackColor,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w800,
                ),
              )
          ]),
        ),
      ],
    );
  }
}

class ShrinkOrderView extends StatelessWidget {
  const ShrinkOrderView({
    super.key,
    this.onTap,
    this.orderModel,
    required this.showDetailsBooking,
  });

  final void Function()? onTap;
  final OrderModel? orderModel;
  final bool showDetailsBooking;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              color: OColors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderModel?.service?.name ?? "",
                    style: TextStyle(
                        fontSize: 17.sp, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'O.N ',
                              style: TextStyle(
                                fontSize: 14.sp,
                              )),
                          TextSpan(
                              text: "${orderModel?.id ?? 0}",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(showDetailsBooking
                        ? OImages.arrowUpIOS
                        : OImages.arrowDownIOS),
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () => context.pushNamed(ORoutesName.offersRoute,
              arguments: orderModel?.id),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Column(
              children: [
                Row(
                  children: [
                    if (orderModel?.warrantyId != null)
                      Expanded(
                        child: IconTitleValueWidget(
                          icon: OImages.icWarranty,
                          title: 'warranty',
                          value:
                              '${orderModel?.warrantyId == "1" ? 30 : orderModel?.warrantyId == "2" ? 60 : 90}',
                        ),
                      ),
                    if (orderModel?.warrantyId != null)
                      SizedBox(
                        width: 10.w,
                      ),
                    Expanded(
                      child: IconTitleValueWidget(
                        icon: OImages.icStatus,
                        title: 'status',
                        value: orderModel?.status ?? '',
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                IconTitleValueWidget(
                  icon: OImages.icMaxPrice,
                  title: 'maxAllowedPrice',
                  value: "${orderModel?.maxAllowedPrice ?? ''}",
                  valueSuffix: " \$",
                  valueColor: OColors.primaryColor500,
                ),
                SizedBox(
                  height: 12.h,
                ),
                IconTitleValueWidget(
                  title: 'offers',
                  value: "${orderModel?.totalPendingOffers ?? ''}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
