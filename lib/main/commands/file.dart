import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:markdartix/constants.dart';
import 'package:markdartix/enums.dart';
import 'package:markdartix/utils/utils.dart';

void openQuickOpenDialog(BuildContext context) {
  final channel = MethodChannel(MT_CHANNEL);
  channel.invokeMethod(MT_EXECUTE_COMMAND_BY_ID, 'file.quick-open');
}

void loadFileCommands(CommandManager commandManager) {
  commandManager.add(CommandId.fileQuickOpen, openQuickOpenDialog);
}
