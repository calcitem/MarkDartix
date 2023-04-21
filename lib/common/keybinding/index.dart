import 'dart:io';

bool isOsx = Platform.isMacOS;

String _normalizeAccelerator(String accelerator) {
  return accelerator
      .toLowerCase()
      .replaceAll('commandorcontrol', isOsx ? 'cmd' : 'ctrl')
      .replaceAll('cmdorctrl', isOsx ? 'cmd' : 'ctrl')
      .replaceAll('control', 'ctrl')
      .replaceAll('meta', 'cmd') // meta := cmd (macOS only) or super
      .replaceAll('command', 'cmd')
      .replaceAll('option', 'alt');
}

bool isEqualAccelerator(String a, String b) {
  a = _normalizeAccelerator(a);
  b = _normalizeAccelerator(b);
  int i1 = a.indexOf('+');
  int i2 = b.indexOf('+');
  if (i1 == -1 && i2 == -1) {
    return a == b;
  } else if (i1 == -1 || i2 == -1) {
    return false;
  }

  List<String> partsA = a.split('+');
  List<String> partsB = b.split('+');
  if (partsA.length != partsB.length) {
    return false;
  }

  Set<String> intersection = Set.from(partsA)..addAll(partsB);
  return intersection.length == partsB.length;
}
