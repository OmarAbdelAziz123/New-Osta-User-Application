import '../../../../../utils/constants/exports.dart';

class QuestionContainerWidget extends StatefulWidget {
   QuestionContainerWidget({Key? key, required this.questionText, required this.answer}) : super(key: key);
   final String questionText, answer;
   bool isPressed = false;

   @override
  State<QuestionContainerWidget> createState() => _QuestionContainerWidgetState();
}

class _QuestionContainerWidgetState extends State<QuestionContainerWidget> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isPressed = !widget.isPressed;
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
                Text(widget.questionText,style: OStyles.h6Bold),
                SvgPicture.asset(OImages.arrowButton,color: OColors.primaryColor500,width: 24.w,height: 24.h)
              ],
            ),
           widget.isPressed ? Column(
              children: [
                SizedBox(height: 16.h),
                const Divider(thickness: 0.5),
                SizedBox(height: 16.h),
               Text(widget.answer,style: OStyles.bodyMediumMedium)
              ],
            ): SizedBox(),
      ],
        ),
      ),
    );
  }
}
