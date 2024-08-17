import 'package:get/get.dart';
import 'package:task_2_bluetooth_connectivity/ble_controller.dart';

class StateHolderBinder extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(BluetoothController());
  }
}
