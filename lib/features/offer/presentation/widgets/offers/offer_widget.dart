import 'package:osta_user_app/utils/constants/exports.dart';

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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      margin: EdgeInsets.only(bottom: 15.h, top: 15.h),
      decoration: BoxDecoration(
        color: OColors.white,
        border: Border.all(
          color: OColors.grey,
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [AppBoxShadows.cardShadowTwo],
        gradient: offerModel?.price == 0
            ? AppGradients.redGradient
            : AppGradients.whiteGradient,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(OImages.ostaImage),
              SizedBox(width: 10.w),
              Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${offerModel?.provider?.firstName ?? 'Ahmed'} ${offerModel?.provider?.lastName ?? 'Mohamed'}',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w600),
                      ),
                      Text(
                          offerModel?.provider?.services
                                  ?.map((service) => service.name)
                                  .join(', ') ??
                              'Service',
                          style: OStyles.h6Bold,
                          overflow: TextOverflow.ellipsis),
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
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: offerModel?.price != 0
                                    ? OColors.greyScale600
                                    : OColors.white,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      if (offerModel?.price != 0)
                        FittedBox(
                          child: Text.rich(
                            style: TextStyle(
                              color: OColors.blackColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            TextSpan(text: "Presented Offer: ", children: [
                              TextSpan(
                                text: "${offerModel?.price ?? 30}\$",
                                style: TextStyle(
                                  color: OColors.primary,
                                  fontSize: 17.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ]),
                          ),
                        ),
                      SizedBox(height: 4.h),
                      FittedBox(
                        child: Text('has completed 16 offer',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: offerModel?.price == 0
                                  ? OColors.yellowColor
                                  : OColors.green,
                              fontWeight: FontWeight.w600,
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
                            color: OColors.greyScale500,
                          ),
                          FittedBox(
                            child: Text.rich(
                              style: TextStyle(
                                color: OColors.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                              TextSpan(
                                  text:
                                      formatLargeNumber((offerModel?.distance)),
                                  children: [
                                    TextSpan(
                                      text: " Km",
                                      style: TextStyle(
                                        color: OColors.primary,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            decoration: BoxDecoration(
                              color: OColors.primaryColor500,
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: FittedBox(
                              child: Text.rich(
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: OColors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                                TextSpan(text: "Will\ncome\n", children: [
                                  TextSpan(
                                    text: offerModel?.arrivalTime ?? 'Now',
                                    style: TextStyle(
                                      color: OColors.white,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w800,
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
          if (offerModel?.price == 0)
            Column(
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
                    style: TextStyle(
                      color: OColors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: OColors.redColor,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(
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
                          "The inspection fee is 10\$ and if the service is performed it won't be charged",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: OColors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Padding(
            padding: EdgeInsets.only(top: 10.h),
            child: Divider(
              height: 0,
              thickness: 1.h,
              color: OColors.grey,
            ),
          ),
          SizedBox(
            height: 40.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      OffersOrdersCubit.get(context)
                          .acceptOffersByMeFunction(offerId: offerModel!.id!);
                    },
                    child: Container(
                      height: 40.h,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Accept',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: offerModel?.price == 0
                                ? OColors.white
                                : OColors.blueColor),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100.h,
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
                      height: 40.h,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Reject',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: offerModel?.price == 0
                                ? OColors.blackColor
                                : OColors.redColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
