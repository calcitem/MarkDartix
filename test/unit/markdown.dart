import 'dart:io';
import 'package:path/path.dart' as p;

String loadMarkdownContent(String pathname) {
  // Load file and ensure LF line endings.
  final filePath = p.join('test', 'unit', 'data', pathname);
  return File(filePath)
      .readAsStringSync()
      .replaceAll(RegExp(r'(?:\r\n|\n)'), '\n');
}

String basicTextFormattingTemplate() {
  return loadMarkdownContent('common/BasicTextFormatting.md');
}

String blockquotesTemplate() {
  return loadMarkdownContent('common/Blockquotes.md');
}

String codeBlocksTemplate() {
  return loadMarkdownContent('common/CodeBlocks.md');
}

String escapesTemplate() {
  return loadMarkdownContent('common/Escapes.md');
}

String headingsTemplate() {
  return loadMarkdownContent('common/Headings.md');
}

String imagesTemplate() {
  return loadMarkdownContent('common/Images.md');
}

String linksTemplate() {
  return loadMarkdownContent('common/Links.md');
}

String listsTemplate() {
  return loadMarkdownContent('common/Lists.md');
}

// --------------------------------------------------------
// GFM templates
//

String gfmBasicTextFormattingTemplate() {
  return loadMarkdownContent('gfm/BasicTextFormatting.md');
}

String gfmListsTemplate() {
  return loadMarkdownContent('gfm/Lists.md');
}

String gfmTablesTemplate() {
  return loadMarkdownContent('gfm/Tables.md');
}
