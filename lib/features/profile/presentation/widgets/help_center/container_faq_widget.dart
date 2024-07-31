import '../../../../../utils/constants/exports.dart';

class ContainerFaqWidget extends StatefulWidget {
   ContainerFaqWidget({Key? key, required this.text, this.isPressed, this.onTap}) : super(key: key);
  final String text;
  bool? isPressed;
  void Function()? onTap;

  @override
  State<ContainerFaqWidget> createState() => _ContainerFaqWidgetState();
}

class _ContainerFaqWidgetState extends State<ContainerFaqWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.w),
      child: GestureDetector(
        // onTap: (){
        //   setState(() {
        //     widget.isPressed = !widget.isPressed!;
        //   });
        // },
        onTap: widget.onTap,
        child: Container(
          width: 100.w,
          height: 38.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.r),
            color:  widget.isPressed! ? OColors.primaryColor500 : OColors.whiteColor,
            border: Border.all(
              width: 2.w,
              color: OColors.primaryColor500
            )
          ),
          child: Center(
            child: Text(widget.text,style: OStyles.bodyLargeSemiBold.copyWith(color: widget.isPressed! ? OColors.whiteColor : OColors.primaryColor500)),
          ),
        ),
      ),
    );
  }
}
