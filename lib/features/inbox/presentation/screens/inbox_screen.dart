import 'package:osta/common/widgets/app_bar/app_bar_widget2.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/calls_widget.dart';
import 'package:osta/features/inbox/inbox_for_delivery/presentation/widgets/chats_widget.dart';
import 'package:osta/utils/constants/exports.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with SingleTickerProviderStateMixin{
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
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
          AppBarWidget2(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Inbox',
              actions: Row(
                children: [
                  SvgPicture.asset(OImages.searchIcon, fit: BoxFit.scaleDown,width: 25.w),
                  SizedBox(width: 20.w),
                  SvgPicture.asset(OImages.chatIcon, fit: BoxFit.scaleDown,width: 25.w),
                ],),
              widthOfText: 240.w),

          /// Make Space
          SizedBox(height: 24.h),

          /// TabBar
          TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 4.h,
            indicatorColor: OColors.primaryColor500,
            controller: _tabController,
            labelColor: OColors.primaryColor500,
            unselectedLabelColor: OColors.greyScale500,
            tabs: const [
              Tab(text:  "Chats"),
              Tab(text:  "Calls"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  const [
                /// Chat Screen
               ChatsWidget(),
               /// Calls Screen
               CallsWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


