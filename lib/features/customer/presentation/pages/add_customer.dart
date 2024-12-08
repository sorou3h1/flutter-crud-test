import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mc_crud_test/core/exceptions/unique_exception.dart';
import 'package:mc_crud_test/core/resoruces/const/dimensions.dart';
import 'package:mc_crud_test/core/resoruces/functions/functions.dart';
import 'package:mc_crud_test/core/resoruces/styles/button_style.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/cubit/customer_cubit.dart';

const String kBankNumber = "Bank number";
const String kDob = "Date of Birth";
const String kEmail = "E-mail";
const String kPhoneNumber = "Phone number";

class AddCustomer extends StatefulWidget {
  final Customer? customer;
  const AddCustomer({Key? key, this.customer}) : super(key: key);

  @override
  State<AddCustomer> createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  TextEditingController dobController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController eMailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController bankNumberController = TextEditingController();

  String? dobErrorText;
  String? phoneNumberErrorText;
  String? eMailErrorText;
  String? bankNumberErrorText;

  bool creationEnabled = false;

  List<TextEditingController> controllers = [];

  @override
  void initState() {
    if (widget.customer != null) {
      //set initial values
      dobController.value = TextEditingValue(
        text: widget.customer!.dateOfBirth.toString().substring(0, 10),
      );
      fNameController.value = TextEditingValue(
        text: widget.customer!.firstname,
      );
      lNameController.value = TextEditingValue(
        text: widget.customer!.lastname,
      );
      eMailController.value = TextEditingValue(
        text: widget.customer!.email,
      );
      phoneNumberController.value = TextEditingValue(
        text: "0" + widget.customer!.phoneNumber.toString(),
      );
      bankNumberController.value = TextEditingValue(
        text: widget.customer!.bankAccountNumber.toString(),
      );
    }

    controllers.addAll([
      dobController,
      fNameController,
      lNameController,
      eMailController,
      phoneNumberController,
      bankNumberController,
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(width: 5),
                Text(
                  "Back",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.black.withOpacity(0.7),
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 20,
                ),
                width: size.width > 1000 ? 500 : double.infinity,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        "Create Customer",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 10),
                      keyValueTextField(
                        context,
                        size,
                        "First name",
                        "soroush",
                        fNameController,
                        Icons.abc,
                        null,
                      ),
                      keyValueTextField(
                        context,
                        size,
                        "Last name",
                        "panahi",
                        lNameController,
                        Icons.abc,
                        null,
                      ),
                      keyValueTextField(
                        context,
                        size,
                        kPhoneNumber,
                        "09221352364",
                        phoneNumberController,
                        Icons.phone,
                        phoneNumberErrorText,
                        digitOnly: true,
                      ),
                      keyValueTextField(
                        context,
                        size,
                        kEmail,
                        "soroushpanahi1@gmail.com",
                        eMailController,
                        Icons.email,
                        eMailErrorText,
                      ),
                      keyValueTextField(
                        context,
                        size,
                        kDob,
                        "2003-03-15",
                        dobController,
                        Icons.date_range,
                        dobErrorText,
                      ),
                      keyValueTextField(
                        context,
                        size,
                        kBankNumber,
                        "6221000000000000",
                        bankNumberController,
                        Icons.money,
                        bankNumberErrorText,
                        digitOnly: true,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed:
                            creationEnabled ? () => createtOnTap() : null,
                        child: Text(
                          "Create",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary),
                        ),
                        style: primaryElevatedButtonStyle(
                            context, Size(size.width * 0.8, 45)),
                      ),
                      const SizedBox(height: 5),
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          "Discard",
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  SizedBox keyValueTextField(
      BuildContext context,
      Size size,
      String key,
      String hint,
      TextEditingController controller,
      IconData iconData,
      String? errorText,
      {bool digitOnly = false}) {
    var customerCubit = BlocProvider.of<CustomerCubit>(context);

    return SizedBox(
      height: 80 + (errorText != null ? 20 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            key,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.6),
                ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: size.width * 0.8,
            height: 45 + (errorText != null ? 20 : 0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                ),
                hintText: hint,
                prefixIcon: Icon(iconData),
                errorText: errorText,
              ),
              controller: controller,
              onSubmitted: (_) => validate(customerCubit, key),
              onTapOutside: (_) => validate(customerCubit, key),
              onChanged: key == kBankNumber ? (_) => validate(customerCubit, key) : null,
              keyboardType: digitOnly ? TextInputType.number : null,
              inputFormatters: digitOnly
                  ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly]
                  : null,
            ),
          ),
          const SizedBox(height: 2.5),
        ],
      ),
    );
  }

  validate(CustomerCubit customerCubit, String key) {
    checkDataValidation(customerCubit, key);
    changeGenButtonState();
  }

  bool checkDataValidation(CustomerCubit customerCubit, String key) {
    bool isValid = false;
    String errorText = "please enter a valid " + key;

    if (key == kPhoneNumber) {
      isValid = customerCubit.validatePhoneNumber(phoneNumberController.text);
      setState(() {
        if (isValid) {
          phoneNumberErrorText = null;
        } else {
          phoneNumberErrorText = errorText;
        }
      });
    } else if (key == kEmail) {
      isValid = customerCubit.validateEmail(eMailController.text);
      setState(() {
        if (isValid) {
          eMailErrorText = null;
        } else {
          eMailErrorText = errorText;
        }
      });
    } else if (key == kDob) {
      isValid = customerCubit.validateDob(dobController.text);
      setState(() {
        if (isValid) {
          dobErrorText = null;
        } else {
          dobErrorText = errorText;
        }
      });
    } else if (key == kBankNumber) {
      isValid = customerCubit.validateBankNumber(bankNumberController.text);
      setState(() {
        if (isValid) {
          bankNumberErrorText = null;
        } else {
          bankNumberErrorText = errorText;
        }
      });
    }
    return isValid;
  }

  changeGenButtonState() {
    bool c1 = controllers.every((element) => element.value.text.isNotEmpty);
    bool c2 = (phoneNumberErrorText == null) &&
        (dobErrorText == null) &&
        (eMailErrorText == null) &&
        (bankNumberErrorText == null);

    if ((c1 && c2) != creationEnabled) {
      setState(() {
        creationEnabled = (c1 && c2);
      });
    }
  }

  bool finalValidation(CustomerCubit customerCubit) {
    return checkDataValidation(customerCubit, kPhoneNumber) &&
        checkDataValidation(customerCubit, kEmail) &&
        checkDataValidation(customerCubit, kDob) &&
        checkDataValidation(customerCubit, kBankNumber);
  }

  void createtOnTap() async {
    var customerCubit = BlocProvider.of<CustomerCubit>(context);
    if (!finalValidation(customerCubit)) {
      changeGenButtonState();
      return;
    }

    var customer = Customer(
      firstname: fNameController.text,
      lastname: lNameController.text,
      dateOfBirth: DateTime.parse(dobController.text),
      phoneNumber: int.parse(phoneNumberController.text),
      email: eMailController.text,
      bankAccountNumber: int.parse(bankNumberController.text),
    );

    Either<Exception, bool?> result = widget.customer == null
        ? await customerCubit.registerCustomer(customer)
        : await customerCubit.updateCustomer(
            widget.customer!.email,
            customer,
          );

    if (result.isLeft) {
      showResultBanner(
        false,
        context,
        "_",
        result.left is UniqueException
            ? result.left.toString()
            : "Failed to registered the customer",
        true,
      );

      return;
    }

    showResultBanner(
      result.right ?? false,
      context,
      "Succussfully registered the customer",
      "Failed to registered the customer",
      true,
    );
  }
}
