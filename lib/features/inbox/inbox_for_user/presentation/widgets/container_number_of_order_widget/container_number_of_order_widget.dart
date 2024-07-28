import '../../../../../../utils/constants/exports.dart';

class ContainerNumberOfOrderWidget extends StatelessWidget {
  const ContainerNumberOfOrderWidget({Key? key, required this.numberOfOrder}) : super(key: key);
  final String numberOfOrder;
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 224.w,
      // height: 53.h,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: OColors.greyScale100

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Number of order : ",style: OStyles.bodyLargeRegular),
          Text(numberOfOrder,style: OStyles.bodyLargeRegular),
        ],
      ),
    );
  }
}
