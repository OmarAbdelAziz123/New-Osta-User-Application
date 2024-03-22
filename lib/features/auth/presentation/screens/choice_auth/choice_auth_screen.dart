import 'package:osta_user_app/utils/constants/exports.dart';

class ChoiceAuthScreen extends StatelessWidget {
  const ChoiceAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 75.h, bottom: 48.h),
          child: Column(
            children: [
              /// Arrow Button
              const TopRowInAllScreens(),

              /// Make Space
              SizedBox(height: 31.h),

              /// Logo In Center
              SizedBox(
                width: double.infinity,
                height: 200.h,
                child: SvgPicture.asset(OImages.logoInChoiceScreen),
              ),

              /// Make Space
              SizedBox(height: 31.h),

              /// Let's you in Text
              SizedBox(width: double.infinity, height: 58.h, child: Text('Let’s you in', textAlign: TextAlign.center, style: OStyles.h1Bold)),

              /// Make Space
              SizedBox(height: 31.h),

              /// Social Buttons
              const AllSocialButtonsWidget(),

              /// Make Space
              SizedBox(height: 24.h),

              const OrWidget(text: 'or'),

              /// Make Space
              SizedBox(height: 24.h),

              /// Sin in With Password
              MainButtonWidget(
                buttonText: 'Sign in with password',
                onTap: () {},
                margin: EdgeInsets.zero,
                buttonColor: OColors.primaryColor500,
                boxShadow: [AppBoxShadows.buttonShadowOne],
              ),

              /// Make Space
              SizedBox(height: 31.h),

              /// Text in Bottom
              TextRich1Widget(text1: "Don't have an account? ", text2: 'Sign up', onTap: () => context.pushNamed(ORoutesName.createAccountRoute), styleOfText1: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale500), styleOfText2: OStyles.bodyMediumSemiBold.copyWith(color: OColors.primaryColor500),)
            ],
          ),
        ),
      ),
    );
  }
}

