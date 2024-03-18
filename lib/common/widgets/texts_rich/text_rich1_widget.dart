import 'package:osta_user_app/utils/constants/exports.dart';

class TextRich1Widget extends StatelessWidget {
  const TextRich1Widget({super.key, required this.text1, required this.text2, this.onTap, required this.style});

  final String text1, text2;
  final void Function()? onTap;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: style,
        children: <InlineSpan>[
          WidgetSpan(
            child: InkWell(
              onTap: onTap,
              child: Text(text2, style: OStyles.bodyMediumSemiBold.copyWith(color: OColors.primaryColor500)),
            ),
          ),
        ],
      ),
    );
  }
}
