import '../../../../../../utils/constants/exports.dart';

class DateContainer extends StatelessWidget {
  const DateContainer({Key? key, required this.date}) : super(key: key);
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 60.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: OColors.greyScale100
      ),
      child: Center(child: Text(date,style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.greyScale600))),
    );
  }
}
