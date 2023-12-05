import 'package:app_nib/src/shared/services/http_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SlideTileWidget extends StatelessWidget {
  const SlideTileWidget({super.key, required this.imageURL, required this.active});

  final String imageURL;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final boxShadow = <BoxShadow>[];
    if (active) {
      boxShadow.add(const BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(10, 10),
      ));
    }

    final Map<String, String> headers = {
      'Authorization': context.read<HttpService>().client.options.headers['Authorization'],
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: EdgeInsets.only(
        top: active ? 20 : 40,
        bottom: 20,
        right: 16,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(imageURL, headers: headers),
          fit: BoxFit.cover,
        ),
        boxShadow: boxShadow,
      ),
    );
  }
}
