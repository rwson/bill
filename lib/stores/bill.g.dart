// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BillStore on _BillStore, Store {
  final _$createBillAsyncAction = AsyncAction('createBill');

  @override
  Future<bool> createBill(Map<String, dynamic> bill) {
    return _$createBillAsyncAction.run(() => super.createBill(bill));
  }

  final _$getMonthBillsAsyncAction = AsyncAction('getMonthBills');

  @override
  Future<void> getMonthBills([String month]) {
    return _$getMonthBillsAsyncAction.run(() => super.getMonthBills(month));
  }
}
