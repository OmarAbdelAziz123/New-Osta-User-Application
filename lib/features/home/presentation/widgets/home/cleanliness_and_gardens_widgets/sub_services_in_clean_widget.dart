import 'package:flutter/material.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class SubServicesInCleanWidget extends StatefulWidget {
  const SubServicesInCleanWidget({
    super.key,
    required this.subServiceName,
    required this.onTap,
    required this.numberOfPieces,
    required this.onPressed,
    required this.isSelected,
  });

  final String subServiceName;
  final VoidCallback onTap;
  final String numberOfPieces;
  final void Function() onPressed;
  final bool isSelected;

  @override
  State<SubServicesInCleanWidget> createState() => _SubServicesInCleanWidgetState();
}

class _SubServicesInCleanWidgetState extends State<SubServicesInCleanWidget> {
  @override
  Widget build(BuildContext context) {
    void handleTap() {
      widget.onTap();
    }

    return Stack(
      children: [
        Container(
          height: 55.h,
          padding: EdgeInsets.only(top: 10.h),
          child: GestureDetector(
            onTap: () {
              setState(() {
                handleTap();
              });
            },
            child: AnimatedContainer(
              curve: Curves.easeInOut,
              height: 40.h,
              width: 97.w,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: widget.isSelected ? OColors.primaryColor500 : OColors.whiteColor,
                border: Border.all(color: OColors.primaryColor500, width: 2.w),
                boxShadow: [AppBoxShadows.cardShadowTwo],
              ),
              child: Center(
                child: Text(
                  widget.subServiceName,
                  style: OStyles.bodyLargeBold.copyWith(
                    color: widget.isSelected ? OColors.whiteColor : OColors.primaryColor500,
                  ),
                ),
              ),
            ),
          ),
        ),
        widget.numberOfPieces != '0'
            ? Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 25.w,
            height: 25.h,
            decoration: BoxDecoration(
              gradient: AppGradients.greenGradient,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Center(
              child: Text(
                widget.numberOfPieces,
                style: OStyles.bodyLargeRegular.copyWith(color: OColors.whiteColor),
              ),
            ),
          ),
        )
            : const SizedBox(),
        widget.numberOfPieces != '0'
            ? Positioned(
          top: 0,
          left: 0,
          child: Container(
            width: 25.w,
            height: 25.h,
            decoration: BoxDecoration(
              gradient: AppGradients.redGradient,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: InkWellWidget(
              onTap: widget.onPressed,
              child: Center(
                child: InkWellWidget(
                  onTap: widget.onPressed,
                  child: Icon(Icons.minimize, size: 12.sp, color: OColors.whiteColor),
                ),
              ),
            ),
          ),
        )
            : const SizedBox(),
      ],
    );
  }
}
