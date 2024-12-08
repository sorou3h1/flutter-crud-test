import 'package:either_dart/either.dart';
import 'package:mc_crud_test/core/usecase/usecase.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/domain/repository/customer_repo.dart';

class ReadCustomersUC implements UseCase<Either<Exception,List<Customer>?>, NoParams> {
  final CustomerRepo repository;

  ReadCustomersUC(this.repository);

  @override
  Future<Either<Exception,List<Customer>?>> call(NoParams noParams) async {
    return await repository.getCustomers();
  }
}
