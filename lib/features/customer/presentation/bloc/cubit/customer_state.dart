part of 'customer_cubit.dart';

class CustomerState extends Equatable {
  const CustomerState({
    required this.registerStatus,
    required this.deleteStatus,
    required this.updateStatus,
    required this.readStatus,
  });

  final Status<bool?> registerStatus;
  final Status<bool?> deleteStatus;
  final Status updateStatus;
  final Status<List<Customer>?> readStatus;

  @override
  List<Object> get props => [
        registerStatus,
        deleteStatus,
        updateStatus,
        readStatus,
      ];
}
