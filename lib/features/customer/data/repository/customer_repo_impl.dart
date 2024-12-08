import 'package:either_dart/either.dart';
import 'package:mc_crud_test/features/customer/data/datasources/hive_storage.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/domain/repository/customer_repo.dart';

class CustomerRepoImpl extends CustomerRepo{

  final HiveStorage hiveStorage;

  CustomerRepoImpl({required this.hiveStorage});

  @override
  Future<Either<Exception,bool?>> deleteCustomer(String email) {
    return hiveStorage.deleteCustomer(email);
  }

  @override
  Future<Either<Exception,List<Customer>?>> getCustomers() {
    return hiveStorage.readCustomers();
  }

  @override
  Future<Either<Exception,bool?>> registerCustomer(Customer customer) {
    return hiveStorage.registerCustomer(customer);
  }

  @override
  Future<Either<Exception,bool?>> checkUniqeness(Customer customer) {
    return hiveStorage.checkUniqeness(customer);
  }

}