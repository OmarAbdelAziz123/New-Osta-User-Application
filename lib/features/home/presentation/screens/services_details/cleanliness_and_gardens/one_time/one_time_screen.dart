// import 'dart:async';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:osta/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta/features/home/managers/home_cubit.dart';
import 'package:osta/features/home/models/address/get_all_addresses_model.dart';
import 'package:osta/features/home/presentation/widgets/home/cleanliness_and_gardens_widgets/sub_services_in_clean_widget.dart';
import 'package:osta/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/utils/constants/exports.dart';
import 'package:osta/utils/constants/log_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../offer/presentation/widgets/inbox/audio_player_widget.dart';
import '../../../../../models/services/sub_service_model.dart';
import '../../electricity_plumbing_aircondition_carpentry/one_time/one_time_screen_in_electricity.dart';

class OneTimeScreen extends StatefulWidget {
  OneTimeScreen(
      {super.key,
      this.subServicesList,
      required this.addressList,
      required this.serviceId,
      required this.category});

  List<SubService>? subServicesList;
  var addressList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreen> createState() => _OneTimeScreenState();
}

class _OneTimeScreenState extends State<OneTimeScreen> {
  int selectedIndex = -1;
  int selectedSpace = -1;
  int selectedDays = 0;

  bool isMakeOrder = false;

