import 'package:osta/utils/constants/exports.dart';

class PaymentContainerWidget extends StatelessWidget {
  const PaymentContainerWidget({super.key, required this.paymentIcon, required this.paymentName, required this.iconHeight});

  final String paymentIcon, paymentName;
  final double iconHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80.h,
      margin: EdgeInsets.only(bottom: 24.h),
      decoration: BoxDecoration(
        color: OColors.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [AppBoxShadows.cardShadowTwo],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(paymentIcon, fit: BoxFit.scaleDown, height: iconHeight),

          SizedBox(width: 12.w),

          SizedBox(width: 196.w, child: Text(paymentName, style: OStyles.h6Bold)),

          SizedBox(width: 12.w),

          Text('Connected', style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500))
        ],
      ),
    );
  }
}
