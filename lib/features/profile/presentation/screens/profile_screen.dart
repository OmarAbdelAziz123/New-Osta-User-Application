import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/common/widgets/cach_network_images/cach_network_images.dart';
import 'package:osta_user_app/features/profile/managers/localizations/localizations_cubit.dart';
import 'package:osta_user_app/features/profile/managers/profile_cubit.dart';
import 'package:osta_user_app/features/profile/presentation/widgets/remove_account_widget.dart';
import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/device/device_utility.dart';
import 'package:osta_user_app/utils/language/app_localizations.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     bool isDarkModeEnabled = false;
//     bool isOnNotificationEnabled = false;
//
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
//         child: Column(
//           children: [
//
//             /// App Bar
//             AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: 'Profile', actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),
//
//             /// Make Space
//             SizedBox(height: 24.h),
//
//             SizedBox(
//               width: double.infinity,
//               height: ODeviceUtils.getScreenHeight(context).h / 3.8,
//
//               child: Column(
//                 children: [
//                   Stack(
//                     children: [
//
//                       /// Image Profile
//                       CircleAvatar(radius: 60.r, backgroundImage: const AssetImage(OImages.profileImage), backgroundColor: Colors.transparent,),
//
//                       /// Edite Icon
//                       Positioned(bottom: 0, right: 0, child: SvgPicture.asset(OImages.editIcon)),
//                     ],
//                   ),
//
//                   /// Make Space
//                   SizedBox(height: 12.h),
//
//                   Container(margin: EdgeInsets.only(bottom: 2.h), width: double.infinity, height: 29.h, child: Text(OCacheHelper.getString(key: CacheKeys.fullName).toString(), style: OStyles.h4Bold, textAlign: TextAlign.center)),
//
//                   SizedBox(width: double.infinity, height: 29.h, child: Text(OCacheHelper.getString(key: CacheKeys.email).toString(), style: OStyles.bodyMediumSemiBold, textAlign: TextAlign.center)),
//                 ],
//               ),
//             ),
//
//             /// Make Space
//             SizedBox(height: 24.h),
//
//             /// Divider
//             Container(width: double.infinity, height: 1.h, color: OColors.greyScale200),
//
//             /// Make Space
//             SizedBox(height: 24.h),
//
//             /// ListTil
//             SizedBox(
//               width: double.infinity,
//               child: Column(
//                 children: List.generate(
//                   OConstants.listTilIconsInProfile.length,
//                       (index) {
//                     return ListTile(
//                       onTap: index == 5 || index == 1 ? null : () =>
//                           navigateBasedOnIndex(context, index),
//                       contentPadding: EdgeInsets.zero,
//                       leading: SvgPicture.asset(
//                           OConstants.listTilIconsInProfile[index], width: 28.w,
//                           height: 28.h,
//                           fit: BoxFit.scaleDown),
//                       title: Text(OConstants.listTilTextInProfile[index],
//                           style: OStyles.bodyXLargeSemiBold),
//                       trailing: index == 5 ?
//                       // SwitchWidget(valueData: isDarkModeEnabled) :
//                       SwitchWidget(onChanged: (value) {
//                         setState(() => isDarkModeEnabled = value);
//                       }, valueData:  isDarkModeEnabled) :
//                       index == 1 ?
//                       SwitchWidget(onChanged: (value) {
//                         setState(() => isOnNotificationEnabled = value);
//                       }, valueData:  isOnNotificationEnabled) :
//                       // SwitchWidget(valueData: isOnNotificationEnabled) :
//                       SizedBox(
//                         width: 160.w,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             index == 4
//                                 ? Text('English (US)',
//                                 style: OStyles.bodyXLargeSemiBold)
//                                 : const SizedBox.shrink(),
//                             index == 4 ? SizedBox(width: 20.w) : const SizedBox
//                                 .shrink(),
//                             SvgPicture.asset(OImages.arrowRightIOS, width: 20.w,
//                                 height: 20.h),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void navigateBasedOnIndex(BuildContext context, int index) {
//     switch (index) {
//       case 0:
//         context.pushNamed(ORoutesName.editProfileRoute);
//         break;
//       case 2:
//         context.pushNamed(ORoutesName.paymentRoute);
//         break;
//       case 3:
//         context.pushNamed(ORoutesName.changePasswordRoute);
//         break;
//       case 6:
//         context.pushNamed(ORoutesName.privacyPolicyRoute);
//         break;
//       case 7:
//         context.pushNamed(ORoutesName.helpCenterRoute);
//         break;
//       case 8:
//         context.pushNamed(ORoutesName.inviteFriendsRoute);
//       case 9:
//         ODeviceUtils.showCustomBottomSheet(context: context, widget: const LogoutWidget());
//         break;
//       default:
//         break;
//     }
//   }
// }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  XFile? _selectedImageToPerson;

  @override
  Widget build(BuildContext context) {
    bool isDarkModeEnabled = false;
    bool isOnNotificationEnabled = false;

    List<String> listTilTextInProfile = OConstants.listTilKeysInProfile.map((key) {
      return AppLocalizations.of(context)!.translate(key)!;
    }).toList();

    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if(state is UpdateProfileDataSuccessState) {
          // context.pushNamedAndRemoveUntil(ORoutesName.navigationMenuRoute, arguments: 3, predicate: (route) => false);
          _selectedImageToPerson = null;
          ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('updateProfileDateSuccessfully')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.success);
        } else if(state is UpdateProfileDataErrorState) {
          ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('updateProfileDateHaveAProblem')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.error);
        }
      },
      builder: (context, state) {
        var profileCubit = ProfileCubit.get(context);
        
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 68.h),
            child: Column(
              children: [

                /// App Bar
                AppBarWidget(leading: SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown), title: AppLocalizations.of(context)!.translate('profile')!, actions: SvgPicture.asset(OImages.moreIcon2), widthOfText: 280.w),

                /// Make Space
                SizedBox(height: 24.h),

                // SizedBox(
                //   width: double.infinity,
                //   // color: Colors.red,
                //   height: _selectedImageToPerson != null ? ODeviceUtils.getScreenHeight(context).h / 3 : ODeviceUtils.getScreenHeight(context).h / 3.8,
                //
                //   child: Column(
                //     children: [
                //       Stack(
                //         children: [
                //           // /// Image Profile
                //           // CircleAvatar(
                //           //   radius: 60.r,
                //           //   backgroundImage: ProfileCubit.get(context).getProfileDataModel.result != null ? NetworkImage( ProfileCubit.get(context).getProfileDataModel.result!.personalMediaUrl!) : null,
                //           //   backgroundColor: Colors.transparent,
                //           //   child: ProfileCubit.get(context).getProfileDataModel.result == null ? Lottie.asset(OImages.loadingImages) : null,
                //           // ),
                //           // Image Profile
                //           CircleAvatar(
                //             radius: 62.r,
                //             backgroundColor: OColors.primaryColor100,
                //             child: CircleAvatar(
                //               radius: 58.r,
                //               backgroundImage: _selectedImageToPerson != null
                //                   ? FileImage(File(_selectedImageToPerson!.path))
                //                   : null,
                //               child: _selectedImageToPerson == null
                //                   ? (ProfileCubit.get(context).getProfileDataModel.result == null
                //                   ? Lottie.asset(OImages.profileLoading)
                //                   : CachNetworkImages(
                //                 bottomLeftRadius: 100.r,
                //                 bottomRightRadius: 100.r,
                //                 topLeftRadius: 100.r,
                //                 topRightRadius: 100.r,
                //                 imageUrl: ProfileCubit.get(context).getProfileDataModel.result!.personalMediaUrl ?? '',
                //                 width: ODeviceUtils.getScreenWidth(context) / 2,
                //                 height: ODeviceUtils.getScreenHeight(context) / 2,
                //               ))
                //                   : null,
                //             ),
                //           ),
                //           // CircleAvatar(
                //           //   radius: 60.r,
                //           //   child: ClipOval(
                //           //     child: CachedNetworkImage(
                //           //       imageUrl: ProfileCubit.get(context).getProfileDataModel.result != null
                //           //           ? ProfileCubit.get(context).getProfileDataModel.result!.personalMediaUrl!
                //           //           : '',
                //           //       fit: BoxFit.cover,
                //           //       width: 120.r,
                //           //       height: 120.r,
                //           //       placeholder: (context, url) => Lottie.asset(OImages.profileLoading),
                //           //       errorWidget: (context, url, error) => Lottie.asset(OImages.profileLoading),
                //           //     ),
                //           //   ),
                //           // ),
                //
                //           /// Edite Icon
                //           Positioned(bottom: 0, right: 0, child: InkWellWidget(onTap: _openImageGalleryToPerson, child: SvgPicture.asset(OImages.editIcon))),
                //         ],
                //       ),
                //
                //       /// Make Space
                //       SizedBox(height: 12.h),
                //
                //       Container(
                //         margin: EdgeInsets.only(bottom: 2.h),
                //         width: double.infinity,
                //         // height: 29.h,
                //         child: Text(
                //           OCacheHelper.getString(key: CacheKeys.fullName).toString(),
                //           style: OStyles.h4Bold, textAlign: TextAlign.center,
                //           overflow: TextOverflow.ellipsis,
                //         ),
                //       ),
                //
                //       SizedBox(
                //           width: double.infinity,
                //           // height: 29.h,
                //           child: Text(
                //             OCacheHelper.getString(key: CacheKeys.email).toString(),
                //             style: OStyles.bodyMediumSemiBold, textAlign: TextAlign.center,
                //             overflow: TextOverflow.ellipsis,
                //           ),
                //       ),
                //       SizedBox(height: _selectedImageToPerson != null ? 12.h : 0.h),
                //       if(_selectedImageToPerson != null) ThirdButtonWidget(
                //         isRejected: false,
                //         widgetInButton: state is UpdateProfileDataLoadingState
                //           ? Lottie.asset(OImages.loadingTwo)
                //             : Text('Save', style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)),
                //         textStyle: OStyles.bodySmallBold,
                //         containerColor: OColors.primaryColor500,
                //         width: ODeviceUtils.getScreenWidth(context) / 3,
                //         height: 38.h,
                //         borderRadius: 20.r,
                //         onTap: state is UpdateProfileDataLoadingState ? () {} : () {
                //           profileCubit.updateProfileDataFunc(personal: _selectedImageToPerson!.path);
                //         },
                //       ),
                //     ],
                //   ),
                // ),
                //
                // /// Make Space
                // SizedBox(height: _selectedImageToPerson != null ? 0.h : 0.h),
                //
                // /// Divider
                // Container(width: double.infinity, height: 1.h, color: OColors.greyScale200),

                // Container(
                //   width: double.infinity,
                  // height: _selectedImageToPerson != null ? ODeviceUtils.getScreenHeight(context).h / 3 : ODeviceUtils.getScreenHeight(context).h / 3.8,
                  // child:
                  Stack(
                    children: [
                      Image.asset(OImages.profileImage2, height: 182.h),
                      Positioned(
                        bottom: 12,
                        left: 30,
                        child: Card(
                          elevation: 2,
                          color: OColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor:  OColors.whiteColor,
                            child: Center(
                                child: Icon(Icons.add, size: 20.sp)
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                // ),

                /// Make Space
                SizedBox(height: 30.h),

                Container(
                  // color: Colors.red,
                  width: ODeviceUtils.getScreenWidth(context) / 1.5,
                  child: Column(
                    children: [
                      /// Name of User
                      Text("Amira Adel",style: OStyles.h4Bold.copyWith(color: OColors.primaryColor500)),

                      /// Make Space
                      SizedBox(height: 18.h),

                      /// text
                      RichText(
                        text:  TextSpan(children: [
                          TextSpan(
                              text: '${AppLocalizations.of(context)!.translate('totalOfMyOrders')!}  ',
                              style: OStyles.bodyLargeRegular),
                          TextSpan(
                              text: '5 orders ',
                              style: OStyles.bodyLargeRegular.copyWith(color: OColors.primaryColor500)),
                        ]),
                      ),

                      /// Make Space
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  ODeviceUtils.buildRatingStars(1),
                                  Text("4.8 | 5.253 reviews",style: OStyles.h3Bold.copyWith(color: OColors.greyText,fontSize: 11.sp)),
                                ],
                              ),
                              SizedBox(height: 12.h),
                              Row(
                                children: [
                                  Icon(Icons.phone_iphone_outlined,color: OColors.primaryColor500, size: 20.sp),
                                  SizedBox(width: 6.w),
                                  Text("09966000000",style: OStyles.h3Bold.copyWith(fontSize: 14.sp)),
                                ],
                              ),
                            ],
                          ),

                          /// Make Space
                          // SizedBox(height: 12.h),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                              // Icon(Icons.phone_iphone_outlined,color: OColors.primaryColor500, size: 20.sp),
                              // SizedBox(width: 6.w),
                              // Text("09966000000",style: OStyles.h3Bold.copyWith(fontSize: 14.sp)),
                              SizedBox(width: 5.w),
                              Icon(Icons.edit_outlined,color: OColors.greyScale400, size: 18.sp),
                            // ],
                          // ),
                        ],
                      )
                    ],
                  ),
                ),

                /// Make Space
                SizedBox(height: 24.h),

                /// ListTil
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: List.generate(
                      listTilTextInProfile.length,
                          (index) {
                        return ListTile(
                          onTap: index == 4 || index == 1 ? null : () =>
                              navigateBasedOnIndex(context, index),
                          contentPadding: EdgeInsets.zero,
                          leading: SvgPicture.asset(
                              OConstants.listTilIconsInProfile[index], width: 28.w,
                              height: OConstants.listTilIconsInProfile[index] == OImages.removeAccountIcon ? 30.h : 28.h,
                              fit: BoxFit.scaleDown),
                          title: Text(listTilTextInProfile[index],
                              style: OStyles.bodyXLargeSemiBold),
                          trailing: index == 4 ?
                          // SwitchWidget(valueData: isDarkModeEnabled) :
                          SwitchWidget(onChanged: (value) {
                            setState(() => isDarkModeEnabled = value);
                          }, valueData:  isDarkModeEnabled) :
                          index == 1 ?
                          SwitchWidget(onChanged: (value) {
                            setState(() => isOnNotificationEnabled = value);
                          }, valueData:  isOnNotificationEnabled) :
                          // SwitchWidget(valueData: isOnNotificationEnabled) :
                          SizedBox(
                            width: 160.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                index == 3
                                    ? Text(AppLocalizations.of(context)!.isEnLocale ? 'English (US)' : 'العربية',
                                    style: OStyles.bodyXLargeSemiBold)
                                    : const SizedBox.shrink(),
                                index == 3 ? SizedBox(width: 20.w) : const SizedBox
                                    .shrink(),
                                SvgPicture.asset(AppLocalizations.of(context)!.isEnLocale ? OImages.arrowRightIOS2 : OImages.arrowLeftIOS2, width: 20.w,
                                    height: 20.h),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _openImageGalleryToPerson() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImageToPerson = image;
      });
    } else {
      print('No image selected');
    }
  }

  void navigateBasedOnIndex(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.pushReplacementNamed(ORoutesName.editProfileRoute);
        break;
      case 2:
        context.pushNamed(ORoutesName.walletRoute);
        break;
      case 3:
        ODeviceUtils.showCustomBottomSheet(context: context, widget: const ChangeLanguageWidget());
        break;
      // case 3:
      //   context.pushNamed(ORoutesName.changePasswordRoute);
        break;
      case 5:
        context.pushNamed(ORoutesName.privacyPolicyRoute);
        break;
      case 6:
        context.pushNamed(ORoutesName.helpCenterRoute);
        break;
      case 7:
        context.pushNamed(ORoutesName.inviteFriendsRoute);
      case 8:
        ODeviceUtils.showCustomBottomSheet(context: context, widget: const LogoutWidget());
      case 9:
        ODeviceUtils.showCustomBottomSheet(context: context, widget: const RemoveAccountWidget());
        break;
      default:
        break;
    }
  }
}

