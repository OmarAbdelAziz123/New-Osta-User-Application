import '../../../../../../utils/constants/exports.dart';

class ContainerMessageWidget2 extends StatelessWidget {
  const ContainerMessageWidget2({Key? key, required this.message, required this.timeOfMessage}) : super(key: key);
  final String message, timeOfMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.r),bottomRight: Radius.circular(15.r),bottomLeft: Radius.circular(15.r)),
        gradient: AppGradients.purpleGradient,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
              width: 205.w,
              child: Text(message,style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor))),
          Text(timeOfMessage,style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor)),
        ],
      ),
    );
  }
}
