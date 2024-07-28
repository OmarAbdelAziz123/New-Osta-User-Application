import 'package:osta_user_app/utils/constants/exports.dart';
import 'package:osta_user_app/utils/constants/log_util.dart';

class SwitchWidget extends StatefulWidget {
  // SwitchWidget({super.key, this.valueData = false});
  SwitchWidget({super.key, required this.onChanged, required this.valueData});

  bool? valueData;
  void Function(bool)? onChanged;

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: widget.valueData!,
      onChanged: (bool value) {
        setState(() => widget.onChanged?.call(value)); // Call the onChanged callback
      },
      // onChanged: (bool value) {
      //   setState(() => widget.valueData = value);
      //   logSuccess(widget.valueData.toString());
      // },
      activeColor: OColors.primaryColor500,
      activeTrackColor: OColors.primaryColor500,
      inactiveTrackColor: OColors.greyScale200,
      trackOutlineWidth: MaterialStateProperty.all(0.w),
      trackColor: MaterialStateProperty.all(widget.valueData! ? OColors.primaryColor500 : OColors.greyScale200),
      trackOutlineColor: MaterialStateProperty.all(widget.valueData! ? OColors.primaryColor500 : OColors.greyScale200),
      thumbColor: MaterialStateProperty.all(OColors.whiteColor),
      thumbIcon: MaterialStateProperty.all(Icon(Icons.circle, color: OColors.whiteColor)),
    );
  }
}