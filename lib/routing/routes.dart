import 'package:osta_user_app/features/auth/presentation/screens/choice_auth/choice_auth_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/create_account/create_account_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/fill_your_profile/fill_your_profile_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/login_account/login_account_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/login_account/otp_in_create_and_login_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/create_new_password_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/enter_function_connection_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/forget_password_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/otp_in_forget_password_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/notifications/notifications_screen.dart';
import 'package:osta_user_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/change_password/change_password_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/customer_service/customer_service_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/payment/payment_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/privacy_policy/privacy_policy_screen.dart';
import 'package:osta_user_app/navigation_menu.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case ORoutesName.splashRoute:
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.onBoardingRoute:
        return PageTransition(
          child: const OnBoardingScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.choiceAuthRoute:
        return PageTransition(
          child: const ChoiceAuthScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.createAccountRoute:
        return PageTransition(
          child: const CreateAccountScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.fillYourRoute:
        return PageTransition(
          child: const FillYourProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.loginAccountRoute:
        return PageTransition(
          child: const LoginAccountScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.otpRoute:
        return PageTransition(
          child: const OtpInCreateAndLoginScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.enterFunctionConnectionRoute:
        bool viaConnection = settings.arguments as bool;

        return PageTransition(
          child: EnterFunctionConnectionScreen(viaConnection: viaConnection),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.otpInForgetPasswordRoute:
        final Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;

        return PageTransition(
          child: OtpInForgetPasswordScreen(map: map),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.forgetPasswordRoute:
        return PageTransition(
          child: const ForgetPasswordScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.createNewPasswordRoute:
        return PageTransition(
          child: const CreateNewPasswordScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.navigationMenuRoute:
        return PageTransition(
          child: const NavigationMenu(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.notificationsRoute:
        return PageTransition(
          child: const NotificationsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.editProfileRoute:
        return PageTransition(
          child: const EditProfileScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.paymentRoute:
        return PageTransition(
          child: const PaymentScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.changePasswordRoute:
        return PageTransition(
          child: const ChangePasswordScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.privacyPolicyRoute:
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      // case ORoutesName.helpCenterRoute:
      //   return PageTransition(
      //     child: const NavigationMenu(),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //     reverseDuration: const Duration(milliseconds: 300),
      //   );
      case ORoutesName.customerServiceRoute:
        return PageTransition(
          child: const CustomerServiceScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      // case ORoutesName.inviteFriendsRoute:
      //   return PageTransition(
      //     child: const NavigationMenu(),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //     reverseDuration: const Duration(milliseconds: 300),
      //   );
      default:
        return unDefinedRoute();
    }
  }

  /// Un Defined Route
  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            '',
          ),
        ),
        body: const Center(
          child: Text(
            '',
          ),
        ),
      ),
    );
  }
}