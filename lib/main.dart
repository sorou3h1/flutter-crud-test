import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mc_crud_test/core/resoruces/colors/color_pallete.dart';
import 'package:mc_crud_test/features/customer/data/datasources/hive_storage.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/cubit/customer_cubit.dart';
import 'package:mc_crud_test/features/customer/presentation/pages/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var selectedColors = LightThemeColors2();

    Hive.registerAdapter(CustomerAdapter());

    return BlocProvider<CustomerCubit>(
      create: (context) => CustomerCubit(hiveStorage: HiveStorageImpl()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Customers CRUD',
        theme: ThemeData(
          primaryColor: selectedColors.primary,
          colorScheme: ColorScheme.fromSeed(
            brightness: selectedColors.brightness,
            seedColor: selectedColors.primary,
            background: selectedColors.background,
            onBackground: selectedColors.onBackground,
            surface: selectedColors.surface,
            onSurface: selectedColors.onSurface,
            onPrimary: selectedColors.onPrimary,
            // secondary: selectedColors.secondary,
            // onSecondary: selectedColors.onSecondary,
          ),
          useMaterial3: true,
          iconTheme: IconThemeData(
            color: selectedColors.onBackground,
          ),
        ),
        home: const MainPage(),
      ),
    );
  }
}
