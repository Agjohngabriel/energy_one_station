import 'package:get/get.dart';

import '../model/body/status_body.dart';
import '../model/response/order_detail.dart';
import '../model/response/order_model.dart';
import '../model/response/running_orders.dart';
import '../repo/order_repo.dart';
import '../services/api.dart';
import '../widget/snackbar.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo = Get.put(OrderRepo());
  // OrderController({required this.orderRepo});

  List<OrderModel>? _allOrderList;
  List<OrderModel>? _orderList;
  List<OrderModel>? _runningOrderList;
  List<RunningOrderModel>? _runningOrders;
  List<OrderModel>? _historyOrderList;
  List<OrderDetailsModel>? _orderDetailsModel;
  bool _isLoading = false;
  int _orderIndex = 0;
  String _otp = '';
  int _historyIndex = 0;
  final List<String> _statusList = ['all', 'delivered', 'refunded'];

  List<OrderModel>? get orderList => _orderList;
  List<OrderModel>? get runningOrderList => _runningOrderList;
  List<RunningOrderModel>? get runningOrders => _runningOrders;
  List<OrderModel>? get historyOrderList => _historyOrderList;
  List<OrderDetailsModel>? get orderDetailsModel => _orderDetailsModel;
  bool get isLoading => _isLoading;
  int get orderIndex => _orderIndex;
  String get otp => _otp;
  int get historyIndex => _historyIndex;
  List<String> get statusList => _statusList;

  Future<void> getAllOrders() async {
    _historyIndex = 0;
    Response response = await orderRepo.getAllOrders();
    if (response.statusCode == 200) {
      _allOrderList = [];
      _orderList = [];
      response.body.forEach((order) {
        OrderModel _orderModel = OrderModel.fromJson(order);
        _allOrderList?.add(_orderModel);
        _orderList?.add(_orderModel);
      });
    } else {
      Api.checkApi(response);
    }
    update();
  }

  Future<void> getCurrentOrders() async {
    Response response = await orderRepo.getCurrentOrders();
    if (response.statusCode == 200) {
      _runningOrderList = [];
      _runningOrders = [
        RunningOrderModel(status: 'Pending', orderList: []),
        RunningOrderModel(status: 'Accepted', orderList: []),
        RunningOrderModel(status: 'Confirmed', orderList: []),
        // RunningOrderModel(status: 'Delivered', orderList: []),
      ];
      response.body.forEach((order) {
        OrderModel _orderModel = OrderModel.fromJson(order);
        _runningOrderList?.add(_orderModel);
        if (_orderModel.orderStatus == 'pending') {
          _runningOrders![0].orderList.add(_orderModel);
        } else if (_orderModel.orderStatus == 'accepted') {
          _runningOrders![1].orderList.add(_orderModel);
        } else if (_orderModel.orderStatus == 'confirmed') {
          _runningOrders![2].orderList.add(_orderModel);
        }
        // else if (_orderModel.orderStatus == 'handover') {
        //   _runningOrders![3].orderList.add(_orderModel);
        // } else if (_orderModel.orderStatus == 'picked_up') {
        //   _runningOrders![4].orderList.add(_orderModel);
        // }
      });
    } else {
      Api.checkApi(response);
    }
    update();
  }

  Future<void> getCompletedOrders() async {
    Response response = await orderRepo.getCompletedOrders();
    if (response.statusCode == 200) {
      _historyOrderList = [];
      response.body.forEach((order) {
        OrderModel _orderModel = OrderModel.fromJson(order);
        _historyOrderList?.add(_orderModel);
      });
    } else {
      Api.checkApi(response);
    }
    setHistoryIndex(0);
  }

  Future<bool> updateOrderStatus(int orderID, String status,
      {bool back = false}) async {
    _isLoading = true;
    update();
    UpdateStatusBody _updateStatusBody = UpdateStatusBody(
      orderId: orderID,
      status: status,
      // otp: status == 'delivered' ? _otp : null,
    );
    Response response = await orderRepo.updateOrderStatus(_updateStatusBody);
    Get.back();
    bool _isSuccess;
    if (response.statusCode == 200) {
      if (back) {
        Get.back();
      }
      getCurrentOrders();
      showCustomSnackBar(response.body['message'], isError: false);
      _isSuccess = true;
    } else {
      Api.checkApi(response);
      _isSuccess = false;
    }
    _isLoading = false;
    update();
    return _isSuccess;
  }

  Future<void> getOrderDetails(int orderID) async {
    _orderDetailsModel;
    Response response = await orderRepo.getOrderDetails(orderID);
    if (response.statusCode == 200) {
      _orderDetailsModel = [];
      response.body.forEach((orderDetails) =>
          _orderDetailsModel?.add(OrderDetailsModel.fromJson(orderDetails)));
    } else {
      Api.checkApi(response);
    }
    update();
  }

  void setOrderIndex(int index) {
    _orderIndex = index;
    update();
  }

  void setOtp(String otp) {
    _otp = otp;
    if (otp != '') {
      update();
    }
  }

  void setHistoryIndex(int index) {
    _historyIndex = index;
    _orderList = [];
    if (index == 0) {
      _orderList?.addAll(_historyOrderList!);
    } else {
      _orderList?.addAll(_historyOrderList!
          .where((order) => order.orderStatus == _statusList[index]));
    }
    update();
  }

  int countHistoryList(int index) {
    int _length;
    if (index == 0) {
      _length = _historyOrderList!.length;
    } else {
      _length = _historyOrderList!
          .where((order) => order.orderStatus == _statusList[index])
          .length;
    }
    return _length;
  }
}
