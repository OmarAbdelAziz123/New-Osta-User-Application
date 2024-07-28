import '../../../../../../utils/constants/exports.dart';

class ComponentSaveThisLocationForLater extends StatefulWidget {
  ComponentSaveThisLocationForLater({super.key, required this.containerColor, required this.bgColor, required this.icon, required this.containerName, this.onTap});
  final Color containerColor, bgColor;
  final IconData icon;
  final String containerName;
  // bool isTap = false;
  void Function()? onTap;

  @override
  State<ComponentSaveThisLocationForLater> createState() => _ComponentSaveThisLocationForLaterState();
}

class _ComponentSaveThisLocationForLaterState extends State<ComponentSaveThisLocationForLater> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left: 22.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: widget.onTap,
            // onTap: (){
            //   setState(() {
            //     setState(() {
            //       widget.isTap = !widget.isTap;
            //     });
            //   });
            // },
            child: CircleAvatar(
              radius: 35.r,
              backgroundColor: widget.bgColor,
              // backgroundColor: widget.isTap ? OColors.primaryColor500 : OColors.whiteColor,
              child: Icon(widget.icon,size: 30.sp,color: OColors.blackColor),

            ),
          ),
          SizedBox(height: 5.h),
          Text(widget.containerName,style: OStyles.bodyXLargeSemiBold)
        ],
      ),
    );
  }
}