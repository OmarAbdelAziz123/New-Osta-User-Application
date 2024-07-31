import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/profile/managers/profile_cubit.dart';
import 'package:osta_user_app/features/profile/presentation/widgets/help_center/contact_us_widget.dart';
import 'package:osta_user_app/features/profile/presentation/widgets/help_center/faq_widget.dart';
import '../../../../../utils/constants/exports.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> with SingleTickerProviderStateMixin{
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
    return Scaffold(
      backgroundColor: OColors.greyScale50,
      body: Padding(
        padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
        child: Column(
          children: [
            /// App Bar
            AppBarWidget(
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      context.pop();
                    }),
                title: AppLocalizations.of(context)!.translate('helpCenter')!,
                actions: SvgPicture.asset(OImages.chatIcon,
                    fit: BoxFit.scaleDown, width: 25.w),
                widthOfText: 266.w),

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
              tabs: [
                Tab(text: AppLocalizations.of(context)!.translate('faq')!),
                Tab(text: AppLocalizations.of(context)!.translate('contactUs')!),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children:  const [
                  /// FAQ Screen
                  FaqWidget(),
                  /// Contact us Screen
                  ContactUsWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
