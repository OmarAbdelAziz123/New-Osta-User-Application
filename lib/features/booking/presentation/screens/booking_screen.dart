import 'package:osta_user_app/features/booking/managers/booking_cubit.dart';
import 'package:osta_user_app/features/booking/presentation/screens/cancelled_screen.dart';
import 'package:osta_user_app/features/booking/presentation/screens/upcoming_screen.dart';
import 'package:osta_user_app/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta_user_app/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';
import 'completed_screen.dart';
import 'empty_upcoming_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    logSuccess('-------------------');
    logSuccess(OCacheHelper.getString(key: CacheKeys.userId)!);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
      child: Column(
        children: [
          /// App Bar
          AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'My Bookings',
              actions: Container(
                child:
                Row(
                  children: [
                    // SvgPicture.asset(OImages.searchIcon, fit: BoxFit.scaleDown),
                    // SizedBox(width: 20.w),
                    // SvgPicture.asset(OImages.chatIcon, fit: BoxFit.scaleDown),
                  ],),),
              widthOfText: 280.w),

          /// Make Space
          SizedBox(height: 24.h),

          /// TabBar
          TabBar(
            indicatorColor: OColors.primaryColor500,
            controller: _tabController,
            labelColor: OColors.primaryColor500,
            unselectedLabelColor: OColors.greyScale500,
            tabs: const [
              Tab(text:  "Upcoming"),
              Tab(text:  "Completed"),
              Tab(text:  "Cancelled"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                UpcomingScreen(),
                // EmptyUpcomingScreen(),
                /// Completed Screen
                const CompletedScreen(),
                /// Cancelled Screen
                const CancelledScreen(),
              ],
            ),
          ),


        ],
      ),
    );
  }
}

