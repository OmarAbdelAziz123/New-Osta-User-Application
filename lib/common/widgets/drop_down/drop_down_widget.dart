import 'package:osta_user_app/utils/constants/exports.dart';

class DropDownWidget extends StatefulWidget {
  DropDownWidget({super.key, required this.selectedItem, required this.items});

  String selectedItem;
  List<String> items;

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
        onChanged: (gender) => setState(() => widget.selectedItem = gender!),
        items: widget.items.map((gender) => DropdownMenuItem(value: gender, child: Text(gender, style: OStyles.bodyMediumSemiBold))).toList(),
        isExpanded: true,
        icon: IconButton(onPressed: null, icon: SvgPicture.asset(OImages.arrowButton)),
        underline: Container(),
        dropdownColor: OColors.greyScale50,
      ),
    );
  }
}
