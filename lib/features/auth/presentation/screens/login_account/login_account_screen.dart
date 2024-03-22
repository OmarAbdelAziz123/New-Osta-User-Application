import 'package:osta_user_app/utils/constants/exports.dart';

class LoginAccountScreen extends StatelessWidget {
  const LoginAccountScreen({super.key});

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

              /// Create Account Text
              Text('Login to your Account', style: OStyles.h1Bold.copyWith(color: OColors.greyScale900)),

              /// Make Space
              SizedBox(height: 45.25.h),

              const LoginAccountFormWidget(),

              /// OR - Social Buttons
              SizedBox(
                width: double.infinity,
                height: 125.h,
                child: Column(
                  children: [
                    const OrWidget(text: 'or continue with'),

                    /// Make Space
                    SizedBox(height: 20.h),

                    /// Social Containers Widget
                    Row(
                      children: List.generate(
                        OConstants.choiceIcons.length,
                            (index) => Flexible(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SocialContainerWidget(companyIcon: OConstants.choiceIcons[index]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Make Space
              SizedBox(height: 45.25.h),

              /// Text in Bottom
              TextRich1Widget(text1: "Don’t have an account? ", text2: 'Sign up', onTap: () => context.pushNamed(ORoutesName.createAccountRoute), styleOfText1: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale500), styleOfText2: OStyles.bodyMediumSemiBold.copyWith(color: OColors.primaryColor500)),
            ],
          ),
        ),
      ),
    );
  }
}
