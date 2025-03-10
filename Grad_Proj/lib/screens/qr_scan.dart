// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
class QrScan extends StatefulWidget {
  final Function(String) onInputChanged;
  const QrScan({super.key, required this.onInputChanged});

  @override
  State<QrScan> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  String? code ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates,
          ///ِaccess the actual image detected by the mobile scanner
          returnImage: true
        ),
        ///what is going to be done when read the qr correctly
        onDetect: (capture){
          print('======================================catch======================================');
          final List <Barcode> barcodes = capture.barcodes;
          Uint8List? image = capture.image;
          for(final barcode in barcodes){
            code = barcode.rawValue;
            print('Barcode Found! : $code');
            widget.onInputChanged(code!);
          }

          if(image != null){
            image = null;
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}