import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:equatable/equatable.dart';
import 'package:mc_crud_test/core/exceptions/unique_exception.dart';
import 'package:mc_crud_test/core/usecase/usecase.dart';
import 'package:mc_crud_test/features/customer/data/datasources/hive_storage.dart';
import 'package:mc_crud_test/features/customer/data/repository/customer_repo_impl.dart';
import 'package:mc_crud_test/features/customer/domain/entities/customer.dart';
import 'package:mc_crud_test/features/customer/domain/usecase/check_uniqueness_uc.dart';
import 'package:mc_crud_test/features/customer/domain/usecase/create_customer_uc.dart';
import 'package:mc_crud_test/features/customer/domain/usecase/delete_customer_uc.dart';
import 'package:mc_crud_test/features/customer/domain/usecase/read_customer_uc.dart';
import 'package:mc_crud_test/features/customer/presentation/bloc/status.dart';

part 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerState> {
  final HiveStorage hiveStorage;
  CustomerCubit({required this.hiveStorage})
      : super(
          CustomerState(
            deleteStatus: InitialStatus(value: null),
            readStatus: InitialStatus(value: null),
            registerStatus: InitialStatus(value: null),
            updateStatus: InitialStatus(value: null),
          ),
        );

  bool validatePhoneNumber(String phoneNumber) {
    if (!phoneNumber.startsWith("09") || phoneNumber.length != 11) {
      return false;
    }
    return true;
  }

  bool validateEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  bool validateDob(String dob) {
    final dobRegex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    bool result = dobRegex.hasMatch(dob);
    if (result) {
      int year = int.parse(dob.substring(0, 4));
      int month = int.parse(dob.substring(5, 7));
      int day = int.parse(dob.substring(8, 10));

      if (year < 1800 || year > DateTime.now().year) {
        return false;
      }
      if (month > 12 || month < 1) {
        return false;
      }
      if (day < 1 || day > 30) {
        return false;
      }
    }
    return result;
  }

  bool validateBankNumber(String bankNumber) {
    if (bankNumber.length != 16) {
      return false;
    }

    int sum = 0;
    for (int i = 0; i < 16; i++) {
      int digit = int.parse(bankNumber[i]);
      if (i % 2 == 0) {
        digit *= 2;
        if (digit > 9) {
          digit -= 9;
        }
      }
      sum += digit;
    }

    return sum % 10 == 0;
  }

  Future<Either<Exception, bool?>> registerCustomer(Customer customer) async {
    emit(
      CustomerState(
        registerStatus: InProgress(),
        deleteStatus: state.deleteStatus,
        updateStatus: state.updateStatus,
        readStatus: state.readStatus,
      ),
    );


    //name , last name , email and date of birth must be unique

    var uniqueResult = await CheckUniqenessUC(
      CustomerRepoImpl(hiveStorage: hiveStorage),
    ).call(customer);

    if (uniqueResult.isLeft) {
      return Left(uniqueResult.left);
    } else {
      if (uniqueResult.right == false) {
        return Left(UniqueException("name , last name , email and date of birth must be unique"));
      }
    }

    
    var result = await CreateCustomerUC(
      CustomerRepoImpl(
        hiveStorage: hiveStorage,
      ),
    ).call(customer);

    result.fold((left) {
      emit(
        CustomerState(
          registerStatus: Failed(message: left.toString()),
          deleteStatus: state.deleteStatus,
          updateStatus: state.updateStatus,
          readStatus: state.readStatus,
        ),
      );
    }, (right) {
      emit(
        CustomerState(
          registerStatus: Done(value: true),
          deleteStatus: state.deleteStatus,
          updateStatus: state.updateStatus,
          readStatus: state.readStatus,
        ),
      );
    });

    return result;
  }

  void readCustomers() async {
    emit(
      CustomerState(
        registerStatus: state.registerStatus,
        deleteStatus: state.deleteStatus,
        updateStatus: state.updateStatus,
        readStatus: InProgress(),
      ),
    );

    var result = await ReadCustomersUC(
      CustomerRepoImpl(hiveStorage: hiveStorage),
    ).call(NoParams());

    result.fold((left) {
      emit(
        CustomerState(
          registerStatus: state.registerStatus,
          deleteStatus: state.deleteStatus,
          updateStatus: state.updateStatus,
          readStatus: Failed(message: left.toString()),
        ),
      );
    }, (customers) {
      emit(
        CustomerState(
          registerStatus: state.registerStatus,
          deleteStatus: state.deleteStatus,
          updateStatus: state.updateStatus,
          readStatus: Done(value: customers),
        ),
      );
    });
  }

  Future<Either<Exception, bool?>> deleteCustomer(String email) async {
    emit(
      CustomerState(
        registerStatus: state.registerStatus,
        deleteStatus: InProgress(),
        updateStatus: state.updateStatus,
        readStatus: state.readStatus,
      ),
    );

    var result = await DeleteCustomerUC(
      CustomerRepoImpl(hiveStorage: hiveStorage),
    ).call(email);

    result.fold((left) {
      emit(
        CustomerState(
          registerStatus: state.registerStatus,
          deleteStatus: state.deleteStatus,
          updateStatus: state.updateStatus,
          readStatus: Failed(message: left.toString()),
        ),
      );
    }, (customers) {
      emit(
        CustomerState(
          registerStatus: state.registerStatus,
          deleteStatus: Done(value: true),
          updateStatus: state.updateStatus,
          readStatus: state.readStatus,
        ),
      );
    });

    return result;
  }

  Future<Either<Exception, bool?>> updateCustomer(
      String email, Customer customer) async {
    await deleteCustomer(email);
    return await registerCustomer(customer);
  }
}
