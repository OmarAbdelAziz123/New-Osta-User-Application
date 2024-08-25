import 'package:osta/features/booking/managers/booking_cubit.dart';
import 'package:osta/features/booking/presentation/screens/current_screen.dart';
import 'package:osta/features/booking/presentation/screens/pending_screen.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/features/offer/managers/socket_cubit/socket_cubit.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'completed_screen.dart';
import 'empty_upcoming_screen.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      backgroundColor: OColors.white,
      appBar: AppBar(
        backgroundColor: OColors.white,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Row(
              children: [
                Text(
                  AppLocalizations.of(context)!.translate('myOrders')!,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown),
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          /// TabBar
          Padding(
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
            ),
            child: TabBar(
              indicatorColor: OColors.primaryColor500,
              controller: _tabController,
              labelStyle: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: OColors.primary,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 17.sp,
                color: OColors.greyScale500,
              ),
              tabs: [
                Tab(text: AppLocalizations.of(context)!.translate('pending')!),
                Tab(text: AppLocalizations.of(context)!.translate('current')!),
                Tab(text: AppLocalizations.of(context)!.translate('finished')!),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PendingScreen(),
                CurrentScreen(),
                CompletedScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
