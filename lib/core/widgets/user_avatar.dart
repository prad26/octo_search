import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays a user's avatar image, typically circular.
///
/// It uses [CachedNetworkImage] to efficiently load and cache the image
/// from the provided [url]. While the image is loading, a circular progress
/// indicator is shown. If the image fails to load, a default person icon is displayed.
class UserAvatar extends StatelessWidget {
  /// The URL of the user's avatar image.
  final String url;

  /// The diameter of the circular avatar.
  ///
  /// Defaults to 36.0 pixels.
  final double size;

  const UserAvatar({
    super.key,
    required this.url,
    this.size = 36,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: size,
      height: size,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Padding(
        padding: EdgeInsets.all(size * 0.2),
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.person_rounded),
    );
  }
}
