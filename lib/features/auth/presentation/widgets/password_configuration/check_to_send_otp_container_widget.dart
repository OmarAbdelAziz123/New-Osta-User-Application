import 'package:osta/utils/constants/exports.dart';

class CheckToSendOTPContainerWidget extends StatelessWidget {
  const CheckToSendOTPContainerWidget({super.key, required this.logo, required this.connectionType, required this.detailsText, required this.onTap, required this.borderColor});

  final String logo, connectionType, detailsText;
  final void Function() onTap;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        width: double.infinity,
        height: 128.h,
        padding: EdgeInsets.only(left: 24.w),
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 3.w),
          borderRadius: BorderRadius.circular(20.r),
        ),

        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(logo),
            SizedBox(width: 20.w),
            SizedBox(
              width: 232.w,
              height: 50.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(connectionType, style: OStyles.bodyMediumMedium.copyWith(color: OColors.greyScale600)),
                  MaskedTextWidget(data: detailsText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
