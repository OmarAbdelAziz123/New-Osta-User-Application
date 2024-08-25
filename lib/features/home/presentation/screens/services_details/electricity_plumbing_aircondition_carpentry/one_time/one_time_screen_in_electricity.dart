import 'dart:async';
import 'dart:ui' as Ui;

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';
import 'package:osta/utils/constants/exports.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';

// ... (other imports)
import 'package:osta/common/widgets/bottom_sheet/show_location_bottom_sheet.dart';
import 'package:osta/common/widgets/checkbox/remember_me_widget.dart';
import 'package:osta/common/widgets/what_happened_with_us/what_happened_with_us_widget.dart';
import 'package:osta/features/home/managers/home_cubit.dart';
import 'package:osta/features/home/presentation/widgets/home/electricity_widgets/sub_services_widget.dart';
import 'package:osta/features/offer/managers/offers_orders_cubit.dart';
import 'package:osta/utils/constants/text_styles.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../utils/constants/log_util.dart';
import '../../../../../../offer/presentation/widgets/inbox/audio_player_widget.dart';
import '../../../../../models/services/sub_service_model.dart';

class OneTimeScreenInElectricity extends StatefulWidget {
  OneTimeScreenInElectricity(
      {super.key,
      required this.subServicesList,
      required this.addressList,
      required this.serviceId,
      required this.category});

  List<SubService> subServicesList;
  var addressList;
  int serviceId;
  String category;

  @override
  State<OneTimeScreenInElectricity> createState() =>
      _OneTimeScreenInElectricityState();
}

