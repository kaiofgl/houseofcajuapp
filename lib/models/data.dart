library house_of_caju.globals;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

double heightGlobal;
double widthGlobal;
int selectedIndexGlobal;
int countItensActives;
BuildContext globalBuildContextMainScreen;
BluetoothConnection connectedApp;
bool stateConnectedApp = false;

bool valueStateLedNotification = false;
bool valueStateSmartbagBluetooth = false;
Color secondColorContainerAnimated = Color(0xFF00CCFF);
var results;

