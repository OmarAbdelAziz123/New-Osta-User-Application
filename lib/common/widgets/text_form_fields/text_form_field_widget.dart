import 'package:osta_user_app/utils/constants/exports.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({super.key, required this.controller, required this.focusNode, required this.hintText, this.prefixIcon, required this.fillColor, required this.borderSide, this.suffixIcon, required this.textInputType, this.validator, required this.obscureText, required this.hintColor, this.textAlign, this.inputFormatters, this.isEdit = false});

  final TextEditingController controller;
  final FocusNode focusNode;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color fillColor;
  final Color hintColor;
  final BorderSide borderSide;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool isEdit;
  final TextAlign? textAlign;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: textInputType,
      inputFormatters: inputFormatters,
      validator: validator,
      style: OStyles.bodyMediumSemiBold.copyWith(color: OColors.greyScale900),
      obscureText: obscureText,
      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: isEdit ? OStyles.bodyMediumSemiBold : OStyles.bodyMediumRegular.copyWith(color: hintColor),
        focusColor: OColors.purpleTransparent,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: borderSide,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: OColors.primaryColor500),
        ),
      ),
    );
  }
}
