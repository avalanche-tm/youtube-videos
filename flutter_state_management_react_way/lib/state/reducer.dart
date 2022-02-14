import 'package:flutter_state_management_react_way/api.dart';

import 'action.dart';
import 'state.dart';

Future<State> reducer(State state, Object action) async {
  if (action is GetShoppingItemsAction) {
    var api = Api();
    var items = await api.getItems();
    var newState = state.copyWith(items: items);
    return newState;
  }
  return state;
}
