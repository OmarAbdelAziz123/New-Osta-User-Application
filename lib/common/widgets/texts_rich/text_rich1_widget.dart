import 'package:osta_user_app/utils/constants/exports.dart';

class TextRich1Widget extends StatelessWidget {
  const TextRich1Widget({super.key, required this.text1, required this.text2, this.onTap, required this.styleOfText1, required this.styleOfText2});

  final String text1, text2;
  final void Function()? onTap;
  final TextStyle styleOfText1, styleOfText2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: text1,
        style: styleOfText1,
        children: <InlineSpan>[
          WidgetSpan(
            child: InkWell(
              onTap: onTap,
              child: Text(text2, style: styleOfText2),
            ),
          ),
        ],
      ),
    );
  }
}
