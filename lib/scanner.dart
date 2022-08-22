import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class Scanner extends StatefulWidget {
  const Scanner({Key? key}) : super(key: key);

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {

  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? barcode;



  @override
  void dispose() {
    // TODO: implement dispose
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async{
    // TODO: implement reassemble
    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("QR  Code Scanner",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children:<Widget> [
            buildQRView(context),
            Positioned(
              bottom: 10,
              child: buildResult(),
            ),
            Positioned(
              top: 10,
              child: controlButton(),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildQRView(BuildContext context){
    return QRView(
      key: qrKey,
      onQRViewCreated: QRCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 10,
        cutOutSize: MediaQuery.of(context).size.width*0.8,
      ),
    );
  }
  void QRCreated(QRViewController controller){

    setState(()=>this.controller=controller);

    controller.scannedDataStream.listen((barcode) {
      setState((){
        this.barcode=barcode;
      });
    });
  }

  Widget buildResult() {
    return Container(
      padding:const  EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        barcode !=null?"Result: ${barcode!.code}":"scan a code!",
      maxLines: 3,
      ),
    );
  }

  Widget controlButton(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white24
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: ()async{
              await  controller?.toggleFlash();
              setState((){

              });
            },
            icon: FutureBuilder<bool?>(
              future: controller?.getFlashStatus(),
                builder: (context,snapshot){
                if(snapshot.data !=null){
                  return Icon(
                      snapshot.data! ?Icons.flash_on:Icons.flash_off);
                }else{
                  return Container();
                }
                },
            )
              ),
          IconButton(
            onPressed: ()async{
              await controller?.flipCamera();
              setState((){

              });
            },
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context , snapshot){
                if(snapshot.data !=null){
                  return const Icon(Icons.switch_camera);
                }else{
                  return Container();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
