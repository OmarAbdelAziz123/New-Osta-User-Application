import '../../../../../utils/constants/exports.dart';

class ContainerInfoWidget extends StatelessWidget {
  const ContainerInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        color: OColors.whiteColor,
        border: Border.all(
          width: 0.1.w,
          color: OColors.greyScale500
        ),
        boxShadow: [AppBoxShadows.cardShadowThree]
      ),
      width: double.infinity,
      height: 150.h,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15.w, right: 15.w,top: 8.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: Row(
                    children: [
                      SvgPicture.asset(OImages.profileLogo, fit: BoxFit.scaleDown),
                      SizedBox(width: 5.w),
                      Text("Amira Adel",style: OStyles.h6Bold),
                      const Spacer(),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: OColors.error.withOpacity(0.4),
                        child: Center(
                          child: Icon(Icons.location_on,color: OColors.error,size: 20.sp),
                        ),
                      ),
                      SizedBox(width: 5.w),
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: OColors.primaryColor100,
                        child: Center(
                          child: Icon(Icons.call,color: OColors.primaryColor500,size: 20.sp),
                        ),
                      ),


                    ],
                  ),
                ),
                /// Make Space
                SizedBox(height: 12.h),

                Container(width: double.infinity, height: 1.w, color: OColors.greyScale200,),

                /// Make Space
                SizedBox(height: 12.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.camera_alt,size: 23.sp,color: OColors.primaryColor500),
                        SizedBox(width: 8.w),
                        Text("Invoice copy",style: OStyles.bodyMediumSemiBold)
                      ],
                    ),
                    Container(width: 2.w, height: 25.h, color: OColors.greyScale200,),
                    Row(
                      children: [
                        Icon(Icons.add_box_outlined,size: 23.sp,color: OColors.primaryColor500),
                        SizedBox(width: 8.w),
                        Text("Additional materials",style: OStyles.bodyMediumSemiBold)
                      ],
                    ),
                  ],
                ),

                /// Make Space
                SizedBox(height: 12.h),



              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                  color: OColors.primaryColor100,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.r),bottomRight: Radius.circular(15.r))
              ),
              child: Center(
                child: Text("Arrived",style: OStyles.bodyMediumMedium.copyWith(color: OColors.primaryColor500),),
              ),
            ),
          )
        ],
      )
    );
  }
}
