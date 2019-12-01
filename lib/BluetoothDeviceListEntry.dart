import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class BluetoothDeviceListEntry extends ListTile {
  BluetoothDeviceListEntry(
      {@required BluetoothDevice device,
      int rssi,
      GestureTapCallback onTap,
      GestureLongPressCallback onLongPress,
      bool enabled = true})
      : super(
          onTap: onTap,
          onLongPress: onLongPress,
          enabled: enabled,
          leading:
              Icon(Icons.devices), // @TODO . !BluetoothClass! class aware icon
          title: Text(
            device.name ?? "Unknown device",
            style: TextStyle(
                fontFamily: 'Publica Sans',
                fontWeight: FontWeight.w400,
                fontSize: 13),
          ),
          // subtitle: Text(device.address.toString()),
          trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
            rssi != null
                ? Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "HCANAKAROLINA",
                        style: TextStyle(
                            fontFamily: 'Publica Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 12),
                      ),
                    ),
                  )
                // ? Container(
                //     margin: new EdgeInsets.all(8.0),
                //     child: DefaultTextStyle(
                //         style: () {}(),
                //         child: Column(
                //             mainAxisSize: MainAxisSize.min,
                //             children: <Widget>[
                //               Text(rssi.toString()),
                //               Text('dBm'),
                //             ])),
                //   )
                : Container(width: 0, height: 0),
            device.isConnected
                ? Icon(Icons.import_export)
                : Container(width: 0, height: 0),
            device.isBonded ? Icon(Icons.link) : Container(width: 0, height: 0),
          ]),
        );
}
