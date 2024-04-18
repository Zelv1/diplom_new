class DoneOrdersAgregator {
  late List<bool> _doneOrders;
  late int _ordersLeft;

  DoneOrdersAgregator()
      : _doneOrders = [],
        _ordersLeft = 0;

  DoneOrdersAgregator.initialCount(int initialCount)
      : _ordersLeft = initialCount {
    _doneOrders = List<bool>.filled(initialCount, false);
  }

  void setDone(int id) {
    if (!_doneOrders[id]) {
      _doneOrders[id] = true;
      _ordersLeft--;
    } else {
      throw Exception();
    }
  }

  bool isDone(int id) {
    return _doneOrders[id];
  }

  bool areAllDone() {
    return _ordersLeft <= 0;
  }

  void dispose() {}
}
