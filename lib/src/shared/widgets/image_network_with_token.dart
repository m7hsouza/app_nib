import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageNetworkWithToken extends StatelessWidget {
  const ImageNetworkWithToken(this.src, {super.key, this.fit});
  final String src;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      fit: fit,
      headers: {
        'Authorization': context.read<HttpService>().client.options.headers['Authorization'],
      },
    );
  }
}
