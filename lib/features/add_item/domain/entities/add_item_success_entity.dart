class AddItemSuccessEntity {
  final int? statusCode;
  final String? message;
  final bool? success;
  final String? itemId;

  const AddItemSuccessEntity({
    this.statusCode,
    this.message,
    this.success,
    this.itemId,
  });
}
