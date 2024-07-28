import 'package:cached_network_image/cached_network_image.dart';
import 'package:lottie/lottie.dart';
import 'package:osta_user_app/utils/constants/exports.dart';

class CachNetworkImages extends StatelessWidget {
  const CachNetworkImages({super.key, required this.imageUrl, this.topLeftRadius = 0, this.topRightRadius = 0, this.bottomLeftRadius = 0, this.bottomRightRadius = 0, required this.width, required this.height});

  final String imageUrl;
  final double topLeftRadius;
  final double topRightRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(topLeftRadius),
        topRight: Radius.circular(topRightRadius),
        bottomRight: Radius.circular(bottomRightRadius),
        bottomLeft: Radius.circular(bottomLeftRadius),
      ),
      child: CachedNetworkImage(
        progressIndicatorBuilder: (context, url, downloadProgress) {
          return Image.asset(
            "assets/images/gifs/loading.gif",
            fit: BoxFit.cover,
          );
        },
        errorWidget: (context, url, error) => Lottie.asset(OImages.profileLoading),
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        width: width, // Adjust width and height to match the CircleAvatar radius
        height: height,
        // placeholder: (context, url) => Lottie.asset(OImages.profileLoading),
        // errorWidget: (context, url, error) => Lottie.asset(OImages.profileLoading),
      ),
    );
  }
}
