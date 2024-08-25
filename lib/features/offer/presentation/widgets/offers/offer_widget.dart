import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/text_styles.dart';

import '../../../managers/offers_orders_cubit.dart';
import '../../../models/offers/get_all_offers_to_me_model.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
    this.offerModel,
  });

  final OfferModel? offerModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
      decoration: BoxDecoration(
        color: OColors.white,
        border: Border.all(
          color: OColors.grey,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(30.r),
        gradient: offerModel?.price == 0
            ? AppGradients.redGradient
            : AppGradients.whiteGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h,0, 10.h,),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 22.5.h,
                  child: offerModel?.provider?.personalMediaUrl==null?Image.asset(OImages.ostaImage):Image.network(offerModel!.provider!.personalMediaUrl!),
                ),

                SizedBox(width: 15.w),
                Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${offerModel?.provider?.firstName ?? 'Ahmed'} ${offerModel?.provider?.lastName ?? 'Mohamed'}',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: offerModel?.price != 0
                                ? OColors.grey2
                                : OColors.white,
                          ),
                        ),

                        Padding(
                          padding:  EdgeInsets.only(top: 4.h,bottom: 8.h),
                          child: Text(
                              offerModel?.provider?.services
                                      ?.map((service) => service.name)
                                      .join(', ') ??
                                  'Service',
                              style: AppTextStyles.boLd17.copyWith(
                                color: offerModel?.price != 0
                                    ? OColors.black
                                    : OColors.white,
                              ),
                              overflow: TextOverflow.ellipsis),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.star,
                              color: OColors.yellowColor,
                              size: 22.sp,
                            ),
                            SizedBox(width: 5.w),
                            Text('4.5 | 495',
                                // '${offerModel?.provider?.rating ?? '-'} | ${offerModel?.provider?.ratingCount ?? '-'}',
                                style: AppTextStyles.bold11.copyWith(
                                  color: offerModel?.price != 0
                                      ? OColors.grey2
                                      : OColors.white,
                                )),
                          ],
                        ),
                          Padding(
                            padding:  EdgeInsets.only(top: 14.h,bottom: 14.h),
                            child: FittedBox(
                              child: Text.rich(
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: offerModel?.price != 0?OColors.grey2:OColors.white
                                ),
                                TextSpan(text: offerModel?.price != 0?"Presented Offer: ":"Price is shown down", children: [
                                  if (offerModel?.price != 0)
                                  TextSpan(
                                    text: "${offerModel?.price ?? 30}\$",
                                    style: AppTextStyles.boLd17.copyWith(
                                      color: OColors.primary
                                    ),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        FittedBox(
                          child: Text('has completed 16 offer',
                              style: AppTextStyles.regularStyle.copyWith(
                                color: offerModel?.price == 0
                                    ? OColors.yellowColor
                                    : OColors.green,
                              )),
                        ),
                      ],
                    )),
                SizedBox(width: 10.w),
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              size: 22.sp,
                              color: offerModel?.price == 0?OColors.white:OColors.grey3,
                            ),
                            FittedBox(
                              child: Text.rich(
                                style: AppTextStyles.regularStyle.copyWith(
                                  color: offerModel?.price == 0?OColors.white:OColors.black
                                ),
                                TextSpan(
                                    text:
                                        formatLargeNumber((offerModel?.distance)),
                                    children: [
                                      TextSpan(
                                        text: " Km",
                                        style: AppTextStyles.regular12.copyWith(
                                          color: offerModel?.price == 0?OColors.white:OColors.primary,
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 15.w),
                              decoration: BoxDecoration(
                                color: OColors.primaryColor500,
                                borderRadius: BorderRadius.horizontal(left: Radius.circular(100.r)),
                              ),
                              child: FittedBox(
                                child: Text.rich(
                                  textAlign: TextAlign.center,
                                  style: AppTextStyles.regularStyle.copyWith(
                                    color: OColors.white,
                                    fontSize: 10.sp,
                                  ),
                                  TextSpan(text: "will come\n", children: [
                                    TextSpan(
                                      text: (offerModel?.arrivalTime ?? 'Now')=='Now'?'Now':("after\n${offerModel!.arrivalTime}"),
                                      style: AppTextStyles.boLd16.copyWith(
                                        color: OColors.white,
                                      ),
                                    )
                                  ]),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
          if (offerModel?.price == 0)
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  Divider(
                    height: 10.h,
                    thickness: 1.h,
                    color: OColors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      "You haven't specified enough data to recognize the problem so that's an examination offer.",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: OColors.white,
                        fontSize: 13.sp,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning,
                        color: OColors.yellowColor,
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Flexible(
                        child: Text(
                          "Inspection fee is 10\$, and if the service is performed it isn't charged",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.regularStyle.copyWith(
                            color: OColors.yellow,
                            fontSize: 8.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Divider(
              height: 0,
              thickness: 1.h,
              color: OColors.grey,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    OffersOrdersCubit.get(context)
                        .acceptOffersByMeFunction(offerId: offerModel!.id!);
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Accept',
                      textAlign: TextAlign.end,
                      style: AppTextStyles.regularStyle.copyWith(
                          fontSize: 17.sp,
                          color: offerModel?.price == 0
                              ? OColors.white
                              : OColors.primary),
                    ),
                  ),
                ),
              ),
              Container(
                height: 60.h,
                width: 1.h,
                color: OColors.grey,
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    OffersOrdersCubit.get(context)
                        .rejectOffersByMeFunction(offerId: offerModel!.id!);
                  },
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'Reject',
                      textAlign: TextAlign.end,
                      style: AppTextStyles.regularStyle.copyWith(
                          fontSize: 17.sp,
                          color: offerModel?.price == 0
                              ? OColors.black
                              : OColors.red),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

String formatLargeNumber(String? numStr) {
  try {
    if (numStr == null || numStr.isEmpty) {
      return '0';
    }
    double num = double.parse(numStr);
    double absNum = num.abs();

    if (absNum >= 1e12) {
      return '${(num / 1e12).toStringAsFixed(1)}T';
    } else if (absNum >= 1e9) {
      return '${(num / 1e9).toStringAsFixed(1)}B';
    } else if (absNum >= 1e6) {
      return '${(num / 1e6).toStringAsFixed(1)}M';
    } else if (absNum >= 1e3) {
      return '${(num / 1e3).toStringAsFixed(1)}k';
    } else {
      return num.toStringAsFixed(1);
    }
  } catch (e) {
    return 'Invalid input';
  }
}
