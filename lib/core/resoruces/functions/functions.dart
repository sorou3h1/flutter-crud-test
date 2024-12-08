import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/resoruces/widgets/my_banner.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/cubit/customer_cubit.dart';

void showResultBanner(bool isSucc, BuildContext context, String succText,
    String failText, bool pop) {
  if (isSucc) {
    BlocProvider.of<CustomerCubit>(context).readCustomers();
    if (pop) {
      Navigator.of(context).pop();
    }

    MyBanner.show(
      context,
      configuredBanner: MyBanner(
        containerDecoration: BoxDecoration(
            color: const Color.fromARGB(255, 52, 201, 57),
            borderRadius: BorderRadius.circular(10)),
        content: [
          Text(
            succText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  } else {
    MyBanner.show(
      context,
      configuredBanner: MyBanner(
        containerDecoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        content: [
          Text(
            failText,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
