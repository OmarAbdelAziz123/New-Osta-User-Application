import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_time.dart';

import '../../../../../../utils/constants/exports.dart';


class CustomContainerConfirmationWidget2 extends StatelessWidget {
  CustomContainerConfirmationWidget2({Key? key,required this.text,required this.textButton,this.width,required this.onTap}) : super(key: key);
  String text,textButton;
  double? width=300.w;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 250,
            padding: EdgeInsets.all(10.sp),
            decoration: BoxDecoration(
                border: Border.all(
                  color: OColors.greyScale500,
                  width: 0.4.w
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                  bottomRight: Radius.circular(15.r),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: double.infinity, child: Text(text)),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    GestureDetector(
                        onTap: onTap,
                        child: ThirdButtonWidget(
                            onTap: () {},
                            widgetInButton: Text(textButton, style: OStyles.bodyMediumMedium.copyWith(color: OColors.whiteColor)),
                            isRejected: false, textStyle: OStyles.bodyMediumMedium.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 130.w, height: 46.h, borderRadius: 15.r)),
                  ],
                )
              ],
            ),
          ),
          const TextOfTime(time: "4:30PM")
        ],
      ),
    );
  }
}
