import 'package:osta/utils/constants/exports.dart';

class NotFoundAndFoundOffersWidget extends StatelessWidget {
  const NotFoundAndFoundOffersWidget({super.key, required this.emoji, required this.title, required this.description});

  final String emoji, title, description;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 606.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(emoji),
          SizedBox(height: 40.h),
          Text(title, style: OStyles.h4Bold),
          SizedBox(height: 12.h),
          Text(description, style: OStyles.bodyXLargeRegular, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
