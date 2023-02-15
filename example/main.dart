import 'package:custom_signature/custom_signature.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, title: 'Example', home: FirstPage());
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: ElevatedButton(
          child: const Text('To sign'),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => CustomSignature(
                          context: context,
                          title: 'Signature',
                          closeButtonColor: Colors.indigo,
                          icon: Icons.close,
                          enabledButtonColor: Colors.green,
                          disabledButtonColor:
                              Colors.lightGreen.withOpacity(0.5),
                          penColor: Colors.black,
                          textColor: Colors.black,
                          nextPage: const ShowSignaturePage(),
                          deleteButtonText: 'Delete',
                          doneButtonText: 'Done',
                          closeAlert: AlertDialog(
                            content: const Text('Do you want to exit?'),
                            actions: [
                              ElevatedButton(
                                  child: const Text('Ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }),
                              MaterialButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No')),
                            ],
                          ),
                        )));
          }),
    ));
  }
}

class ShowSignaturePage extends StatefulWidget {
  const ShowSignaturePage({super.key});

  @override
  State<ShowSignaturePage> createState() => _ShowSignaturePageState();
}

class _ShowSignaturePageState extends State<ShowSignaturePage> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    Uint8List data = ModalRoute.of(context)!.settings.arguments as Uint8List;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.memory(data),
      ),
    );
  }
}
