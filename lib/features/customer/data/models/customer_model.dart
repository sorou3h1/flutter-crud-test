import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';

class CustomerModel extends Customer {
  const CustomerModel(
      {
      required String firstname,
      required String lastname,
      required DateTime dateOfBirth,
      required int phoneNumber,
      required String email,
      required int bankAccountNumber})
      : super(
          firstname: firstname,
          lastname: lastname,
          dateOfBirth: dateOfBirth,
          phoneNumber: phoneNumber,
          email: email,
          bankAccountNumber: bankAccountNumber,
        );

  
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstname': firstname,
      'lastname': lastname,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'phoneNumber': phoneNumber,
      'email': email,
      'bankAccountNumber': bankAccountNumber,
    };
  }

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
      firstname: map['firstname'] as String,
      lastname: map['lastname'] as String,
      dateOfBirth: DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      phoneNumber: map['phoneNumber'] as int,
      email: map['email'] as String,
      bankAccountNumber: map['bankAccountNumber'] as int,
    );
  }


}
