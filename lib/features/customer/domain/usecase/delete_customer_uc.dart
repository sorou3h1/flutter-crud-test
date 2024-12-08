import 'package:mc_crud_test/core/usecase/usecase.dart';
import 'package:mc_crud_test/features/customer/domain/repository/customer_repo.dart';
import 'package:either_dart/either.dart';

class DeleteCustomerUC implements UseCase<Either<Exception,bool?>, String> {
  final CustomerRepo repository;

  DeleteCustomerUC(this.repository);

  @override
  Future<Either<Exception,bool?>> call(String email) async {
    return await repository.deleteCustomer(email);
  }
}
