import 'package:equatable/equatable.dart';

import 'package:hive_flutter/adapters.dart';

part 'customer.g.dart';

@HiveType(typeId: 1)
class Customer extends Equatable {

  @HiveField(1)
  final String firstname;

  @HiveField(2)
  final String lastname;

  @HiveField(3)
  final DateTime dateOfBirth;

  @HiveField(4)
  final int phoneNumber;

  @HiveField(5)
  final String email;

  @HiveField(6)
  final int bankAccountNumber;

  const Customer({
    required this.firstname,
    required this.lastname,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.email,
    required this.bankAccountNumber,
  });

  @override
  List<Object?> get props =>
      [firstname, lastname, dateOfBirth, phoneNumber, email, bankAccountNumber];
}
