import 'package:osta_user_app/utils/constants/exports.dart';

class ContinueButtonInBottomWidget extends StatelessWidget {
  const ContinueButtonInBottomWidget({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 105.h,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Sign up Button
          MainButtonWidget(
            centerWidgetInButton: Text('Continue', style: OStyles.bodyLargeBold.copyWith(color: OColors.whiteColor)),
            onTap: onTap,
            margin: EdgeInsets.zero,
            buttonColor: OColors.primaryColor500,
            boxShadow:[AppBoxShadows.buttonShadowOne],
          ),
        ],
      ),
    );
  }
}
