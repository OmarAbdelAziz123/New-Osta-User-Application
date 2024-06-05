import '../../../../../../utils/constants/exports.dart';

class ContainerTotalAmount extends StatelessWidget {
  const ContainerTotalAmount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(16.sp),
      height: 80.h,
      decoration: BoxDecoration(
        color: OColors.whiteColor,
        boxShadow: [AppBoxShadows.cardShadowThree],
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.r),
          topLeft: Radius.circular(15.r),
        ),
      ),
      child: Row(
        children: [
          const Text("Total amount "),
          Text("(Including tax added)", style: OStyles.bodySmallMedium.copyWith(color: OColors.primaryColor200),
          ),
         const Expanded(child: SizedBox()),
          Container(
            height: 30.h,
            width: 100.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                color: OColors.primaryColor200),
            child:  Center(
              child: Text("125 pounds", style: OStyles.bodyMediumMedium.copyWith(color: OColors.whiteColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