class _OneTimeScreenInElectricityState
    extends State<OneTimeScreenInElectricity> {
  int selectedIndex = -1;
  int selectedWarranty = 0;
  int selectedSpecificService = -1;
  final TextEditingController _discountCodeController = TextEditingController();

  TextEditingController textInServicesController = TextEditingController();
  final FocusNode textInServicesFocusNode = FocusNode();
  bool isTextInServicesFieldFocused = false;
  bool iNeedWrite = false;
  bool isChecked = false;

  bool isExtended = false;
  bool isSpecificService = false;
  bool isMakeOrder = false;

  int indexInSelectedSubService = 0;

  Map<String, String> keyValueMap = {};

  int numberOfSelectedFromOne = 1;

  Set<int> selectedIndices = {};
  List<File> _selectedImages = [];

  int maxPrice = 0;
  void addButtonPressed({required int subServiceId}) {
    // Generate a key based on the subServiceId
    String key = subServiceId.toString();

    setState(() {
      // Check if the key exists in the map
      if (keyValueMap.containsKey(key)) {
        // If the key exists, increment the count
        int count = int.parse(keyValueMap[key]!);
        count++;
        keyValueMap[key] = count.toString();
      } else {
        // If the key does not exist, start with count 0
        keyValueMap[key] = '1';
      }

      int price = widget.subServicesList
              .firstWhere((e) => e.id == subServiceId)
              .maxPrice ??
          0;

      maxPrice += price * (int.parse(keyValueMap[key]!));

      print('Number Of One Item: $numberOfSelectedFromOne');

      print(keyValueMap);
    });
  }

  void minuseButtonPressed({required int subServiceId}) {
    // Generate a key based on the subServiceId
    String key = subServiceId.toString();

    setState(() {
      // Check if the key exists in the map
      if (keyValueMap.containsKey(key)) {
        // If the key exists, increment the count
        int count = int.parse(keyValueMap[key]!);
        count--;
        keyValueMap[key] = count.toString();
        if (count <= 0) {
          keyValueMap.remove(key);
        }
      }
      int price = widget.subServicesList
              .firstWhere((e) => e.id == subServiceId)
              .maxPrice ??
          0;

      maxPrice -= price * (int.parse(keyValueMap[key]!));
      print('Number Of One Item: $numberOfSelectedFromOne');

      print(keyValueMap);
    });
  }

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _initializeRecorder();

    /// Add listener to focus node
    textInServicesFocusNode.addListener(() => setState(
        () => isTextInServicesFieldFocused = textInServicesFocusNode.hasFocus));
  }

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

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    textInServicesFocusNode.dispose();
    textInServicesController.dispose();
    _recorder?.closeRecorder();
    _recorder = null;
    super.dispose();
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

  List<int> subServiceIdsList = [];
  List<int> subServiceQuantitiesList = [];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
      if (state is MakeOrderSuccessState) {
        setState(() {
          isMakeOrder = false;
        });
        if (state.message == 'order created successfully') {
          OffersOrdersCubit.get(context).getAllOrdersByMeFunction();
          context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute,
              arguments: 0, predicate: (route) => false);
          ODeviceUtils.showSnackBar(
              context: context,
              message: 'Successfully',
              textStyle: OStyles.bodyLargeRegular,
              textColor: OColors.whiteColor,
              bgColor: OColors.success);
        } else {
          ODeviceUtils.showSnackBar(
            context: context,
            message: state.message!,
            textStyle: OStyles.bodyLargeRegular,
            textColor: OColors.whiteColor,
            bgColor: OColors.success,
          );
        }
      } else if (state is MakeOrderErrorState) {
        setState(() {
          isMakeOrder = false;
        });
        ODeviceUtils.showSnackBar(
          context: context,
          message: state.message!,
          textStyle: OStyles.bodyLargeRegular,
          textColor: OColors.whiteColor,
          bgColor: OColors.error,
        );
        // ODeviceUtils.showSnackBar(context: context, message: 'You have an error in Make Order', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
      }
    }, builder: (context, state) {
      var subServiceCubit = HomeCubit.get(context);

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
            SizedBox(height: 24.h),

            /// Osta Extended Warranty
            InkWellWidget(
              onTap: () => setState(() => isExtended = !isExtended),
              child: Container(
                width: double.infinity,
                height: 50.h,
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  color: isExtended
                      ? OColors.primary
                      : OColors.primaryColor100,
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: Center(
                    child: FittedBox(
                      child: Text(
                          'Possibility of purchasing an additional warranty',
                          style: AppTextStyles.boldStyle.copyWith(
                            fontSize: 15,
                              color: isExtended
                                  ? OColors.greyScale300
                                  : selectedWarranty == 0?OColors.primaryColor500:OColors.white)),
                    )),
              ),
            ),

            /// Make Size
            SizedBox(height: isExtended ? 24.h : 0),

            ///
            isExtended
                ? Container(
                    width: double.infinity,
                    height: 180.h,
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Center(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 3,
                        separatorBuilder: (context, index) {
                          return SizedBox(width: 14.w);
                        },
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (selectedWarranty == index + 1) {
                                setState(() {
                                  selectedWarranty = 0;
                                });
                              } else {
                                setState(() => selectedWarranty = index + 1);
                              }
                            },
                            child: Stack(
                              alignment: Alignment.topCenter,
                              children: [
                                Container(
                                  height: 130.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24.w, vertical: 12.h),
                                  decoration: BoxDecoration(
                                    color: OColors.white,
                                    borderRadius: BorderRadius.circular(15.r),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color.fromARGB(7, 0, 0, 0),
                                          offset: Offset(0, 3),
                                          blurRadius: 5.h,
                                          spreadRadius: 0)
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(OConstants.daysList[index],
                                          style: AppTextStyles.boldStyle.copyWith(
                                            color: OColors.primary,
                                            fontSize: 42
                                          )),
                                      Text("days",
                                          maxLines: 2,
                                          style: AppTextStyles.regularStyle.copyWith(
                                              fontSize: 13
                                          )),
                                      Text(OConstants.pricesList[index],
                                          textAlign: TextAlign.center,
                                          style: AppTextStyles.regular12.copyWith(
                                              color: OColors.grey4,
                                          ))
                                    ],
                                  ),
                                ),
                                if (selectedWarranty == index + 1)
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: CircleAvatar(
                                      radius: 12.h,
                                      backgroundColor: OColors.primaryColor500,
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 15.h,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : const SizedBox.shrink(),

            /// Make Size
            SizedBox(height: isExtended ? 20.h : 35.h),

            /// Divider
            Divider(color: OColors.greyScale200, thickness: 1.w),

            /// Make Size
            SizedBox(height: 12.h),

            /// Row (Specific services - See All)
            RowSeeAllWidget(
              mainText: 'Most Popular Services',
              seeAllText: 'See All',
              onTap: () => context.pushNamed(ORoutesName.specificServicesRoute,
                  arguments: widget.serviceId),
            ),

            /// Make Size
            SizedBox(height: 10.h),

            /// Specific Services
            widget.subServicesList.isEmpty
                ? LoadingWidget(iconColor: OColors.primaryColor500)
                : Column(
                    children: [
                      SizedBox(
                        height: 65.h,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: widget.subServicesList.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(width: 14.w);
                          },
                          itemBuilder: (context, index) {
                            int idInSelectedSubService =
                                widget.subServicesList[index].id!;
                            String subServiceName =
                                widget.subServicesList[index].name!;

                            return SubServicesWidget(
                              subServiceName: subServiceName,
                              onTap: () {
                                subServiceId = idInSelectedSubService;
                                setState(() {});
                              },
                              numberOfPieces: keyValueMap.containsKey(
                                      idInSelectedSubService.toString())
                                  ? keyValueMap[
                                      idInSelectedSubService.toString()]!
                                  : '0',
                              onPressed: () {
                                minuseButtonPressed(
                                    subServiceId: idInSelectedSubService);
                              },
                            );
                          },
                        ),
                      ),
                      if (subServiceId != 0)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 20.w),
                          margin: EdgeInsets.only(top: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: OColors.greyScale500),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  minuseButtonPressed(
                                      subServiceId: subServiceId);
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.h,
                                  decoration: BoxDecoration(
                                    color: OColors.greyScale300,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: 20.h,
                                  ),
                                ),
                              ),
                              Text(
                                  keyValueMap
                                          .containsKey(subServiceId.toString())
                                      ? keyValueMap[subServiceId.toString()]!
                                      : '0',
                                  style: OStyles.bodyLargeBold
                                      .copyWith(color: OColors.blackColor)),
                              InkWell(
                                onTap: () {
                                  addButtonPressed(subServiceId: subServiceId);
                                },
                                child: Container(
                                  height: 30.h,
                                  width: 30.h,
                                  decoration: BoxDecoration(
                                    color: OColors.greyScale300,
                                    borderRadius: BorderRadius.circular(100.r),
                                  ),
                                  child: Icon(
                                    Icons.add_rounded,
                                    size: 20.h,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ],
                  ),

            /// Make Size
            SizedBox(height: 24.h),

            /// Divider
            Divider(color: OColors.greyScale200, thickness: 1.w),

            /// Make Size
            SizedBox(height: 12.h),

            /// Row (اAnother service - See All)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    flex: 3,
                    child:
                        Text('Another service', style: OStyles.bodyLargeBold)),
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
                      final images = await ODeviceUtils.pickImagesFromGallery();
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
                height: _selectedImages.isNotEmpty || !isChecked ? 12.h : 24.h),
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
                height: _selectedImages.isNotEmpty || !isChecked ? 12.h : 24.h),

            ContinueButtonInBottomWidget(
              centerWidget: state is MakeOrderLoadingState
                  ? Center(child: LoadingWidget(iconColor: OColors.whiteColor))
                  : Text('Continue',
                      style: OStyles.bodyLargeBold
                          .copyWith(color: OColors.whiteColor)),
              onTap: () {
                subServiceIdsList =
                    keyValueMap.keys.map((key) => int.parse(key)).toList();
                subServiceQuantitiesList = keyValueMap.values
                    .map((value) => int.parse(value))
                    .toList();
                // selectedDays == 0 ?
                // ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Warranty', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                //     :
                // keyValueMap.isEmpty ?
                // ODeviceUtils.showSnackBar(context: context, message: 'Please Choice Specific Service', textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning)
                //     :
                isChecked && textInServicesController.text.isEmpty
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
                              'warrantyId': selectedWarranty == 0
                                  ? null
                                  : selectedWarranty,
                              'serviceId': widget.serviceId,
                              'description': textInServicesController.text,
                              'subServicesIds': subServiceIdsList,
                              'subServiceQuantities': subServiceQuantitiesList,
                              'unknownProblem': isChecked ? 1 : 0,
                              'isSpace': false,
                              'isSubServicesIds': true,
                              'isSubServiceQuantities': true,
                              'isWarrantyId': true,
                              'isEdit': false,
                            },
                            historyAddressesWidget: widget.addressList == null
                                ? Center(
                                    child: LoadingWidget(
                                        iconColor: OColors.primaryColor500))
                                : ListView.builder(
                                    itemCount: widget.addressList.length,
                                    itemBuilder: (context, index) {
                                      return PreviousAddressesWidget(
                                        icon: widget.addressList[index].name! ==
                                                'home'
                                            ? SvgPicture.asset(OImages.homeIcon)
                                            : widget.addressList[index].name! ==
                                                    'work'
                                                ? SvgPicture.asset(
                                                    OImages.workIcon)
                                                : widget.addressList[index]
                                                            .name! ==
                                                        'friend'
                                                    ? SvgPicture.asset(
                                                        OImages.friendIcon,
                                                        width: 32.w,
                                                        height: 32.h)
                                                    : SvgPicture.asset(
                                                        OImages.resturantIcon),
                                        addressName: widget
                                                    .addressList[index].name! ==
                                                'home'
                                            ? 'Home'
                                            : widget.addressList[index].name! ==
                                                    'work'
                                                ? 'Work'
                                                : widget.addressList[index]
                                                            .name! ==
                                                        'friend'
                                                    ? 'Friend'
                                                    : 'Other',
                                        location:
                                            widget.addressList[index].desc ??
                                                '',
                                        onTap: () {
                                          if (!isMakeOrder) {
                                            isMakeOrder = true;
                                            subServiceCubit.makeOrderFunction(
                                                category: widget.category,
                                                warrantyId:
                                                    selectedWarranty == 0
                                                        ? null
                                                        : selectedWarranty,
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
                                                isSpace: false,
                                                isSubServicesIds: true,
                                                isSubServiceQuantities: true,
                                                isWarrantyId: true,
                                                locationId: widget
                                                    .addressList[index].id,
                                                images: _selectedImages,
                                                discount:
                                                    _discountCodeController.text
                                                        .trim(),
                                                voicePath: _filePath);
                                            logSuccess(_filePath.toString());
                                            context.pop();
                                          }
                                        },
                                        onTapInEdit: () {
                                          context.pushNamed(
                                              ORoutesName
                                                  .choiceYourLocationRoute,
                                              arguments: {
                                                'category': widget.category,
                                                'warrantyId':
                                                    selectedWarranty == 0
                                                        ? null
                                                        : selectedWarranty,
                                                'serviceId': widget.serviceId,
                                                'description':
                                                    textInServicesController
                                                        .text,
                                                'subServicesIds':
                                                    subServiceIdsList,
                                                'subServiceQuantities':
                                                    subServiceQuantitiesList,
                                                'unknownProblem':
                                                    isChecked ? 1 : 0,
                                                'isSpace': false,
                                                'isSubServicesIds': true,
                                                'isSubServiceQuantities': true,
                                                'isWarrantyId': true,
                                                'locationId': widget
                                                    .addressList[index].id,
                                                'isEdit': true,
                                              });
                                        },
                                      );
                                    },
                                  ),
                          );
              },
            ),
          ],
        ),
      );
    });
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