  TextEditingController textInServicesController = TextEditingController();
  TextEditingController _discountCodeController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  String? selectedSpaceToPutInApi;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};
  List<File> _selectedImages = [];
  List<int> _spacesIds = [];

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();

    /// Add listener to focus node
    textInServicesFocusNode.addListener(() => setState(
        () => isTextInServicesFieldFocused = textInServicesFocusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    textInServicesFocusNode.dispose();
    textInServicesController.dispose();
    _discountCodeController.dispose();
    _recorder?.closeRecorder();
    _recorder = null;
    super.dispose();
  }

  int maxPrice = 0;

  Future<void> _initializeRecorder() async {
    await Permission.microphone.request();
    if (await Permission.microphone.isGranted) {
      await _recorder!.openRecorder();
    } else {
      // Handle the case when microphone permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(AppLocalizations.of(context)!
                .translate('microPhonePermissionIsRequired')!)),
      );
    }
  }

  int subServiceId = 0;

  FlutterSoundRecorder? _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  bool _isRecordingEnded = false;
  String _filePath = 'audio_example';

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
    await Permission.storage.request();
  }

  Timer? _timer;
  int _recordingDuration = 0;

  Future<String> getFilePath() async {
    Directory tempDir = await getTemporaryDirectory();
    return '${tempDir.path}/audio_example.aac';
  }

  Future<void> startRecording() async {
    _filePath = await getFilePath();
    await _recorder!.startRecorder(
      toFile: _filePath,
      codec: Codec.aacMP4,
    );
    _startTimer();
    setState(() {
      _isRecording = true;
      _isRecordingEnded = false;
    });
  }

  ///TODO
  Future<void> stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
      _isRecordingEnded = true;
    });
    _stopTimer();
    setState(() {
      _recordingDuration = 0;
    });
  }

  Future<void> openAudioSession() async {
    await _recorder!.openRecorder();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _recordingDuration++;
      });
    });
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  String _formatDuration(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Widget _buildRecordingIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.fiber_manual_record, color: Colors.white),
          const SizedBox(width: 8.0),
          Text(
            'Recording: ${_formatDuration(_recordingDuration)}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is MakeOrderSuccessState) {
          setState(() {
            isMakeOrder = false;
          });
          context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute,
              arguments: 0, predicate: (route) => false);
          ODeviceUtils.showSnackBar(
              context: context,
              message: 'Successfully',
              textStyle: OStyles.bodyLargeRegular,
              textColor: OColors.whiteColor,
              bgColor: OColors.success);
        } else if (state is MakeOrderErrorState) {
          setState(() {
            isMakeOrder = false;
          });
          ODeviceUtils.showSnackBar(
              context: context,
              message: 'You have an error in Make Order',
              textStyle: OStyles.bodyLargeRegular,
              textColor: OColors.whiteColor,
              bgColor: OColors.error);
        }
      },
      builder: (context, state) {
        var subServiceCubit = HomeCubit.get(context);
        int? idInSelectedSubService;
        String? subServiceName;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("One time service",
                  style: OStyles.bodyMediumBold
                      .copyWith(color: OColors.primaryColor500),
                  overflow: TextOverflow.ellipsis),

              /// Make Size
              const WhatHappenedWithUsWidget(),

              /// Make Size
              SizedBox(height: 23.h),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Make Size
              SizedBox(height: 14.h),

              /// Row (Services type - See All)
              RowSeeAllWidget(
                  mainText: 'Service Type',
                  seeAllText: 'See All',
                  onTap: () => context.pushNamed(ORoutesName.serviceTypeRoute)),

              /// Make Size
              SizedBox(height: 16.h),

              /// Services Type
              widget.subServicesList == null
                  ? LoadingWidget(iconColor: OColors.primaryColor500)
                  : SizedBox(
                      height: 180.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: widget.subServicesList?.length ?? 0,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 14.w);
                        },
                        itemBuilder: (context, index) {
                          return SubServicesInCleanWidget(
                            subService: widget.subServicesList?[index],
                            isSelected: selectedIndex == index,
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                            onSelect: (value) {
                              if (value.id != null) {
                                if (_spacesIds.isEmpty) {
                                  _spacesIds.add(value.id!);
                                }

                                // maxPrice=value;
                                setState(() {});
                              }
                            },
                          );
                        },
                      ),
                    ),

              /// Divider
              Divider(color: OColors.greyScale200, thickness: 1.w),

              /// Row (اAnother service - See All)

              /// Row (اAnother service - See All)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 3,
                      child: Text('Another service',
                          style: OStyles.bodyLargeBold)),
                  Expanded(
                      child: RememberMeWidget(
                          isChecked: isChecked,
                          onChanged: (p0) => setState(() {
                                isChecked = !isChecked;
                                _selectedImages.clear();
                              }),
                          isRememberMe: false)),
                  Text('I don\'t know the problem',
                      style: OStyles.bodySmallBold
                          .copyWith(color: OColors.primaryColor500)),
                ],
              ),

              /// Make Size
              SizedBox(height: 18.h),

              Stack(
                children: [
                  TextFormFieldWidget(
                    controller: textInServicesController,
                    textInputType: TextInputType.text,
                    focusNode: textInServicesFocusNode,
                    hintText: 'Another Services',
                    hintColor: isTextInServicesFieldFocused
                        ? OColors.primaryColor500
                        : OColors.greyScale500,
                    fillColor: isTextInServicesFieldFocused
                        ? OColors.purpleTransparent.withOpacity(.08)
                        : OColors.greyScale100,
                    borderSide: isTextInServicesFieldFocused
                        ? BorderSide(color: OColors.primaryColor500)
                        : BorderSide.none,
                    obscureText: false,
                    maxLines: 4,
                    textStyle: OStyles.bodyMediumSemiBold
                        .copyWith(color: OColors.primaryColor500),
                    // suffixIcon: ,
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 12.w,
                    child: InkWellWidget(
                      onTap: () async {
                        final images =
                            await ODeviceUtils.pickImagesFromGallery();
                        if (images != null) {
                          setState(() {
                            _selectedImages.addAll(images);
                          });
                        }
                      },
                      child: Icon(
                        Icons.image_outlined,
                        color: OColors.greyScale400,
                        size: 24.h,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12.h,
                    right: 52.w,
                    child: GestureDetector(
                      onLongPress: () {
                        startRecording();
                      },
                      onLongPressEnd: (_) {
                        stopRecording();
                      },
                      child: Icon(
                        Icons.mic_none_rounded,
                        color: OColors.greyScale400,
                        size: 24.h,
                      ),
                    ),
                  ),
                ],
              ),

              /// Show Images
              if (_selectedImages.isNotEmpty)
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    padding: EdgeInsets.only(top: 12.h),
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 8.w);
                    },
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20.0)),
                                      child: Image.file(
                                        _selectedImages[index],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            _selectedImages.removeAt(index);
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Remove'),
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.file(
                                _selectedImages[index],
                                width: 60.w,
                                height: 100.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImages.removeAt(index);
                                  });
                                },
                                child: CircleAvatar(
                                  radius: 10,
                                  backgroundColor: OColors.redColor,
                                  child: const Icon(
                                    Icons.close,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

              if (_selectedImages.isNotEmpty)

                /// Make Size
                SizedBox(height: 12.h),

              /// Clear All Images
              if (_selectedImages.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWellWidget(
                      onTap: () {
                        setState(() {
                          _selectedImages.clear();
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: OColors.redColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Remove all images',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

              /// Make Size
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: _isRecording
                        ? _buildRecordingIndicator()
                        : _isRecordingEnded
                            ? AudioPlayerWidget(
                                url: _filePath,
                                isMe: false,
                                isInbox: false,
                              )
                            : const SizedBox(),
                  ),
                  if (_isRecordingEnded)
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isRecording = false;
                          _isRecordingEnded = false;
                          _filePath = '';
                        });
                      },
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: OColors.redColor,
                      ),
                    ),
                ],
              ),

              /// Make Size
              SizedBox(
                  height:
                      _selectedImages.isNotEmpty || !isChecked ? 12.h : 24.h),
              Text(
                'Add discount code',
                style: TextStyle(
                  color: OColors.primaryColor500,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),

              /// Make Size
              SizedBox(height: 12.h),

              /// Discount Code
              DashedBorder(
                color: OColors.greyScale300,
                borderRadius: BorderRadius.circular(10),
                strokeWidth: 2,
                child: Container(
                  height: 48.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  child: TextFormField(
                    controller: _discountCodeController,
                    decoration: InputDecoration(
                      hintText: 'Discount code',
                      hintStyle: TextStyle(
                        color: OColors.greyScale300,
                        fontSize: 14.sp,
                      ),
                      border: InputBorder.none,
                      suffixIcon: Icon(
                        Icons.discount_outlined,
                        color: OColors.greyScale300,
                      ),
                    ),
                    style: TextStyle(
                      color: OColors.primaryColor500,
                      fontSize: 14.sp,
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                  ),
                ),
              ),

              /// Make Size
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                  color: OColors.greyScale300,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Maximum price',
                      style: TextStyle(
                        color: OColors.blackColor,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text.rich(
                      style: TextStyle(
                        color: OColors.primaryColor500,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w800,
                      ),
                      TextSpan(text: '$maxPrice', children: [
                        TextSpan(
                          text: " \$",
                          style: TextStyle(
                            color: OColors.blackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w800,
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),

              /// Make Size
              SizedBox(
                  height:
                      _selectedImages.isNotEmpty || !isChecked ? 12.h : 24.h),

              ContinueButtonInBottomWidget(
                centerWidget: state is MakeOrderLoadingState
                    ? Center(
                        child: LoadingWidget(iconColor: OColors.whiteColor))
                    : Text('Continue',
                        style: OStyles.bodyLargeBold
                            .copyWith(color: OColors.whiteColor)),
                onTap: () {
                  List<int> subServiceIdsList =
                      keyValueMap.keys.map((key) => int.parse(key)).toList();
                  List<int> subServiceQuantitiesList = keyValueMap.values
                      .map((value) => int.parse(value))
                      .toList();

                  selectedSpace == -1
                      ? ODeviceUtils.showSnackBar(
                          context: context,
                          message: 'Please Choice Space',
                          textStyle: OStyles.bodyLargeRegular,
                          textColor: OColors.whiteColor,
                          bgColor: OColors.warning)
                      : isChecked && textInServicesController.text.isEmpty
                          ? ODeviceUtils.showSnackBar(
                              context: context,
                              message: 'Please Click to write details',
                              textStyle: OStyles.bodyLargeRegular,
                              textColor: OColors.whiteColor,
                              bgColor: OColors.warning)
                          : state is MakeOrderLoadingState
                              ? null
                              : showLocationBottomSheet(
                                  context: context,
                                  map: {
                                    'category': widget.category,
                                    'warrantyId': null,
                                    'serviceId': widget.serviceId,
                                    'description':
                                        textInServicesController.text,
                                    'subServicesIds': subServiceIdsList,
                                    'subServiceQuantities':
                                        subServiceQuantitiesList,
                                    'unknownProblem': isChecked ? 1 : 0,
                                    'space': selectedSpace.toString(),
                                    'isSpace': true,
                                    'isSubServicesIds': true,
                                    'isSubServiceQuantities': true,
                                    'isWarrantyId': false,
                                    'isEdit': false,
                                  },
                                  historyAddressesWidget: widget.addressList ==
                                          null
                                      ? LoadingWidget(
                                          iconColor: OColors.primaryColor500)
                                      : ListView.builder(
                                          itemCount: widget.addressList.length,
                                          itemBuilder: (context, index) {
                                            return PreviousAddressesWidget(
                                              icon: widget.addressList[index]
                                                          .name! ==
                                                      'home'
                                                  ? SvgPicture.asset(
                                                      OImages.homeIcon)
                                                  : widget.addressList[index]
                                                              .name! ==
                                                          'work'
                                                      ? SvgPicture.asset(
                                                          OImages.workIcon)
                                                      : widget
                                                                  .addressList[
                                                                      index]
                                                                  .name! ==
                                                              'friend'
                                                          ? SvgPicture.asset(
                                                              OImages
                                                                  .friendIcon,
                                                              width: 32.w,
                                                              height: 32.h)
                                                          : SvgPicture.asset(
                                                              OImages
                                                                  .resturantIcon),
                                              addressName: widget
                                                          .addressList[index]
                                                          .name! ==
                                                      'home'
                                                  ? 'Home'
                                                  : widget.addressList[index]
                                                              .name! ==
                                                          'work'
                                                      ? 'Work'
                                                      : widget
                                                                  .addressList[
                                                                      index]
                                                                  .name! ==
                                                              'friend'
                                                          ? 'Friend'
                                                          : 'Other',
                                              location: widget
                                                      .addressList[index]
                                                      .desc ??
                                                  '',
                                              onTap: () {
                                                if (!isMakeOrder) {
                                                  isMakeOrder = true;
                                                  subServiceCubit
                                                      .makeOrderFunction(
                                                    category: widget.category,
                                                    warrantyId: null,
                                                    serviceId: widget.serviceId,
                                                    description:
                                                        textInServicesController
                                                            .text,
                                                    subServicesIds:
                                                        subServiceIdsList,
                                                    subServiceQuantities:
                                                        subServiceQuantitiesList,
                                                    unknownProblem:
                                                        isChecked ? 1 : 0,
                                                    space: selectedSpace
                                                        .toString(),
                                                    isSpace: true,
                                                    isSubServicesIds: true,
                                                    isSubServiceQuantities:
                                                        true,
                                                    isWarrantyId: false,
                                                    locationId: widget
                                                        .addressList[index].id,
                                                    images: _selectedImages,
                                                  );
                                                  context.pop();
                                                }
                                              },
                                              onTapInEdit: () {
                                                context.pushNamed(
                                                    ORoutesName
                                                        .choiceYourLocationRoute,
                                                    arguments: {
                                                      'category':
                                                          widget.category,
                                                      'warrantyId': null,
                                                      'serviceId':
                                                          widget.serviceId,
                                                      'description':
                                                          textInServicesController
                                                              .text,
                                                      'subServicesIds':
                                                          subServiceIdsList,
                                                      'subServiceQuantities':
                                                          subServiceQuantitiesList,
                                                      'unknownProblem':
                                                          isChecked ? 1 : 0,
                                                      'space': selectedSpace
                                                          .toString(),
                                                      'isSpace': true,
                                                      'isSubServicesIds': true,
                                                      'isSubServiceQuantities':
                                                          true,
                                                      'isWarrantyId': false,
                                                      'locationId': widget
                                                          .addressList[index]
                                                          .id,
                                                      'isEdit': true,
                                                    });
                                              },
                                            );
                                          },
                                        ),
                                );

                  // subServiceCubit.makeOrderFunction(
                  //   category: widget.category,
                  //   serviceId: widget.serviceId,
                  //   locationId: 2,
                  //   description: textInServicesController.text,
                  //   subServicesIds: subServiceIdsList,
                  //   subServiceQuantities: subServiceQuantitiesList,
                  //   space: selectedSpaceToPutInApi,
                  //   unknownProblem: isChecked ? 1 : 0,
                  //   isSpace: true,
                  //   isSubServicesIds: false,
                  //   isSubServiceQuantities: false,
                  //   isWarrantyId: true,
                  // );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Bottom Sheet
  void showLocationBottomSheet(
      {required BuildContext context,
      required Map map,
      required Widget historyAddressesWidget}) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      builder: (BuildContext context) {
        return ShowLocationBottomSheet(
            map: map, historyAddressesWidget: historyAddressesWidget);
      },
    );
  }
}
