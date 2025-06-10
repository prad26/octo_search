import 'package:flutter/material.dart';
import 'package:octo_search/core/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a URL in the appropriate app or browser.
///
/// This function handles different URL types (web URLs, email addresses, telephone numbers)
/// and shows [showErrorSnackBar] if the URL couldn't be opened.
///
/// [context] is used to show error messages.
/// [url] is the URL to open.
Future<bool> openLink(BuildContext context, String url) async {
  void onError() {
    showErrorSnackBar(
      context: context,
      message: 'Could not open $url',
      onRetry: () => openLink(context, url),
    );
  }

  url = url.trim();
  if (url.isEmpty) {
    onError();

    return false;
  }

  final isEmail = url.startsWith('mailto:');
  final isTelephone = url.startsWith('tel:');

  if (!url.startsWith('http') && !isEmail && !isTelephone) {
    url = 'https://$url';
  }

  try {
    final uri = Uri.parse(url);
    final launched = await launchUrl(
      uri,
      mode: isEmail || isTelephone ? LaunchMode.externalApplication : LaunchMode.inAppBrowserView,
    );

    if (!launched) {
      onError();
    }

    return launched;
  } catch (e) {
    onError();
    return false;
  }
}
