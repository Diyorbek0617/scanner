import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'functions/about.dart';

class Create_qr extends StatefulWidget {
  const Create_qr({Key? key}) : super(key: key);

  @override
  State<Create_qr> createState() => _Create_qrState();
}

class _Create_qrState extends State<Create_qr> {

  var controller = TextEditingController();
  GlobalKey key=GlobalKey();
  String qrText="";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      appBar: AppBar(
        title: const Text("QR  Code Generator",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              About(context);
            },
            icon: const Icon(Icons.perm_device_info),
          ),
        ],
      ),
      body: SafeArea(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: qrText,
                version: QrVersions.auto,
                backgroundColor: Colors.white,
                size: 200.0,
              ),
              buildText(context),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildText(BuildContext context){
    return Container(
      margin: const EdgeInsets.all(40),
      padding: const EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 1,
          color: Colors.blueAccent,
        ),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: IconButton(
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.done,size: 30,),
            onPressed: ()=>setState((){
              qrText=controller.text;
            }),
          ),
        ),
        onChanged: (value){
          setState((){
            qrText=value;
          });
        },
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
