import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/features/home/presentation/screens/services_details/tiling_and_painting/one_time/one_time_screen_in_tiling_and_painting.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class TilingAndPaintingScreen extends StatefulWidget {
  const TilingAndPaintingScreen({super.key, required this.data});

  final Map data;

  @override
  State<TilingAndPaintingScreen> createState() => _TilingAndPaintingScreenState();
}

class _TilingAndPaintingScreenState extends State<TilingAndPaintingScreen>  with SingleTickerProviderStateMixin{
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
      body: BlocProvider(
        create: (context) => HomeCubit()..getSubServicesFunction(serviceId: widget.data['serviceId'])..getAllAddressesFunction(),
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {

          },
          builder: (context, state) {

            var subServiceCubit = HomeCubit.get(context);
            var subServicesList = subServiceCubit.subServiceModel.result;
            var addressList = subServiceCubit.getAllAddressesModel.result;

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
                      Tab(text:  "One time service"),
                      Tab(text:  "Subscriptions"),
                    ],
                  ),

                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children:  [
                        /// One Time Screen
                        OneTimeScreenInTilingAndPainting(subServicesList: subServicesList, serviceId: widget.data['serviceId'], category: widget.data['category'], addressList: addressList),
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