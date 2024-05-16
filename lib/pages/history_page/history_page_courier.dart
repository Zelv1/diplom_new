import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:diplom_new/pages/main_page/main_page_courier.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPageCourier extends StatefulWidget {
  const HistoryPageCourier({super.key});

  @override
  State<HistoryPageCourier> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPageCourier> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrderInfoBloc>().add(GetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: blackColor,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: whiteColor,
            ),
            onPressed: () => {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainPageCourier()),
              ),
            },
          ),
          title: Text('История заказов', style: headerTextStyleWhite),
        ),
        body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
          builder: (context, state) {
            if (state is GetOrderInfoLoaded) {
              return ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (context, index) {
                    return ProductCardModel(
                      index: index,
                    );
                  });
            }
            return const Center(child: Text('История пуста'));
          },
        ));
  }
}
