import 'package:floating_snackbar/floating_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class ODeviceUtils {
  // static Future<XFile?> pickImageFromGallery() async {
  //   final ImagePicker picker = ImagePicker();
  //   final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //   return image;
  // }

  String formatDateStringFromApi(
      {required String dateString,
        required String dateFormat,
        required BuildContext context}) {
    // Create a DateTime object from the string
    DateTime date = DateTime.parse(dateString);
    // Format the date using DateFormat
    String formattedDate =
    DateFormat(dateFormat).format(date);
    // logSuccess(formattedDate);
    return formattedDate;
  }

  static String formatDateString({required DateTime date, required String dateFormat, required BuildContext context}) {
    // Format the date using DateFormat
    String formattedDate = DateFormat(dateFormat).format(date);
    // logSuccess(formattedDate);
    return formattedDate;
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  static Future<List<File>> pickImagesFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile>? images = await picker.pickMultiImage();
    if (images != null && images.isNotEmpty) {
      return images.map((image) => File(image.path)).toList();
    }
    return [];
  }

  static void showDialogFunction(
      {required BuildContext context, required String imagePath}) async {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24.r),
              ),
            ),
            insetPadding: EdgeInsets.symmetric(horizontal: 2.w),
            content: SizedBox(
              width: 340.w,
              height: 487.h,
              child: Align(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),
                        SvgPicture.asset(imagePath,
                            fit: BoxFit.scaleDown, width: 186.w, height: 180.h),
                        SizedBox(height: 32.h),
                        Text('Congratulations!',
                            style: OStyles.h4Bold, textAlign: TextAlign.center),
                        SizedBox(height: 16.h),
                        Text(
                            'Your account is ready to use. You will be redirected to the Home page in a few seconds..',
                            style: OStyles.bodyLargeRegular,
                            textAlign: TextAlign.center),
                        SizedBox(height: 32.h),

                        /// Loading
                        LoadingWidget(iconColor: OColors.primaryColor500),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static Container buildDotWidget(int index, int currentIndex,
      BuildContext context, Decoration decoration) {
    return Container(
      height: 8.h,
      width: currentIndex == index ? 32.w : 8.w,
      margin: EdgeInsets.only(right: 6.w),
      decoration: decoration,
    );
  }

  static void showCustomBottomSheet(
      {required BuildContext context, required Widget widget}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.r), topRight: Radius.circular(40.r))),
      backgroundColor: Colors.transparent,
    );
  }

  static void showSnackBar({
    required BuildContext context,
    required String message,
    required Color textColor,
    required TextStyle textStyle,
    Color? bgColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: textStyle.copyWith(color: textColor),
        ),
        backgroundColor: bgColor,
        duration: const Duration(milliseconds: 4000),
      ),
    );
  }

  static void initCacheHelper() async {
    await OCacheHelper.init();
  }

  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<void> setStatusBarColor(Color color) async {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: color),
    );

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  static bool isLandscapeOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom == 0;
  }

  static bool isPortraitOrientation(BuildContext context) {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom != 0;
  }

  static void setFullScreen(bool enable) {
    SystemChrome.setEnabledSystemUIMode(
        enable ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getPixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  static double getStatusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  static double getBottomNavigationBarHeight() {
    return kBottomNavigationBarHeight;
  }

  static double getAppBarHeight() {
    return kToolbarHeight;
  }

  static double getKeyBarHeight(BuildContext context) {
    final viewInsets = MediaQuery.of(context).viewInsets;
    return viewInsets.bottom;
  }

  static Future<bool> isKeyboardVisible(BuildContext context) async {
    final viewInsets = View.of(context).viewInsets;
    return viewInsets.bottom > 0;
  }

  static isPhysicalDevice() async {
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  static void vibrate(Duration duration) {
    HapticFeedback.vibrate();
    Future.delayed(duration, () => HapticFeedback.vibrate());
  }

  static Future<void> setPreferredOrientations(
      List<DeviceOrientation> orientations) async {
    await SystemChrome.setPreferredOrientations(orientations);
  }

  static void hideStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  static void showStatusBar() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
    );
  }

  static Future<bool> hasInternetConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  static bool isIOS() {
    return Platform.isIOS;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static void launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
