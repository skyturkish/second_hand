import 'dart:async';
import 'package:flutter/material.dart';
import 'package:second_hand/core/extensions/context_extension.dart';
import 'package:second_hand/loading/loading_screen_controller.dart';

class LoadingScreen {
  factory LoadingScreen() => _shared;
  static final LoadingScreen _shared = LoadingScreen._sharedInstance();
  LoadingScreen._sharedInstance();

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
    required String text,
  }) {
    if (_controller?.update(text) ?? false) {
      return;
    } else {
      _controller = _showOverlay(
        context: context,
        text: text,
      );
    }
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  // overlay, kelime anlamıyla üstüne yatma, yani ekranın üstüne bir şey getirip gösterme
  LoadingScreenController _showOverlay({
    required BuildContext context,
    required String text,
  }) {
    final streamControllerText = StreamController<String>();

    streamControllerText.add(text);

    // get the size
    final state = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150), // It provides a transparent view on the back.
          child: Center(
            child: Container(
              constraints: BoxConstraints(
                // It limits a area which we will see on the app
                maxWidth: size.width * 0.8,
                maxHeight: size.height * 0.8,
                minWidth: size.width * 0.8,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadiusDirectional.circular(10.0),
              ),
              child: Padding(
                padding: context.paddingAllMedium,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: context.paddingOnlyTopSmall,
                        child: const CircularProgressIndicator(),
                      ),
                      Padding(
                        padding: context.paddingOnlyTopSmall,
                        child: Text(
                          text,
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: context.paddingOnlyTopMedium,
                        child: StreamBuilder<String>(
                          stream: streamControllerText.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data ?? 'loading_screen.dart 81.satır null geldi',
                                textAlign: TextAlign.center,
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
    // https://stackoverflow.com/questions/56537718/what-assert-do-in-dart ,,, eğer test yazmıyorsak bunu kullanabilirsen
    state?.insert(
        overlay); // Overlay.of(context) aynı ekranın uzunluğunu alıyormuş gibi, ekranın state'ini alıyormuş gibi düşünebiliriz

    return LoadingScreenController(
      close: () {
        streamControllerText.close();
        overlay.remove();
        return true;
      },
      update: (text) {
        streamControllerText.add(text);
        return true;
      },
    );
  }
}
