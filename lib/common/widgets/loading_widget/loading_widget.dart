import 'package:osta/utils/constants/exports.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.iconColor});

  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return SpinKitFadingCircle(color: iconColor, duration: const Duration(milliseconds: 800));
  }
}
