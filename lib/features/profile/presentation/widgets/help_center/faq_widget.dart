import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:osta/common/widgets/loading_widget/loading_services_widget.dart';
import 'package:osta/features/profile/managers/profile_cubit.dart';
import 'package:osta/features/profile/presentation/widgets/help_center/container_faq_widget.dart';
import 'package:osta/features/profile/presentation/widgets/help_center/question_container_widget.dart';
import 'package:osta/utils/constants/log_util.dart';

import '../../../../../utils/constants/exports.dart';

class FaqWidget extends StatefulWidget {
  const FaqWidget({Key? key}) : super(key: key);

  @override
  State<FaqWidget> createState() => _FaqWidgetState();
}

class _FaqWidgetState extends State<FaqWidget> {
  TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool issearchFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;
  int selectedCategoryName = 0;
  int selectedSpecificQuestion = -1;
  int indexGlobal = 0;

  @override
  void initState() {
    ProfileCubit.get(context).getAllFaqsCategoryFunc();
    super.initState();
    /// Add listener to focus node
    searchFocusNode.addListener(() => setState(() => issearchFieldFocused = searchFocusNode.hasFocus));

    /// Add listener to search controller
    searchController.addListener(() {
      if (searchController.text.isEmpty) {
        // Call your function when search text is cleared
        ProfileCubit.get(context).getAllFaqsIndexCategoryFunc(categoryId: indexGlobal);
      }
    });
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) async {
        if(state is GetAllFaqsCategorySuccessState) {
          await ProfileCubit.get(context).getAllFaqsIndexCategoryFunc(categoryId: state.resultList![0].id!);
        }
      },
      builder: (context, state) {
        var faqsCubit = ProfileCubit.get(context);

        return faqsCubit.getAllFaqsModel.result == null
            ? LoadingWidget(iconColor: OColors.primaryColor500)
            : Container(
          color: OColors.greyScale50,
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                /// Make Size
                SizedBox(height: 24.h),
                /// Container Type (Category)
                SizedBox(
                  height: 38.h,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: faqsCubit.getAllFaqsModel.result!.length,
                      itemBuilder: (context,index) {
                        return ContainerFaqWidget(
                          onTap: () {
                            setState(() {
                              selectedCategoryName = index;
                            });
                            if(indexGlobal == faqsCubit.getAllFaqsModel.result![index].id!) {
                              ODeviceUtils.showSnackBar(context: context, message: AppLocalizations.of(context)!.translate('youWillNotBeAble')!, textStyle: OStyles.bodyLargeRegular, textColor: OColors.whiteColor, bgColor: OColors.warning);
                            }
                            else {
                              /// Make Filter
                              faqsCubit.getAllFaqsIndexCategoryFunc(categoryId: faqsCubit.getAllFaqsModel.result![index].id!);
                              indexGlobal = faqsCubit.getAllFaqsModel.result![index].id!;
                              faqsCubit.getAllFaqsIndexModel.allDataIndex = null;
                            }
                        },
                        isPressed: selectedCategoryName == index,
                        text: faqsCubit.getAllFaqsModel.result![index].name!);
                      // return ContainerFaqWidget(text: OConstants.faqText[index]);
                      }),
                ),
                /// Make Size
                SizedBox(height: 24.h),
                /// Search
                TextFormFieldWidget(
                  controller: searchController,
                  textInputType: TextInputType.emailAddress,
                  focusNode: searchFocusNode,
                  hintText: AppLocalizations.of(context)!.translate('search')!,
                  hintColor: issearchFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
                  prefixIcon: Image.asset(OImages.searchIcon2,color: issearchFieldFocused ? OColors.primaryColor500 : OColors.greyScale400),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /// Clear Search Bar
                      if(searchController.text.isNotEmpty) InkWellWidget(
                          onTap: () {
                            if(searchController.text.isNotEmpty) {
                              faqsCubit.getAllFaqsIndexModel.allDataIndex = null;
                              searchController.clear();
                              faqsCubit.getAllFaqsIndexCategoryFunc(categoryId: indexGlobal);
                            } else {

                            }
                          },
                          child: Icon(Icons.close, color: OColors.primaryColor500)
                      ),

                      /// Make Size
                      // SizedBox(width: 16.w),

                      // /// Make Search
                      // InkWellWidget(
                      //   onTap: () {
                      //     if(searchController.text.isNotEmpty) {
                      //       /// Make Filter
                      //       faqsCubit.getAllFaqsIndexCategoryFunc(search: searchController.text, categoryId: indexGlobal);
                      //       logSuccess('$indexGlobal --------');
                      //     } else {
                      //
                      //     }
                      //   },
                      //   child: Image.asset(OImages.filterIcon),
                      // ),
                      // SizedBox(width: 16.w),
                    ],
                  ),
                  // suffixIcon:SvgPicture.asset(OImages.filterIcon,width: 20.w,height: 20,),
                  fillColor: issearchFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale100,
                  borderSide: issearchFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
                  obscureText: false,
                  onChanged: (data) {
                    setState(() {});
                    if(searchController.length >= 2) {
                      faqsCubit.getAllFaqsIndexCategoryFunc(search: data);
                    }
                    if(searchController.text.isEmpty) {
                      ProfileCubit.get(context).getAllFaqsCategoryFunc();
                    }
                  },
                ),

                /// Make Size
                faqsCubit.getAllFaqsIndexModel.allDataIndex == null || state is GetAllFaqsCategoryIndexLoadingState
                ? Column(
                  children: [
                    SizedBox(height: 34.h),
                    LoadingWidget(iconColor: OColors.primaryColor500),
                  ],
                )
                : SizedBox(
                  height: ODeviceUtils.getScreenHeight(context) / 1.7,
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: faqsCubit.getAllFaqsIndexModel.allDataIndex!.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 24.h);
                      },
                      itemBuilder: (context,index){
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if(selectedSpecificQuestion == index) {
                                selectedSpecificQuestion = -1;
                              } else {
                                selectedSpecificQuestion = index;
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(24.sp),
                            decoration: BoxDecoration(
                                color: OColors.whiteColor,
                                borderRadius: BorderRadius.circular(20.h),
                                boxShadow: [AppBoxShadows.cardShadowTwo]
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: ODeviceUtils.getScreenWidth(context) / 1.4,
                                      child: Text(faqsCubit.getAllFaqsIndexModel.allDataIndex![index].question.toString(), style: OStyles.h6Bold, overflow: TextOverflow.ellipsis),
                                    ),
                                    SvgPicture.asset(OImages.arrowButton,color: OColors.primaryColor500,width: 24.w,height: 24.h)
                                  ],
                                ),
                                selectedSpecificQuestion == index ? Column(
                                  children: [
                                    SizedBox(height: 16.h),
                                    const Divider(thickness: 0.5),
                                    SizedBox(height: 16.h),
                                    Text(faqsCubit.getAllFaqsIndexModel.allDataIndex![index].answer.toString(), style: OStyles.bodyMediumMedium, maxLines: 5, overflow: TextOverflow.ellipsis)
                                  ],
                                ): const SizedBox(),
                              ],
                            ),
                          ),
                        );
                        // return ContainerFaqWidget(text: OConstants.faqText[index]);
                      }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
