
## Custom signature

This package project offers an easy way to get your signature with a custom UI, and rotates automatically into landscape mode for most comfortable space to sign.

## Usage

```dart
CustomSignature(
    context: context
    title: 'Signature',
    closeButtonColor: Colors.indigo,
    icon: FontAwesomeIcons.circleXmark,
    enabledButtonColor: Colors.green,
    disabledButtonColor: Colors.lightGreen.withOpacity(0.5),
    penColor: Colors.black,
    nextPage: const SecondPage(),
    deleteButtonText: 'Delete',
    doneButtonText: 'Done',
    // optional properties
    backgroundColor: Colors.white,
    textColor: Colors.black,
    closeAlert: AlertDialog(
        content:
            const Text('Do you want to exit?'),
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
);
```

## Additional information

Is recommended that the screen to going to navigate has Stateful Widget with preferred orientation configured, to turn back the default orientation (portrait).

```dart
SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
```
# custom_signature
