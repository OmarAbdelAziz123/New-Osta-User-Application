import '../../../../../../utils/constants/exports.dart';

class ContainerMessage3 extends StatelessWidget {
  const ContainerMessage3({Key? key, required this.message, required this.imageOfMessage}) : super(key: key);
  final String message,imageOfMessage;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topRight: Radius.circular(15.r),bottomRight: Radius.circular(15.r),bottomLeft: Radius.circular(15.r)),
          color: OColors.greyScale100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
                width: 201,
                child: Text(message,style: OStyles.bodyLargeRegular)),
            SizedBox(height: 15.h),
            Container(
              height: 198.h,
              width: 222.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                image: DecorationImage(image: AssetImage(imageOfMessage),fit: BoxFit.scaleDown)
              ),
            )
          ],
        )
    );
  }
}
