import 'package:action_slider/action_slider.dart';
import 'package:diplom_new/bloc/deliver_order_bloc/deliver_order_bloc.dart';
import 'package:diplom_new/cubit/light_dart_theme_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderOrder extends StatelessWidget {
  final String orderId;
  const SliderOrder({
    required this.orderId,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ActionSlider.standard(
      toggleColor: (context.read<LightDartThemeCubit>().state == false)
          ? Theme.of(context).colorScheme.onPrimary
          : Theme.of(context).colorScheme.secondary,
      width: 500,
      height: MediaQuery.of(context).size.height * 0.08,
      icon: Icon(
        Icons.arrow_forward_ios_rounded,
        size: 33,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      loadingIcon: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.onSurface,
      ),
      successIcon: Icon(
        Icons.check,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      action: (controller) async {
        controller.loading();
        context.read<DeliverOrderBloc>().add(FinishOrderEvent(orderId));

        controller.success();
      },
      child: Text('Заказ выдан',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w500)),
    );
  }
}