class DashedBorder extends StatelessWidget {
  final Widget child;
  final Color color;
  final double strokeWidth;
  final double gap;
  final BorderRadius borderRadius;

  const DashedBorder({
    Key? key,
    required this.child,
    this.color = Colors.black,
    this.strokeWidth = 1.0,
    this.gap = 5.0,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedBorderPainter(
        color: color,
        strokeWidth: strokeWidth,
        gap: gap,
        borderRadius: borderRadius,
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Padding(
          padding: EdgeInsets.all(strokeWidth / 2),
          child: child,
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double gap;
  final BorderRadius borderRadius;

  _DashedBorderPainter({
    required this.color,
    required this.strokeWidth,
    required this.gap,
    required this.borderRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final RRect rRect = RRect.fromRectAndCorners(
      Rect.fromLTWH(strokeWidth / 2, strokeWidth / 2, size.width - strokeWidth,
          size.height - strokeWidth),
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );

    final Path path = Path()..addRRect(rRect);

    final Path dashedPath = Path();
    final Path borderPath = path;

    double distance = 0.0;
    for (final Ui.PathMetric pathMetric in borderPath.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashedPath.addPath(
          pathMetric.extractPath(distance, distance + gap),
          Offset.zero,
        );
        distance += gap * 2;
      }
    }

    canvas.drawPath(dashedPath, paint);
  }

  @override
  bool shouldRepaint(_DashedBorderPainter oldDelegate) =>
      color != oldDelegate.color ||
      strokeWidth != oldDelegate.strokeWidth ||
      gap != oldDelegate.gap ||
      borderRadius != oldDelegate.borderRadius;
}
