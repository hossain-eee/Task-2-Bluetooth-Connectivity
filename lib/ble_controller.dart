/* import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  var isScanning = false.obs;
  // final FlutterBluePlus flutterBlue = FlutterBluePlus.instance;

  // Start scanning for devices
  Future<void> startScan() async {
    if (!isScanning.value) {
      isScanning.value = true;
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    }
  }

  // Stop scanning for devices
  void stopScan() {
    FlutterBluePlus.stopScan();
    isScanning.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    
    // Listen to scan results and update the list of devices
    FlutterBluePlus.scanResults.listen((results) {
      devices.value = results.map((result) => result.device).toList();
    });
  }

  // Connect to a specific Bluetooth device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    
    // Discover services after connecting
    List<BluetoothService> services = await device.discoverServices();
    
    // Iterate over services and characteristics
    for (var service in services) {
      List<BluetoothCharacteristic> characteristics = service.characteristics;
      
      for (var characteristic in characteristics) {
        // Read value from characteristic
        List<int> value = await characteristic.read();
        print('Read Value: ${value.toString()}');
        
        // Write data to characteristic
        List<int> dataToSend = [0x01, 0x02, 0x03];
        await characteristic.write(dataToSend);
      }
    }
  }
}
 */
import 'dart:async';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:get/get.dart';

class BluetoothController extends GetxController {
  RxList<BluetoothDevice> devices = <BluetoothDevice>[].obs;
  var isScanning = false.obs;
  final StreamController<List<ScanResult>> _scanResultsController = StreamController.broadcast();

  // Getter for the scan results stream
  Stream<List<ScanResult>> get scanResultsStream => _scanResultsController.stream;

  @override
  void onInit() {
    super.onInit();
    
    // Listen to scan results and add them to the stream
    FlutterBluePlus.scanResults.listen((results) {
      _scanResultsController.add(results);
      devices.value = results.map((result) => result.device).toList();
    });
  }

  // Start scanning for devices
 /*  Future<void> startScan() async {
    if (!isScanning.value) {
      isScanning.value = true;
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    }
  } */
  Future<void> startScan() async {
  if (!isScanning.value) {
    try {
      isScanning.value = true;
      await FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));
    } catch (error) {
      // Handle error, e.g., show a message to the user
      print("Error starting scan: $error");
      isScanning.value = false;
    }
  }
}

  // Stop scanning for devices
  void stopScan() {
    FlutterBluePlus.stopScan();
    isScanning.value = false;
  }

  // Connect to a specific Bluetooth device
  Future<void> connectToDevice(BluetoothDevice device) async {
    await device.connect();
    
    // Discover services after connecting
    List<BluetoothService> services = await device.discoverServices();
    
    // Iterate over services and characteristics
    for (var service in services) {
      List<BluetoothCharacteristic> characteristics = service.characteristics;
      
      for (var characteristic in characteristics) {
        // Read value from characteristic
        List<int> value = await characteristic.read();
        print('Read Value: ${value.toString()}');
        
        // Write data to characteristic
        List<int> dataToSend = [0x01, 0x02, 0x03];
        await characteristic.write(dataToSend);
      }
    }
  }

  @override
  void onClose() {
    _scanResultsController.close();
    super.onClose();
  }
}
