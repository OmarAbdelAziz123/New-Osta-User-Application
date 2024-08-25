import 'package:osta/utils/constants/exports.dart';

class OrWidget extends StatelessWidget {
  const OrWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45.h,
      child: Row(
        children: [
          Expanded(child: Container(height: 1.4.h, margin: EdgeInsets.only(left: 10.w, right: 16.w), color: OColors.greyScale200)),
          Text(text, style: OStyles.bodyXLargeSemiBold.copyWith(color: OColors.greyScale700)),
          Expanded(child: Container(height: 1.4.h, margin: EdgeInsets.only(left: 10.w, right: 16.w), color: OColors.greyScale200)),
        ],
      ),
    );
  }
}
