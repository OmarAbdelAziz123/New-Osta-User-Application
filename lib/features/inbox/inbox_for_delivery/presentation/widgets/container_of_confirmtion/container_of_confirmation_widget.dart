import 'package:osta_user_app/common/widgets/buttons/button_with_border.dart';
import 'package:osta_user_app/features/inbox/inbox_for_delivery/presentation/widgets/text/text_of_time.dart';

import '../../../../../../utils/constants/exports.dart';

class ContainerOfConfirmationWidget extends StatelessWidget {
  ContainerOfConfirmationWidget({Key? key,required this.isTrue,required this.text1,required this.textBt1,required this.textBt2,}) : super(key: key);
  bool isTrue=false;
  String textBt1,textBt2,text1;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 300.w,
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
                SizedBox(
                    width: double.infinity,
                    child: Text(text1)),
                isTrue==true?  Text("50 pound",
                  style: TextStyle(color: OColors.primaryColor200),
                ):const Text(""),
                SizedBox(height: 5.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ThirdButtonWidget(
                      onTap: () {},
                      widgetInButton: Text(textBt1, style: OStyles.bodyMediumMedium.copyWith(color: OColors.whiteColor)),
                        isRejected: false, textStyle: OStyles.bodyMediumMedium.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 130.w, height: 46.h, borderRadius: 15.r),
                    SizedBox(width: 5.w),
                    ButtonWithBorderWidget(
                      onTap: () {},
                      textButton: textBt2,width: 130.w,height: 46.h,)
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
