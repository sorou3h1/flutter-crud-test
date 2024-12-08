import 'package:either_dart/either.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mc_crud_test/core/exceptions/unique_exception.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';

abstract class HiveStorage {
  Future<Either<Exception, List<Customer>?>> readCustomers();
  Future<Either<Exception, bool?>> registerCustomer(Customer customer);
  Future<Either<Exception, bool?>> deleteCustomer(String email);

  Future<Either<Exception, bool?>> checkUniqeness(Customer customer);
}

class HiveStorageImpl extends HiveStorage {
  static HiveStorageImpl? instance;
  Box<Customer>? hiveBox;

  HiveStorageImpl();

  factory HiveStorageImpl.getInstance() {
    instance ??= HiveStorageImpl();

    return instance!;
  }

  Future<void> _openBoxIfNeeded() async {
    String boxName = "customers";
    if (hiveBox == null) {
      if (Hive.isBoxOpen(boxName)) {
        hiveBox = Hive.box(boxName);
      } else {
        hiveBox = await Hive.openBox<Customer>(boxName);
      }
    }
  }

  @override
  Future<Either<Exception, bool?>> deleteCustomer(String email) async {
    try {
      await _openBoxIfNeeded();
      bool result = false;
      var entries = hiveBox!.toMap().entries;
      for (var entry in entries) {
        if (entry.value.email == email) {
          await hiveBox!.delete(entry.key);
          result = true;
          print("2result is $result");
        }
      }
      print("1result is $result");
      return Right(result);
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, List<Customer>?>> readCustomers() async {
    await _openBoxIfNeeded();
    try {
      return Right(hiveBox!.values.toList());
    } catch (e) {
      return Left(e as Exception);
    }
  }

  @override
  Future<Either<Exception, bool?>> registerCustomer(Customer customer) async {
    await _openBoxIfNeeded();
    try {
      int id = hiveBox!.values.length + 1;
      await hiveBox!.put(id, customer);
      print("succ reqgisterd new customer");
      return const Right(true);
    } catch (e) {
      print("failed to save customer $e");
      return const Right(false);
    }
  }

  @override
  Future<Either<Exception, bool?>> checkUniqeness(Customer customer) async {
    await _openBoxIfNeeded();
    for (var element in hiveBox!.toMap().values) {
      if(customer.email == element.email){
        return Left(UniqueException("E-mail is duplicated"));
      }else if(customer.firstname == element.firstname){
        return Left(UniqueException("first name is duplicated"));
      }else if (customer.lastname==element.lastname){
        return Left(UniqueException("last name is duplicated"));
      }else if (customer.dateOfBirth.compareTo(element.dateOfBirth)==0){
        return Left(UniqueException("date of birth is duplicated"));
      }
    }
    return const Right(true);
  }
}
