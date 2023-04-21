class MenuItem {
  String label;
  String id;
  String role;
  Function onClick;

  MenuItem({this.label, this.id, this.role, this.onClick});
}

MenuItem cut = MenuItem(
  label: 'Cut',
  id: 'cutMenuItem',
  role: 'cut',
);

MenuItem copy = MenuItem(
  label: 'Copy',
  id: 'copyMenuItem',
  role: 'copy',
);

MenuItem paste = MenuItem(
  label: 'Paste',
  id: 'pasteMenuItem',
  role: 'paste',
);

MenuItem copyAsMarkdown = MenuItem(
  label: 'Copy As Markdown',
  id: 'copyAsMarkdownMenuItem',
  onClick: (dynamic targetWindow) {
    // Implement sending message 'mt::cm-copy-as-markdown' to targetWindow
  },
);

MenuItem copyAsHtml = MenuItem(
  label: 'Copy As Html',
  id: 'copyAsHtmlMenuItem',
  onClick: (dynamic targetWindow) {
    // Implement sending message 'mt::cm-copy-as-html' to targetWindow
  },
);

MenuItem pasteAsPlainText = MenuItem(
  label: 'Paste as Plain Text',
  id: 'pasteAsPlainTextMenuItem',
  onClick: (dynamic targetWindow) {
    // Implement sending message 'mt::cm-paste-as-plain-text' to targetWindow
  },
);

MenuItem insertBefore = MenuItem(
  label: 'Insert Paragraph Before',
  id: 'insertParagraphBeforeMenuItem',
  onClick: (dynamic targetWindow) {
    // Implement sending message 'mt::cm-insert-paragraph' with 'before' parameter to targetWindow
  },
);

MenuItem insertAfter = MenuItem(
  label: 'Insert Paragraph After',
  id: 'insertParagraphAfterMenuItem',
  onClick: (dynamic targetWindow) {
    // Implement sending message 'mt::cm-insert-paragraph' with 'after' parameter to targetWindow
  },
);

MenuItem separator = MenuItem(
  label: '',
  id: '',
  role: 'separator',
);
