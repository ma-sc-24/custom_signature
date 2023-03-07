import 'package:custom_signature/custom_signature.dart';
import 'package:flutter/material.dart';

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
          onPressed: () async {
            await Navigator.push(
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
                        ))).then((value) {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'))
                      ],
                      title: const Text('Signature'),
                      content: Image.memory(value),
                    );
                  });
            });
          }),
    ));
  }
}
