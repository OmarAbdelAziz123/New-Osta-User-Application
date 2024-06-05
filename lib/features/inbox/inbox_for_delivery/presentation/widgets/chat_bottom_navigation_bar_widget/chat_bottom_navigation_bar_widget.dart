import '../../../../../../utils/constants/exports.dart';

class ChatBottomNavigationBarWidget extends StatefulWidget {
  ChatBottomNavigationBarWidget({Key? key, this.onTap}) : super(key: key);
  void Function()? onTap;

  @override
  State<ChatBottomNavigationBarWidget> createState() => _ChatBottomNavigationBarWidgetState();
}

class _ChatBottomNavigationBarWidgetState extends State<ChatBottomNavigationBarWidget> {

  TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  bool isFieldFocused = false;
  bool isChecked = false;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    /// Add listener to focus node
    focusNode.addListener(() => setState(() => isFieldFocused = focusNode.hasFocus));
  }

  @override
  void dispose() {
    /// Clean up the focus node and controller when the widget is disposed.
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: TextFormFieldWidget(
              controller: controller,
              textInputType: TextInputType.emailAddress,
              focusNode: focusNode,
              hintText: 'Message',
              hintColor: isFieldFocused ? OColors.primaryColor500 : OColors.greyScale500,
              suffixIcon: Icon(Icons.image,color: OColors.greyScale300,size: 25.sp),
              fillColor: isFieldFocused ? OColors.purpleTransparent.withOpacity(.08) : OColors.greyScale50,
              borderSide: isFieldFocused ? BorderSide(color: OColors.primaryColor500) : BorderSide.none,
              obscureText: false,
            ),
          ),
          SizedBox(width: 16.w),
          InkWell(onTap: widget.onTap, child: Container(
            height: 56.h,
            width: 56.w,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.r),
                gradient: AppGradients.purpleGradient
            ),
            child: Center(
              child: Icon(controller.text.isNotEmpty ? Icons.send : Icons.mic,color: OColors.whiteColor),
            ),
          )),
        ],
      ),
    );
  }
}
