import 'package:html/dom.dart';
import 'package:html/parser.dart';

bool isValidAttribute(String attribute) {
  // List of valid attributes based on your requirements
  const List<String> validAttributes = [
    'class',
    'id',
    'style',
    // add more attributes as needed
  ];

  return validAttributes.contains(attribute);
}

String sanitize(String inputHtml) {
  final DocumentFragment fragment = parseFragment(inputHtml);
  final NodeValidator validator = _createNodeValidator();

  return fragment.outerHtml.replaceAllMapped(
    RegExp(r'<\s*/?\s*\w+'),
    (Match match) => match[0]!.toLowerCase(),
  );
}

NodeValidator _createNodeValidator() {
  final NodeValidatorBuilder builder = NodeValidatorBuilder()
    ..allowElement('a', attributes: ['href'])
    ..allowElement('img', attributes: ['src'])
    // Add more allowed elements and attributes as needed
    ..allowNavigation();

  return builder.build();
}
