import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:testapp/api/dio_client.dart';
import 'package:testapp/api/potvrda_dolaska_service.dart';
import 'package:testapp/models/other/argumenti_individualne_potvrde_dolaska.dart';
import 'package:testapp/models/requests/potvrda_dolaska_request.dart';

class IndividualnaPotvrdaDolaska extends StatefulWidget {
  ArgumentiIndividualnePotvrdeDolaska argInfo;

  IndividualnaPotvrdaDolaska({Key? key, required this.argInfo})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _IndividualnaPotvrdaDolaskaState();
}

class _IndividualnaPotvrdaDolaskaState
    extends State<IndividualnaPotvrdaDolaska> {
  PotvrdaDolaskaService potvrdaDolaskaService = PotvrdaDolaskaService();
  Barcode? result;
  PotvrdaDolaskaRequest qrKod = PotvrdaDolaskaRequest(kod: '');
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool blic = false;
  DioClient dioCL = DioClient();
  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFD6F4F4),
        body: Column(
          children: <Widget>[
            Expanded(flex: 7, child: _buildQrView(context)),
            Expanded(
              flex: 1,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('Skeniraj QR kod mjesta',
                        style: TextStyle(fontSize: 18)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.toggleFlash();
                                setState(() {
                                  blic == true ? blic = false : blic = true;
                                });
                              },
                              child: FutureBuilder(
                                future: controller?.getFlashStatus(),
                                builder: (context, snapshot) {
                                  if (blic == true) {
                                    return const Icon(Icons.flash_on,
                                        color: Colors.yellow, size: 18);
                                  }
                                  return const Icon(Icons.flash_off,
                                      color: Colors.white, size: 18);
                                },
                              )),
                        ),
                        Container(
                          height: 60,
                          width: 60,
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              if (result?.code != null) {
                                print(result?.code);
                                potvrdiDolazak(widget.argInfo.idMjesta,
                                    widget.argInfo.idRezervacije);
                              } else {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text(
                                              'Neuspjesno skeniranje'),
                                          content: const Text(
                                              'Molimo vas da skenirate QR kod ponovo !\n'
                                              'Obratite pažnju da se kod mora nalaziti u sredini crvenog kvadrata !\n'
                                              'Ukoliko ne uspijete skenirati nakon više pokušaja molimo vas da nam ovo to prijavite !\n'
                                              '(Profil > O aplikaciji > Prijavi grešku)'),
                                          actions: <Widget>[
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text('OK'),
                                            ),
                                          ],
                                        ));
                              }
                            },
                            child: const Center(
                                child: Icon(
                              Icons.camera_alt,
                              size: 40,
                            )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                              onPressed: () async {
                                await controller?.flipCamera();
                                setState(() {});
                              },
                              child: FutureBuilder(
                                future: controller?.getCameraInfo(),
                                builder: (context, snapshot) {
                                  if (snapshot.data != null) {
                                    return const Icon(Icons.sync);
                                  } else {
                                    return const Text('loading');
                                  }
                                },
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void potvrdiDolazak(int mjestoId, rezervacijaId) async {
    var response = await potvrdaDolaskaService.potvrdiDolazakIndRez(
        dioClient: dioCL,
        qrKodInfo: PotvrdaDolaskaRequest(kod: result!.code!),
        idMjesta: mjestoId,
        idRezervacije: rezervacijaId);
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Potvrda dolaska'),
          content: const Text('Uspješno ste potvrdili dolazak !',
              style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else if (response?.statusCode == 400 || response?.statusCode == 409) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content: const Text(
              'Skenirali ste netačan QR kod, provjerite da li skenirate na ispravnom mjestu !',
              style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    } else {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Greška'),
          content:
              const Text('Greška na serveru !', style: TextStyle(fontSize: 20)),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 390 ||
            MediaQuery.of(context).size.height < 400)
        ? 200.0
        : 250.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
