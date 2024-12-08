import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/resoruces/const/dimensions.dart';
import 'package:mc_crud_test/core/resoruces/styles/button_style.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/cubit/customer_cubit.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/status.dart';
import 'package:mc_crud_test/features/customer/presentation/pages/add_customer.dart';
import 'package:mc_crud_test/features/customer/presentation/widgets/customer_card.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    BlocProvider.of<CustomerCubit>(context).readCustomers();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    size: 30,
                  ),
                  FlutterLogo(
                    size: 30,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                "Customers",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 165,
                width: size.width>1000 ? 500 : double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                child: Column(
                  children: [
                    ElevatedButton.icon(
                      label: Text(
                        "Create Customer",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ),
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const AddCustomer(),
                          ),
                        );
                      },
                      style: primaryElevatedButtonStyle(
                          context, Size(size.width * 0.8, 45)),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: size.width * 0.8,
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(defaultRadius)),
                          label: const Text("Search"),
                          suffixIcon: const Icon(Icons.search),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(defaultRadius),
                  ),
                  child: BlocBuilder<CustomerCubit, CustomerState>(
                    builder: (context, state) {
                      var readState = state.readStatus;
                      if (readState is InitialStatus ||
                          readState is InProgress) {
                        return const Center(
                          child: SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (readState is Failed) {
                        return const Text("FAILED");
                      } else if (readState is Done) {
                        List<Customer> customers =
                            (readState as Done<List<Customer>?>).value ?? [];

                        if (customers.isEmpty) {
                          return const Center(child: Text("There are no customers in database"));
                        }

                        return GridView.builder(
                          itemCount: customers.length,
                          gridDelegate:
                               SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: size.width > 700 ? 2 : 1,
                            mainAxisExtent: 325,
                          ),
                          itemBuilder: (context, index) {
                            return CustomerCard(customer: customers[index]);
                          },
                        );
                      } else {
                        throw UnimplementedError();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
