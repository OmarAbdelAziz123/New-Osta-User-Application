import 'package:osta/features/offer/presentation/widgets/offers/offer_widget.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:osta/utils/constants/text_styles.dart';

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
          vertical: 12.h,
        ),
        // padding: EdgeInsets.all(20.h),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color: OColors.whiteColor,
          border: Border.all(color: OColors.grey),
          boxShadow: [
            BoxShadow(
                color: const Color.fromARGB(7, 0, 0, 0),
                offset: Offset(0, 3),
                blurRadius: 5.h,
                spreadRadius: 0)
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
          vertical: 12.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: OColors.whiteColor,
                  border: Border.all(color: OColors.grey),
                  boxShadow: [
                    BoxShadow(
                        color: const Color.fromARGB(7, 0, 0, 0),
                        offset: Offset(0, 3),
                        blurRadius: 5.h,
                        spreadRadius: 0)
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
                                Center(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 12.h),
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
                                ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 12.h),
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
                                    style: AppTextStyles.regular12.copyWith(
                                      color: OColors.red,
                                    )),
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
                              horizontal: 20.w, vertical: 15.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100.r),
                            color: OColors.primary,
                          ),
                          child: Text(
                            "More",
                            textAlign: TextAlign.center,
                            style: AppTextStyles.boLd16.copyWith(
                              color: OColors.white
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
            Text("${AppLocalizations.of(context)?.translate('$title') ?? 'title'} : ",
                style:AppTextStyles.regularStyle.copyWith(
                  color:  Colors.grey
                )),
          ],
        ),
        Text.rich(
          style: AppTextStyles.boldStyle.copyWith(
            color: valueColor ?? OColors.blackColor,
            fontSize: valueSuffix != null?17.sp:14.sp,
          ),
          TextSpan(text: value, children: [
            if (valueSuffix != null)
              TextSpan(
                text: valueSuffix,
                style: AppTextStyles.boLd17,
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
            padding: EdgeInsets.fromLTRB(25.w,18.h,12.w,12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
              color: OColors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(orderModel?.service?.name ?? "",
                    style: AppTextStyles.boLd17),
                Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: 'O.N ',
                              style: AppTextStyles.regularStyle),
                          TextSpan(
                              text: "${orderModel?.id ?? 0}",
                              style: AppTextStyles.boLd14),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(showDetailsBooking
                        ? OImages.arrowUpIOS
                        : OImages.arrowDownIOS,
                      height: 15.sp,
                      width: 27.sp,
                      colorFilter: ColorFilter.mode(OColors.primary, BlendMode.srcIn),),
                  ],
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: (){
            switch(orderModel?.status){
              case "accepted":
                context.pushNamed(ORoutesName.inboxRoute,
                    arguments: {
                      'orderId':orderModel?.id,
                    });
                break;
              case "done":
                context.pushNamed(ORoutesName.receiptRoute,
                    arguments: {
                      'orderId':orderModel?.id,
                    });
                break;
              default:

              context.pushNamed(ORoutesName.offersRoute,
              arguments: orderModel?.id);
              break;
            }

          },
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
                        title: 'offers',
                        value: "${orderModel?.totalPendingOffers ?? ''}",
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
