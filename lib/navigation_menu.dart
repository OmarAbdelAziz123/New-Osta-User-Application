import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta/features/booking/presentation/screens/booking_screen.dart';
import 'package:osta/features/home/managers/home_cubit.dart';
import 'package:osta/features/home/presentation/screens/home_screen.dart';
import 'package:osta/features/inbox/presentation/screens/inbox_screen.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta/features/offer/presentation/screens/get_all_orders_by_me_screen.dart';
import 'package:osta/features/offer/presentation/screens/offers_screen.dart';
import 'package:osta/features/profile/managers/profile_cubit.dart';
import 'package:osta/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';

class NavigationMenu extends StatefulWidget {
  const NavigationMenu({super.key, required this.index});

  final int index;

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  int currentIndex = 0;

  @override
  void initState() {
    // if(ProfileCubit.get(context).getProfileDataModel.result == null) ProfileCubit.get(context).getAllProfileDataFunc();
    ProfileCubit.get(context).getAllProfileDataFunc();
    OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
    // OffersOrdersCubit.get(context).getAllOffersByMeFunction();
    super.initState();
    currentIndex = widget.index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List tabs = [
      const HomeScreen(),
      const BookingScreen(),
      // const GetAllOrdersByMeScreen(),
      const WalletScreen(),
      const InboxScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // backgroundColor: OColors.greyScale50,
      // backgroundColor: Theme.of(context).colorScheme.surface,
      backgroundColor: OColors.greyScale50,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: tabs[currentIndex],
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: BottomNavigationBar(
          elevation: 0,
          // backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
          backgroundColor: OColors.greyScale50,
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
              label: AppLocalizations.of(context)!.translate('home')!,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 57.6.w,
                height: 38.h,
                child: currentIndex == 1 ? SvgPicture.asset(OImages.bookingIconSelected, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.bookingIconNotSelected, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
              ),
              label: AppLocalizations.of(context)!.translate('booking')!,
            ),
            // BottomNavigationBarItem(
            //   icon: SizedBox(
            //     width: 57.6.w,
            //     height: 38.h,
            //     child: currentIndex == 2 ? BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
            //       listener: (context, state) async {
            //         if(state is MakeOrderSuccessState) {
            //           await OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
            //         }
            //       },
            //       builder: (context, state) {
            //         var offerOrderCubit = OffersOrdersCubit.get(context);
            //         var orders = offerOrderCubit.getAllOrdersToMeModel?.result?.data ?? [];
            //         var pendingOrdersCount = orders.where((order) => order.status == 'pending').length;
            //
            //         return Badge.count(
            //           count: pendingOrdersCount,
            //           child: Icon(Icons.local_offer, size: 24.sp),
            //         );
            //       },
            //     ) : BlocConsumer<OffersOrdersCubit, OffersOrdersState>(
            //       listener: (context, state) async {
            //         if(state is MakeOrderSuccessState) {
            //           await OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
            //         }
            //       },
            //
            //       builder: (context, state) {
            //         var offerOrderCubit = OffersOrdersCubit.get(context);
            //         var orders = offerOrderCubit.getAllOrdersToMeModel?.result?.data ?? [];
            //         var pendingOrdersCount = orders.where((order) => order.status == 'pending').length;
            //
            //         return Badge.count(
            //          count: pendingOrdersCount,
            //          child: Icon(Icons.local_offer_outlined, size: 24.sp),
            //        );
            //      },
            //     ),
            //   ),
            //   label: 'Offers',
            // ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 57.6.w,
                height: 38.h,
                child: currentIndex == 2 ? SvgPicture.asset(OImages.waleetIconB, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.waleetIconB, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
              ),
              label: AppLocalizations.of(context)!.translate('wallet')!,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 57.6.w,
                height: 38.h,
                child: currentIndex == 3 ? SvgPicture.asset(OImages.inboxIcon, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.inboxIcon, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
              ),
              label: AppLocalizations.of(context)!.translate('inbox')!,
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: 57.6.w,
                height: 38.h,
                child: currentIndex == 4 ? SvgPicture.asset(OImages.profileIconSelected, colorFilter: ColorFilter.mode(OColors.primaryColor500, BlendMode.srcIn), fit: BoxFit.scaleDown) : SvgPicture.asset(OImages.profileIconNotSelected, colorFilter: ColorFilter.mode(OColors.greyScale500, BlendMode.srcIn), fit: BoxFit.scaleDown),
              ),
              label: AppLocalizations.of(context)!.translate('profile')!,
            ),
          ],
        ),
      ),
      floatingActionButton: currentIndex == 3 ? FloatingActionButton(
        backgroundColor: OColors.primaryColor500,
        shape: const CircleBorder(),
        onPressed: () {},
        child: const Icon(Icons.add, color: Colors.white),
      ) : null,
    );
  }
}
