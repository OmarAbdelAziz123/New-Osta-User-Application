import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:osta_user_app/features/home/managers/home_cubit.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class CleanlinessAndGardensScreen extends StatefulWidget {
  const CleanlinessAndGardensScreen({super.key, required this.data});

  final Map data;

  @override
  State<CleanlinessAndGardensScreen> createState() =>
      _CleanlinessAndGardensScreenState();
}

class _CleanlinessAndGardensScreenState
    extends State<CleanlinessAndGardensScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    HomeCubit.get(context)
        .getSubServicesFunction(serviceId: widget.data['serviceId']);
    if (HomeCubit.get(context).getAllAddressesModel.result == null)
      HomeCubit.get(context).getAllAddressesFunction();
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
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var subServiceCubit = HomeCubit.get(context);
          var subServicesList = subServiceCubit.subServiceModel.result;
          var addressList = subServiceCubit.getAllAddressesModel.result;

          return Padding(
            padding: EdgeInsets.only(
                left: 24.w, right: 24.w, top: 68.h, bottom: 0.h),
            child: Column(
              children: [
                /// App Bar
                AppBarWidget(
                  leading: InkWellWidget(
                      onTap: () => context.pop(),
                      child: const Icon((Icons.arrow_back))),
                  // title: ODeviceUtils.capitalizeFirstLetter('${widget.data['name']} (${widget.data['category']})'),
                  title: '',
                  actions: Expanded(
                    child: Row(
                      children: [
                        Text(
                            ODeviceUtils.capitalizeFirstLetter(
                                '${widget.data['name']}'),
                            style: OStyles.h4Bold,
                            overflow: TextOverflow.ellipsis),
                        // ContainerIconsInServicesWidget(serviceIcon: widget.data['serviceIcon'], onTap: () {}, servicesBgColors: widget.data['serviceColor'])
                        SizedBox(width: 10.w),
                        Container(
                            width: 50.h,
                            height: 50.h,
                            decoration: BoxDecoration(
                              // color: OColors.purpleTransparent.withOpacity(.08),
                              color: widget.data['serviceColor'],
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: Center(
                              child:
                                  SvgPicture.asset(widget.data['serviceIcon']),
                            ))
                      ],
                    ),
                  ),
                  widthOfText: ODeviceUtils.getScreenWidth(context) / 3,
                ),

                Expanded(
                  child: OneTimeScreen(
                      serviceId: widget.data['serviceId'],
                      category: widget.data['category'],
                      subServicesList: subServicesList,
                      addressList: addressList),
                ),
              ],
            ),
          );
        },
      ),

      // bottomNavigationBar: ContinueButtonInBottomWidget(onTap: () {}),
    );
  }
}
