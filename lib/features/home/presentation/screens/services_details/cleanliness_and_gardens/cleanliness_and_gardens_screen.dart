import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class CleanlinessAndGardensScreen extends StatefulWidget {
  const CleanlinessAndGardensScreen({super.key, required this.data});

  final Map data;

  @override
  State<CleanlinessAndGardensScreen> createState() => _CleanlinessAndGardensScreenState();
}

class _CleanlinessAndGardensScreenState extends State<CleanlinessAndGardensScreen> with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
      body: BlocProvider(
        create: (context) => HomeCubit()..getSubServicesFunction(serviceId: widget.data['serviceId']),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {

          },
          builder: (context, state) {
            var subServiceCubit = HomeCubit.get(context);
            var subServicesList = subServiceCubit.subServiceModel.result;

            return Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
              child: Column(
                children: [
                  /// App Bar
                  AppBarWidget(
                    leading: InkWellWidget(onTap: () => context.pop(), child: const Icon((Icons.arrow_back))),
                    title: '',
                    actions: Container(),
                    widthOfText: 282.w,
                  ),

                  /// TabBar
                  TabBar(
                    indicatorColor: OColors.primaryColor500,
                    controller: _tabController,
                    labelColor: OColors.primaryColor500,
                    unselectedLabelColor: OColors.greyScale500,
                    tabs: const [
                      Tab(text:  "One time"),
                      Tab(text:  "Scheduling"),
                      Tab(text:  "Subscriptions"),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        /// One Time Screen
                        OneTimeScreen(serviceId: widget.data['serviceId'], category: widget.data['category'], subServicesList: subServicesList),
                        /// Scheduling Screen
                        Container(),
                        /// Subscriptions Screen
                        Container(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),

      // bottomNavigationBar: ContinueButtonInBottomWidget(onTap: () {}),
    );
  }
}