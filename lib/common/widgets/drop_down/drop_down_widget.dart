import 'package:osta_user_app/utils/constants/exports.dart';

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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: OColors.greyScale50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(left: 14.w),
      child: DropdownButton(
        value: widget.selectedItem,
        onChanged: (gender) {
          setState(() => widget.selectedItem = gender!);
          setState(() => widget.onItemSelected!(gender!));
        },
        items: widget.items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender, style: OStyles.bodyMediumSemiBold.copyWith(color: widget.isInFillProfile ? OColors.greyScale500 : OColors.blackColor)))).toList(),
        isExpanded: true,
        icon: IconButton(onPressed: null, icon: SvgPicture.asset(OImages.arrowButton, color: widget.isInFillProfile ? OColors.greyScale500 : OColors.blackColor), ),
        underline: Container(),
        dropdownColor: OColors.greyScale50,
      ),
    );
  }
}
