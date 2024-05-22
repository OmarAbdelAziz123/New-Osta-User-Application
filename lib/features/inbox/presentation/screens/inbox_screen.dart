import 'package:osta_user_app/features/inbox/presentation/widgets/inbox_container_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

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
          AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Inbox',
              actions: Row(
                children: [
                  SvgPicture.asset(OImages.searchIcon, fit: BoxFit.scaleDown),
                  // SizedBox(width: 20.w),
                  // SvgPicture.asset(OImages.chatIcon, fit: BoxFit.scaleDown),
                ],),
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
              Tab(text:  "Chats"),
              Tab(text:  "Calls"),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children:  [
                /// Chat Screen
              SizedBox(
              width: double.infinity,
              child: ListView.builder(
                  itemCount: OConstants.inboxProfileImage.length,
                  itemBuilder: (context,index){
                    return InboxWidget(profileImage:OConstants.inboxProfileImage[index], profileName: OConstants.inboxProfileName[index],profileDes: OConstants.inboxProfileDes[index],date: " | Dec 19, 2024",onTap: (){context.pushNamed(ORoutesName.chatRoute,arguments:OConstants.inboxProfileName[index]);},);
                  }),

              // child Column(
              //    children:
              //    List.generate(3, (index) {
              //      return  MyBookingContainerWidget(bookingImage: OConstants.bookingImage[index],bookingJob: OConstants.bookingJobs[index], bookingName: OConstants.bookingName[index], containerColor: OColors.primaryColor500, buttonText: 'Upcoming',);
              //    },
              //    ),
              //  ),
            ),
               /// Calls
             Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


