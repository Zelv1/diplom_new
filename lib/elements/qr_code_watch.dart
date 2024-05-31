import 'package:diplom_new/features/api_url.dart';
import 'package:flutter/material.dart';

class QRCodeWatcher extends StatelessWidget {
  final String url;
  const QRCodeWatcher({required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios_new,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
      body: Center(
          child: Image.network(
        BASE_URL + url,
        fit: BoxFit.cover,
      )),
    );
  }
}
