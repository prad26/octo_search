import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// A widget that displays a user's avatar image.
///
/// It uses [CachedNetworkImage] to load and cache the image from a URL.
/// It displays a placeholder while loading and an error icon if the image fails to load.
class UserAvatar extends StatelessWidget {
  /// The URL of the user's avatar image.
  final String url;

  /// The size (width and height) of the avatar.
  ///
  /// Defaults to 36.
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
