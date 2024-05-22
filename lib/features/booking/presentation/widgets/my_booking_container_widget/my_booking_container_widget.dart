import '../../../../../utils/constants/exports.dart';

class MyBookingContainerWidget extends StatefulWidget {
  MyBookingContainerWidget({Key? key, required this.bookingImage, required this.bookingJob, required this.bookingName, required this.containerColor, required this.buttonText}) : super(key: key);

  final String bookingImage, bookingJob, bookingName, buttonText;
  final Color containerColor;
  bool showDetailsBooking = false;

  @override
  State<MyBookingContainerWidget> createState() => _MyBookingContainerWidgetState();
}

class _MyBookingContainerWidgetState extends State<MyBookingContainerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.sp),
      width: double.infinity,
      height: widget.showDetailsBooking? 541:192,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        color: OColors.whiteColor,
        boxShadow: [AppBoxShadows.cardShadowTwo]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 100.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32.r),

                ),
                child: Image.asset(widget.bookingImage, fit: BoxFit.scaleDown),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.bookingJob,style: OStyles.h6Bold),
                  SizedBox(height: 12.h),
                  Text(widget.bookingName,style: OStyles.bodySmallMedium),
                  SizedBox(height: 12.h),
                  ThirdButtonWidget(isRejected: false,
                    widgetInButton: Text(widget.buttonText, style: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor)),
                    textStyle: OStyles.bodyXSmallSemiBold.copyWith(color: OColors.whiteColor), containerColor: widget.containerColor, width: 76.w, height: 30.h,borderRadius: 6.r, onTap: () {  },),
                ],
              ),
             const Spacer(),
              SvgPicture.asset(OImages.smsLogo, width: 100.w,height: 50,)
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(thickness: 0.5),
          SizedBox(height: 10.h),
          widget.showDetailsBooking? const DetailsBooking():Container(),
          SizedBox(height: 10.h),
          GestureDetector(
            onTap: (){
              setState(() {
                widget.showDetailsBooking = !widget.showDetailsBooking;
              });
            },
              child: SvgPicture.asset(widget.showDetailsBooking ? OImages.arrowUpIOS : OImages.arrowDownIOS)),

        ],
      ),
    );
  }
}
