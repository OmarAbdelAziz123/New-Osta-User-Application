import '../../../../../../utils/constants/exports.dart';

class ContainerMessage1 extends StatelessWidget {
  const ContainerMessage1({Key? key, required this.message, required this.timeOfMessage, required this.haveButton, required this.haveOneButton}) : super(key: key);
  final String message,timeOfMessage;
  final bool haveOneButton;
  final bool haveButton;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),bottomRight: Radius.circular(15.r),bottomLeft: Radius.circular(15.r)),
            color: OColors.greyScale100,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                  width: 201,
                  child: Text(message,style: OStyles.bodyLargeRegular)),
              SizedBox(
                  width: 33.w,
                  child: Text(timeOfMessage,style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale600))),
            ],
          )
        ),
        SizedBox(height: 12.h),
        haveButton  ? Row(
           mainAxisAlignment:haveOneButton? MainAxisAlignment.start : MainAxisAlignment.start,
          children: [
            ThirdButtonWidget(
                onTap: () {},
                widgetInButton: Text('cancel', style: OStyles.bodyLargeRegular.copyWith(color: OColors.error)),
                isRejected: false, textStyle: OStyles.bodyLargeRegular.copyWith(color: OColors.error), containerColor: OColors.greyScale100, width: 120.w, height: 28.h, borderRadius: 12.r),
            SizedBox(width: 40.w),
            ThirdButtonWidget(
                onTap: () {},
                widgetInButton: Text('sure', style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor)),
                isRejected: false,  textStyle: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 120.w, height: 28.h, borderRadius: 12.r),
          ],
        ) :const SizedBox(),
        haveOneButton ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ThirdButtonWidget(
                onTap: () {},
                widgetInButton: Text('ok', style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor)),
                isRejected: false, textStyle: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor), containerColor: OColors.primaryColor500, width: 120.w, height: 28.h, borderRadius: 12.r),
          ],
        ) : const SizedBox()
      ],
    );
  }
}
