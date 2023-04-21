import 'package:flutter/widgets.dart';
// import 'package:muya/utils/resize_code_line_number.dart';
// import 'package:muya/utils/throttle.dart';
import 'muya.dart';

class Resize {
  Muya muya;

  Resize(this.muya) {
    listen();
  }

  void listen() {
    // FIXME: Disabled due to #1648.
    // final codeBlockLineNumbers = muya.options['codeBlockLineNumbers'];
    // if (!codeBlockLineNumbers) {
    //   return;
    // }

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   WidgetsBinding.instance.addPersistentFrameCallback((timeStamp) {
    //     throttle(() {
    //       final codeBlocks = document.querySelectorAll('pre.line-numbers');
    //       if (codeBlocks.isNotEmpty) {
    //         for (final ele in codeBlocks) {
    //           resizeCodeBlockLineNumber(ele);
    //         }
    //       }
    //     }, const Duration(milliseconds: 300));
    //   });
    // });
  }
}
