import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:diplom_new/bloc/deliver_order_bloc/deliver_order_bloc.dart';
import 'package:diplom_new/bloc/edit_profile_data_bloc/edit_profile_data_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/bloc/simple_bloc_observer.dart';
import 'package:diplom_new/cubit/light_dart_theme_cubit.dart';
import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:diplom_new/util/color.dart';
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
        BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
        BlocProvider<GetOrderInfoBloc>(create: (_) => GetOrderInfoBloc()),
        BlocProvider<CreateOrderBloc>(create: (_) => CreateOrderBloc()),
        BlocProvider<DeliverOrderBloc>(create: (_) => DeliverOrderBloc()),
        BlocProvider<EditProfileDataBloc>(create: (_) => EditProfileDataBloc()),
        BlocProvider(create: (_) => LightDartThemeCubit()),
      ],
      child: const NewWidget(),
    );
  }
}

class NewWidget extends StatelessWidget {
  const NewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: context.watch<LightDartThemeCubit>().state
            ? darkColorScheme
            : lightColorScheme,
      ),
      home: const Scaffold(
        body: SignInPage(),
      ),
    );
  }
}
