// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'limit.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LimitStore on _LimitStore, Store {
  final _$limitAtom = Atom(name: '_LimitStore.limit');

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

  final _$setLimitAsyncAction = AsyncAction('setLimit');

  @override
  Future<HttpResponse<dynamic>> setLimit(int amount) {
    return _$setLimitAsyncAction.run(() => super.setLimit(amount));
  }

  final _$queryLimitAsyncAction = AsyncAction('queryLimit');

  @override
  Future<bool> queryLimit([bool toast = false]) {
    return _$queryLimitAsyncAction.run(() => super.queryLimit(toast));
  }
}
