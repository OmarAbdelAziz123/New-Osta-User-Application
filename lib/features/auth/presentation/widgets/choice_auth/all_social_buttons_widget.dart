import 'package:osta_user_app/utils/constants/exports.dart';

class AllSocialButtonsWidget extends StatelessWidget {
  const AllSocialButtonsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        OConstants.choiceIcons.length,
            (index) => SocialButtonWidget(
          companyIcon: OConstants.choiceIcons[index],
          textButton: OConstants.choiceTexts[index],
        ),
      ),
    );
  }
}
