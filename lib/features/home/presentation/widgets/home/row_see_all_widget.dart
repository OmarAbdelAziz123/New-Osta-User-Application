import 'package:osta_user_app/utils/constants/exports.dart';

class RowSeeAllWidget extends StatelessWidget {
  const RowSeeAllWidget({super.key, required this.mainText, required this.seeAllText, required this.onTap});

  final String mainText, seeAllText;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 24.h,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(mainText, style: OStyles.h5Bold),
          InkWellWidget(onTap: onTap, child: Text(seeAllText, style: OStyles.bodyLargeBold.copyWith(color: OColors.primaryColor500, height: 2.3.h))),
        ],
      ),
    );
  }
}