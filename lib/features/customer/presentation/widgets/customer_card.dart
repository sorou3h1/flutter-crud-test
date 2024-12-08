import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/resoruces/functions/functions.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/cubit/customer_cubit.dart';
import 'package:mc_crud_test/features/customer/presentation/pages/add_customer.dart';

class CustomerCard extends StatelessWidget {
  final Customer customer;
  const CustomerCard({Key? key, required this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                customer.firstname + " " + customer.lastname,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  var result = await BlocProvider.of<CustomerCubit>(context)
                      .deleteCustomer(customer.email);

                  bool isSucc = result.fold(
                      (excpetion) => false, (result) => result ?? false);

                  showResultBanner(
                      isSucc,
                      context,
                      "Succussfully deleted the customer",
                      "Failed to delete the customer",
                      false);
                },
                icon: const Icon(Icons.delete_outline),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AddCustomer(customer: customer),
                    ),
                  );
                },
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          const SizedBox(height: 10),
          keyValue(context, "Date of birth", customer.dateOfBirth.toString().substring(0, 10)),
          keyValue(context, "Bank account number",
              customer.bankAccountNumber.toString()),
          keyValue(context, "Phone number", "0"+customer.phoneNumber.toString()),
          keyValue(context, "E-mail", customer.email),
          const Divider(thickness: 3),
        ],
      ),
    );
  }

  SizedBox keyValue(BuildContext context, String key, String value) {
    return SizedBox(
      height: 60,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 2.5),
          Text(
            value,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
