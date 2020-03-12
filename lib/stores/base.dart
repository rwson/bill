import 'package:mobx/mobx.dart';

part 'base.g.dart';

class BaseStore = _BaseStore with _$BaseStore;

abstract class _BaseStore with Store {
  @observable
  bool loading = false;

  @action
  bool switchLoading(bool isLoading) {
    // if (isLoading) {
    //   LoadingFlipping.circle();
    // }
    if (isLoading != loading) {
      loading = isLoading;
    }
    return loading;
  }
}
