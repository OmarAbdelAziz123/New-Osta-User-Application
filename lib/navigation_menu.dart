import 'package:osta_user_app/features/booking/presentation/screens/booking_screen.dart';
import 'package:osta_user_app/features/home/presentation/screens/home_screen.dart';
import 'package:osta_user_app/features/inbox/presentation/screens/inbox_screen.dart';
import 'package:osta_user_app/features/offer/presentation/screens/offers_screen.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    List tabs = [
      HomeScreen(),
      BookingScreen(),
      OffersScreen(),
      InboxScreen(),
      ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: OColors.whiteColor,
      body: tabs[currentIndex],
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 90.h,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.r),
            topLeft: Radius.circular(16.r),
          ),
          child: Theme(
            data: ThemeData(splashColor: Colors.transparent),
            child: BottomNavigationBar(
              elevation: 0,
              backgroundColor: OColors.whiteColor,
              iconSize: 24.sp,
              type: BottomNavigationBarType.fixed,
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              enableFeedback: false,
              selectedItemColor: OColors.primaryColor500,
              unselectedItemColor: OColors.greyScale500,
              selectedLabelStyle: OStyles.bodyXSmallBold.copyWith(color: OColors.primaryColor500),
              unselectedLabelStyle: OStyles.bodyXSmallMedium.copyWith(color: OColors.greyScale500),
              showUnselectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 0 ? SvgPicture.asset(OImages.homeIconSelected, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.homeIconNotSelected, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 1 ? SvgPicture.asset(OImages.bookingIconSelected, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.bookingIconNotSelected, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
                  ),
                  label: 'Booking',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 2 ? Icon(Icons.local_offer, size: 24.sp) : Icon(Icons.local_offer_outlined, size: 24.sp),
                  ),
                  label: 'Offers',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 3 ? Icon(Icons.chat, size: 24.sp) : Icon(Icons.chat_outlined, size: 24.sp),
                  ),
                  label: 'Inbox',
                ),
                BottomNavigationBarItem(
                  icon: SizedBox(
                    width: 57.6.w,
                    height: 38.h,
                    child: currentIndex == 4 ? SvgPicture.asset(OImages.profileIconSelected, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.profileIconNotSelected, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
