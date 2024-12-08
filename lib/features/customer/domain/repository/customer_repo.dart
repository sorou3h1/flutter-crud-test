import 'package:either_dart/either.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';

abstract class CustomerRepo{
  Future<Either<Exception,List<Customer>?>>  getCustomers();
  Future<Either<Exception,bool?>>  registerCustomer(Customer customer);
  Future<Either<Exception,bool?>>  deleteCustomer(String email);
  Future<Either<Exception,bool?>> checkUniqeness(Customer customer);
}