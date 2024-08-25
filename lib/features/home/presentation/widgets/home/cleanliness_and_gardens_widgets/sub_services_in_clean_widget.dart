import 'package:flutter/material.dart';
import 'package:osta/features/home/models/services/sub_service_model.dart';
import 'package:osta/utils/constants/exports.dart';

class SubServicesInCleanWidget extends StatefulWidget {
  SubServicesInCleanWidget({
    super.key,
    this.subService,
    required this.onTap,
    required this.isSelected,
    required this.onSelect,
  });

  final SubService? subService;
  final VoidCallback onTap;
  final void Function(Spaces) onSelect;
  final bool isSelected;

  @override
  State<SubServicesInCleanWidget> createState() =>
      _SubServicesInCleanWidgetState();
}

class _SubServicesInCleanWidgetState extends State<SubServicesInCleanWidget> {
  Spaces _space = Spaces();

  @override
  void initState() {
    if (widget.subService?.spaces != null &&
        widget.subService!.spaces!.isNotEmpty) {
      _space = widget.subService!.spaces![0];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: InkWell(
        onTap: widget.onTap,
        child: Column(
          children: [
            SizedBox(
              height: 72.5.h,
              child: Stack(
                children: [
                  AnimatedContainer(
                    curve: Curves.easeInOut,
                    height: 60,
                    duration: const Duration(milliseconds: 300),
                    padding: EdgeInsets.all(12.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      color: OColors.whiteColor,
                      border: Border.all(
                          color: OColors.primaryColor500, width: 2.w),
                      boxShadow: [AppBoxShadows.cardShadowTwo],
                    ),
                    child: Center(
                      child: SvgPicture.asset(OImages.icCleaning),
                    ),
                  ),
                  if (widget.isSelected)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 25.w,
                        height: 25.h,
                        decoration: BoxDecoration(
                          color: OColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check,
                            color: OColors.whiteColor,
                            size: 16.w,
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
            Text(
              widget.subService?.name ?? '',
              style: OStyles.bodyLargeBold.copyWith(
                color: OColors.blackColor,
              ),
            ),
            SizedBox(height: 10.h),
            if (widget.subService?.spaces != null &&
                widget.subService!.spaces!.isNotEmpty)
              Container(
                height: 45.h,
                alignment: Alignment.center,
                width: 100.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    border: Border.all(width: 2, color: OColors.grey)),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: DropdownButton<Spaces>(
                    value: _space,
                    enableFeedback: true,
                    autofocus: true,
                    isExpanded: true,
                    focusColor: Colors.transparent,
                    dropdownColor: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    underline: const SizedBox(),
                    icon: Container(
                      height: 45.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: OColors.grey,
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.r)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: OColors.black,
                        size: 18.sp,
                      ),
                    ),
                    style: const TextStyle(fontSize: 20, color: Colors.black),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          _space = value;
                        });
                        widget.onSelect.call(_space);
                      }
                    },
                    alignment: Alignment.center,
                    items: widget.subService!.spaces!
                        .map<DropdownMenuItem<Spaces>>((Spaces value) {
                      return DropdownMenuItem<Spaces>(
                          alignment: Alignment.center,
                          value: value,
                          child: Text(value.name ?? '',
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: OColors.blackColor,
                                  fontWeight: FontWeight.w500)));
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
