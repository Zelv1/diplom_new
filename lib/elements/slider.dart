import 'package:action_slider/action_slider.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';

class SliderOrder extends StatelessWidget {
  final VoidCallback onBack;

  const SliderOrder({
    required this.onBack,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      toggleColor: const Color.fromARGB(255, 35, 33, 33),
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.08,
      backgroundColor: whiteColor,
      icon: const Icon(Icons.arrow_forward_ios_rounded,
          color: whiteColor, size: 33),
      loadingIcon: const CircularProgressIndicator(
        color: whiteColor,
      ),
      successIcon: const Icon(Icons.check, color: whiteColor),
      action: (controller) async {
        controller.loading();
        await Future.delayed(const Duration(seconds: 1));
        controller.success();
        await Future.delayed(const Duration(seconds: 1));
        onBack();
      },
      child: Text('Заказ выдан', style: headerTextStyleBlack),
    );
  }
}
