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
    deleteButtonText: 'Delete',
    doneButtonText: 'Done',
    titleStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
    buttonTextStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
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
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
```