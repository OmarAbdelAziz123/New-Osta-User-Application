import 'package:osta/utils/constants/exports.dart';

class ProductContainerWidget extends StatelessWidget {
  const ProductContainerWidget({super.key, required this.ostaName, required this.serviceName, required this.servicePrice, required this.serviceRate, required this.numberOfReviews});

  final String ostaName, serviceName, servicePrice, serviceRate, numberOfReviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ODeviceUtils.getScreenWidth(context) / 2.2,
      height: 120.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(ostaName, style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
              SvgPicture.asset(OImages.bookMarkIcon, width: 24.w, height: 24.h),
            ],
          ),
          SizedBox(height: 8.h),
          Text(serviceName, style: OStyles.h6Bold),
          SizedBox(height: 8.h),
          Text(servicePrice, style: OStyles.h6Bold.copyWith(color: OColors.primaryColor500)),
          SizedBox(height: 8.h),
          Row(
            children: [
              SvgPicture.asset(OImages.starIcon),
              SizedBox(width: 8.w),
              Text(serviceRate, style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
              SizedBox(width: 8.w),
              Text('|', style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
              SizedBox(width: 8.w),
              Text(numberOfReviews, style: OStyles.bodySmallMedium.copyWith(color: OColors.greyScale700)),
            ],
          ),
        ],
      ),
    );
  }
}
