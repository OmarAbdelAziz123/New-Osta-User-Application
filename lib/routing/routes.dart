import 'package:osta_user_app/features/auth/presentation/screens/create_account/create_account_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/fill_your_profile/fill_your_profile_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/login_account/login_account_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/login_account/otp_in_create_and_login_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/create_new_password_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/enter_function_connection_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/forget_password_screen.dart';
import 'package:osta_user_app/features/auth/presentation/screens/password_configuration/otp_in_forget_password_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/all_services/all_services_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/notifications/notifications_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/one_time/one_time_service_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/one_time/order_details_screeen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/cleanliness_and_gardens/cleanliness_and_gardens_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/cleanliness_and_gardens/one_time/service_type_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/cleanliness_and_gardens/one_time/spaces_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/electricity_plumbing_aircondition_carpentry_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/add_data_for_new_address_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/choice_your_location_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/one_time_screen_in_electricity.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/electricity_plumbing_aircondition_carpentry/one_time/specific_services_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/home_app_satellite_channel_and_surveillance_cameras/home_app_satellite_channel_and_surveillance_cameras_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/tiling_and_painting/tiling_and_painting_screen.dart';
import 'package:osta_user_app/features/inbox/presentation/screens/chat_screen.dart';
import 'package:osta_user_app/features/offer/presentation/screens/offers_screen.dart';
import 'package:osta_user_app/features/offer/presentation/widgets/offers/offer_widget.dart';
import 'package:osta_user_app/features/onboarding/screens/onboarding_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/change_password/change_password_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/customer_service/customer_service_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/invite_friends/invite_friends_screen.dart';
import 'package:osta_user_app/features/profile/presentation/screens/payment/add_new_card_screen.dart';
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
      case ORoutesName.createAccountRoute:
        return PageTransition(
          child: const CreateAccountScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.fillYourRoute:
        String phoneNumber = settings.arguments as String;

        return PageTransition(
          child: FillYourProfileScreen(phoneNumber: phoneNumber),
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
        String phoneNumber = settings.arguments as String;

        return PageTransition(
          child: OtpInCreateAndLoginScreen(phoneNumber: phoneNumber),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      // case ORoutesName.enterFunctionConnectionRoute:
      //   bool viaConnection = settings.arguments as bool;
      //
      //   return PageTransition(
      //     child: EnterFunctionConnectionScreen(viaConnection: viaConnection),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //     reverseDuration: const Duration(milliseconds: 300),
      //   );
      // case ORoutesName.otpInForgetPasswordRoute:
      //   final Map<String, dynamic> map = settings.arguments as Map<String, dynamic>;
      //
      //   return PageTransition(
      //     child: OtpInForgetPasswordScreen(map: map),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //     reverseDuration: const Duration(milliseconds: 300),
      //   );
      // case ORoutesName.forgetPasswordRoute:
      //   return PageTransition(
      //     child: const ForgetPasswordScreen(),
      //     type: PageTransitionType.fade,
      //     settings: settings,
      //     reverseDuration: const Duration(milliseconds: 300),
      //   );
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
      case ORoutesName.allServicesRoute:
        return PageTransition(
          child: const AllServicesScreen(),
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
      case ORoutesName.inviteFriendsRoute:
        return PageTransition(
          child: const InviteFriendsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.chatRoute:
        final title = settings.arguments as String;
        return PageTransition(
          child: ChatScreen(title: title),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.cleanlinessAndGardensRoute:
        final data = settings.arguments as Map;

        return PageTransition(
          child: CleanlinessAndGardensScreen(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.serviceTypeRoute:
        return PageTransition(
          child: const ServiceTypeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.spaceRoute:
        return PageTransition(
          child: const SpacesScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.electricityPlumbingAirConditionCarpentrySRoute:
        // final serviceId = settings.arguments as int;
        final data = settings.arguments as Map;

        return PageTransition(
          child: ElectricityPlumbingAirConditionCarpentryScreen(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.homeAppSatelliteChannelAndSurveillanceCamerasSRoute:
        final data = settings.arguments as Map;

        return PageTransition(
          child: HomeAppSatelliteChannelAndSurveillanceCameras(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.specificServicesRoute:
        final serviceId = settings.arguments as int;

        return PageTransition(
          child: SpecificServicesScreen(serviceId: serviceId),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.tilingAndPaintingRoute:
        final data = settings.arguments as Map;

        return PageTransition(
          child: TilingAndPaintingScreen(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.oneTimeServiceInHomeScreenRoute:
        return PageTransition(
          child: const OneTimeServiceInHomeScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.orderDetailsRoute:
        return PageTransition(
          child: const OrderDetailsScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.addNewCardRoute:
        return PageTransition(
          child: const AddNewCardScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.choiceYourLocationRoute:
        final data = settings.arguments as Map;

        return PageTransition(
            child: ChoiceYourLocationScreen(data: data),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.addDataForNewAddressRoute:
        return PageTransition(
          child: const AddDataForNewAddressScreen(),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
      case ORoutesName.offersRoute:
        final orderId = settings.arguments as int;

        return PageTransition(
          child: OffersScreen(orderId: orderId),
          type: PageTransitionType.fade,
          settings: settings,
          reverseDuration: const Duration(milliseconds: 300),
        );
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