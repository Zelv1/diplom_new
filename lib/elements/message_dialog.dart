import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';

void showMessageDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          'Внимание!',
          style: authTag,
        ),
        content: Text(
          message,
          maxLines: null,
          textAlign: TextAlign.justify,
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('ОК', style: headerTextStyleBlack))
        ],
      );
    },
  );
}
