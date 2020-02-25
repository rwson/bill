// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BillStore on _BillStore, Store {
  final _$limitAtom = Atom(name: '_BillStore.limit');

  @override
  int get limit {
    _$limitAtom.context.enforceReadPolicy(_$limitAtom);
    _$limitAtom.reportObserved();
    return super.limit;
  }

  @override
  set limit(int value) {
    _$limitAtom.context.conditionallyRunInAction(() {
      super.limit = value;
      _$limitAtom.reportChanged();
    }, _$limitAtom, name: '${_$limitAtom.name}_set');
  }

  final _$createPaymentBillAsyncAction = AsyncAction('createPaymentBill');

  @override
  Future<bool> createPaymentBill(Map<String, dynamic> bill) {
    return _$createPaymentBillAsyncAction
        .run(() => super.createPaymentBill(bill));
  }

  final _$createIncomeBillAsyncAction = AsyncAction('createIncomeBill');

  @override
  Future<bool> createIncomeBill(Map<String, dynamic> bill) {
    return _$createIncomeBillAsyncAction
        .run(() => super.createIncomeBill(bill));
  }
}
