import 'package:osta_user_app/utils/constants/exports.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
              Text('Create your Account', style: OStyles.h1Bold.copyWith(color: OColors.greyScale900)),

              /// Make Space
              SizedBox(height: 60.h),

              const CreateAccountFormWidget(),

              /// Make Space
              SizedBox(height: 50.h),

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

              // Text in Bottom
              TextRich1Widget(text1: "Already have an account? ", text2: 'Sign in', onTap: () => context.pushNamed(ORoutesName.loginAccountRoute), style: OStyles.bodyMediumRegular.copyWith(color: OColors.greyScale500))
            ],
          ),
        ),
      ),
    );
  }
}