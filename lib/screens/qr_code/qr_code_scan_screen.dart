import 'dart:developer';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../app_assets/app_icons.dart';
import '../../app_assets/app_styles.dart';
import 'qr_code_info_screen.dart';

class QRCodeScanScreen extends StatefulWidget {
  const QRCodeScanScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScanScreen> createState() => _QRCodeScanScreenState();
}

class _QRCodeScanScreenState extends State<QRCodeScanScreen> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

/// In order to get hot reload to work we need to pause the camera if the platform is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'qr_code_scan'.tr(),
          style: AppStyles.titleAppBarWhite.copyWith(height: 1)
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: SvgPicture.asset(AppIcons.iconBack),
        )
      ),
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
/// Turn on flash section and select QR photo section start
          Positioned(
            left: 32,
            bottom: 16,
            child: SafeArea(
              child: Container(
                width: size.width - 64,
                height: 67,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: InkWell(
                          onTap: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(AppIcons.iconLightBulb),
                              const SizedBox(height: 6),
                              Text(
                                'turn_on_flash'.tr(),
                                style: AppStyles.textFeatures.copyWith(fontSize: 13)
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         children: [
                           SvgPicture.asset(AppIcons.iconImage),
                           const SizedBox(height: 6),
                           Text(
                             'select_qr_photo'.tr(),
                             style: AppStyles.textFeatures.copyWith(fontSize: 13)
                           )
                         ],
                       ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
/// Turn on flash section and select QR photo section end
/// Text(Move camera) section start
          Positioned(
            top: size.height / 5,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'move_camera'.tr(),
                textAlign: TextAlign.center,
                style: AppStyles.textButtonWhite
              ),
            ),
          ),
/// Text(Move camera) section end
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = MediaQuery.of(context).size.width - 160;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.white,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {  // Listen to scanned data stream
      await controller.pauseCamera();    // After scanning is complete, pause the camera.
      goToQRCodeInfoScreen(scanData);    // Navigate to QRCodeInfoScreen with the scanned data
    });
  }

  void goToQRCodeInfoScreen(Barcode result) {
    // Navigate to the QRCodeInfoScreen and replace the current QRCodeScanScreen.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => QRCodeInfoScreen(result: result)));
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');    // Log permission set status with timestamp
    if (!p) {    // Show a SnackBar if permission is not granted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();    // Dispose of the controller to release resources
    super.dispose();
  }
}