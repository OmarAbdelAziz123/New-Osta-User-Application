import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:osta/utils/constants/exports.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.selectedItem, required this.items, required this.isInFillProfile, this.onItemSelected});

  String selectedItem;
  List<String> items;
  bool isInFillProfile = false;
  final Function(String?)? onItemSelected;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  @override
  Widget build(BuildContext context) {
    String? validSelectedItem = widget.items.contains(widget.selectedItem) ? widget.selectedItem : widget.items[0];

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: OColors.greyScale50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(left: 14.w),
      child: DropdownButton(
        value: validSelectedItem,
        onChanged: (gender) {
          setState(() => widget.selectedItem = gender!);
          if (widget.onItemSelected != null) {
            widget.onItemSelected!(gender);
          }
        },
        items: widget.items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender, style: OStyles.bodyMediumSemiBold.copyWith(color: widget.isInFillProfile ? OColors.greyScale900 : OColors.blackColor)))).toList(),
        isExpanded: true,
        icon: IconButton(onPressed: null, icon: SvgPicture.asset(OImages.arrowButton, color: widget.isInFillProfile ? OColors.greyScale500 : OColors.blackColor), ),
        underline: Container(),
        dropdownColor: OColors.greyScale50,
      ),
    );
  }
}
