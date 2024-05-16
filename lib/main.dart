import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/bloc/simple_bloc_observer.dart';
import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<GetOrderInfoBloc>(create: (context) => GetOrderInfoBloc()),
        BlocProvider<CreateOrderBloc>(create: (context) => CreateOrderBloc())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //     colorScheme: ColorScheme.fromSeed(
        //         seedColor: Colors.amber, brightness: Brightness.dark)),
        home: Scaffold(
          body: SignInPage(),
        ),
      ),
    );
  }
}
