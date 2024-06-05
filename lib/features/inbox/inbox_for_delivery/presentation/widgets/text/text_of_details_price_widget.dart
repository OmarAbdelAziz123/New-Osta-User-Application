import '../../../../../../utils/constants/exports.dart';

class TextOfDetailsPriceWidget extends StatelessWidget {
  TextOfDetailsPriceWidget({Key? key,required this.type,required this.price, required this.top, required this.right, required this.left, required this.bottom}) : super(key: key);
  String type,price;
  double top,right,left,bottom;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: top,right: right,bottom: bottom,left: left),
      child: Row(
        children: [
          Text(type,style: OStyles.bodyLargeRegular),
          const Spacer(),
          Text(price,style: OStyles.bodyLargeSemiBold.copyWith(color: OColors.primaryColor500)),
        ],
      ),
    );
  }
}