class ChangeLanguageWidget extends StatefulWidget {
  const ChangeLanguageWidget({super.key});

  @override
  State<ChangeLanguageWidget> createState() => _ChangeLanguageWidgetState();
}

class _ChangeLanguageWidgetState extends State<ChangeLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ODeviceUtils.getScreenHeight(context) / 3.6,
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      child: Column(
        children: [
          /// Make Space
          SizedBox(height: 35.h),

          SizedBox(width: double.infinity, height: ODeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('changeLanguage')!, style: OStyles.h4Bold.copyWith(color: OColors.alertsAndStatusError), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 24.h),

          Container(width: double.infinity, height: 1.w, color: OColors.greyScale200,),

          /// Make Space
          SizedBox(height: 24.h),

          SizedBox(width: double.infinity, height: ODeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('choiceFromTwoLanguages')!, style: OStyles.h5Bold.copyWith(color: OColors.greyScale800), textAlign: TextAlign.center)),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              OCacheHelper.putString(key: CacheKeys.lang, value: 'ar');
              BlocProvider.of<LocaleCubit>(context).toArabic();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: ODeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('arabic')!, style: OStyles.h5Bold.copyWith(color: AppLocalizations.of(context)!.isEnLocale ? OColors.greyScale800 : OColors.primaryColor500))),
                SvgPicture.asset(
                  OImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? OColors.greyScale900 : OColors.primaryColor500,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),

          /// Make Space
          SizedBox(height: 12.h),

          InkWellWidget(
            onTap: () {
              OCacheHelper.putString(key: CacheKeys.lang, value: 'en');
              BlocProvider.of<LocaleCubit>(context).toEnglish();
              context.pop();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: ODeviceUtils.getScreenHeight(context) / 26, child: Text(AppLocalizations.of(context)!.translate('english')!, style: OStyles.h5Bold.copyWith(color: AppLocalizations.of(context)!.isEnLocale ? OColors.primaryColor500 : OColors.greyScale800))),
                SvgPicture.asset(
                  OImages.checkIcon,
                  height: 18.h,
                  colorFilter: ColorFilter.mode(
                    AppLocalizations.of(context)!.isEnLocale ? OColors.primaryColor500 : OColors.greyScale900,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
