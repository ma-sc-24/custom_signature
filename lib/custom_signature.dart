import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:signature/signature.dart';

/// Main class
/// [closeAlert], [backgroundColor] and [textColor] are optional properties. Provides an alert to show when user wants to exit: sets the background color in signature area: and sets the title color, respectively.
class CustomSignature extends StatefulWidget {
  final BuildContext context;
  final String title;
  final Color closeButtonColor;
  final Color enabledButtonColor;
  final Color disabledButtonColor;
  final Color penColor;
  final IconData icon;
  final String deleteButtonText;
  final String doneButtonText;
  final Widget? closeAlert;
  final Color? backgroundColor;
  final Color? textColor;

  /// Constructor
  const CustomSignature({
    super.key,
    required this.context,
    required this.title,
    required this.closeButtonColor,
    required this.enabledButtonColor,
    required this.disabledButtonColor,
    required this.penColor,
    required this.icon,
    required this.deleteButtonText,
    required this.doneButtonText,
    this.closeAlert,
    this.backgroundColor = Colors.transparent,
    this.textColor = Colors.black,
  });

  @override
  State<CustomSignature> createState() => _CustomSignatureState();
}

class _CustomSignatureState extends State<CustomSignature> {
  /// Sets controller.
  late SignatureController _controller;

  /// Set active or inactive the buttons to change their colors.
  bool isButtonActive = false;

  @override
  void initState() {
    super.initState();

    /// Initialize controller
    _controller = SignatureController(
      penStrokeWidth: 2,
      penColor: widget.penColor,
      exportBackgroundColor: Colors.grey[400],
      exportPenColor: Colors.black,
      onDrawStart: () {
        setState(() => isButtonActive = true);
      },
      onDrawEnd: () {},
    );

    _controller.addListener(() {});

    /// Sets screen in landscape mode when that appears.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();

    /// Sets screen in portrait mode when that disappears.
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    context = widget.context;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _bottomActions(),
      body: Column(
        children: [
          _headerInformation(widget.title),
          _signContainer(),
        ],
      ),
    );
  }

  /// Builds the header of the screen, that contains the title and the close button.
  Container _headerInformation(String title) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(color: widget.textColor)),
          IconButton(
            icon: Icon(widget.icon, size: 25),
            color: widget.closeButtonColor,
            onPressed: () {
              if (widget.closeAlert == null) {
                Navigator.pop(context);
              } else {
                showDialog(
                    context: context, builder: (_) => widget.closeAlert!);
              }
            },
          ),
        ],
      ),
    );
  }

  /// Builds signature container
  Widget _signContainer() {
    return Expanded(
      child: Signature(
        controller: _controller,
        width: double.infinity,
        backgroundColor: widget.backgroundColor!,
      ),
    );
  }

  /// Builds in the bottom of the screen, the buttons to clean or send the signature, besides theirs properties.
  Widget _bottomActions() {
    return BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              height: 1,
              color: widget.disabledButtonColor,
              thickness: 1,
              indent: 0,
              endIndent: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: widget.enabledButtonColor),
                  onPressed: (!isButtonActive)
                      ? null
                      : () {
                          setState(() {
                            isButtonActive = false;
                            _controller.clear();
                          });
                        },
                  child: Text(widget.deleteButtonText,
                      style: TextStyle(
                          color: (isButtonActive)
                              ? widget.enabledButtonColor
                              : widget.disabledButtonColor)),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: widget.disabledButtonColor,
                      backgroundColor: widget.enabledButtonColor),
                  onPressed: (!isButtonActive) ? null : () => exportImage(),
                  child: Text(widget.doneButtonText,
                      style: TextStyle(
                          color: (isButtonActive)
                              ? Colors.white
                              : widget.enabledButtonColor)),
                ),
              ]),
            ),
          ],
        ));
  }

  /// Exports image in 8-bit format and send it to the next sceen.
  Future<void> exportImage() async {
    final Uint8List? data =
        await _controller.toPngBytes(height: 1000, width: 1000);

    if (data == null) {
      return;
    }

    if (!mounted) return;
    Navigator.pop(context, data);
  }
}
