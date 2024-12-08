import 'package:mc_crud_test/core/usecase/usecase.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/domain/repository/customer_repo.dart';
import 'package:either_dart/either.dart';

class CreateCustomerUC implements UseCase<Either<Exception,bool?>, Customer> {
  final CustomerRepo repository;

  CreateCustomerUC(this.repository);

  @override
  Future<Either<Exception,bool?>> call(Customer customer) async {
    return await repository.registerCustomer(customer);
  }
}
