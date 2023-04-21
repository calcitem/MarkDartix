import 'package:keyboard_shortcuts/keyboard_shortcuts.dart';

final Map<String, KeyShortcut> keyBindings = {
  // MarkDartix menu
  'mt.hide': KeyShortcut(ModifierKeys.meta, 'H'),
  'mt.hide-others': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'H'),
  'file.preferences': KeyShortcut(ModifierKeys.meta, ','),

  // File menu
  'file.new-window': KeyShortcut(ModifierKeys.meta, 'N'),
  'file.new-tab': KeyShortcut(ModifierKeys.meta, 'T'),
  'file.open-file': KeyShortcut(ModifierKeys.meta, 'O'),
  'file.open-folder': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'O'),
  'file.save': KeyShortcut(ModifierKeys.meta, 'S'),
  'file.save-as': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'S'),
  'file.move-file': KeyShortcut.none(),
  'file.rename-file': KeyShortcut.none(),
  'file.print': KeyShortcut.none(),
  'file.close-tab': KeyShortcut(ModifierKeys.meta, 'W'),
  'file.close-window': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'W'),
  'file.quit': KeyShortcut(ModifierKeys.meta, 'Q'),

  // Edit menu
  'edit.undo': KeyShortcut(ModifierKeys.meta, 'Z'),
  'edit.redo': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'Z'),
  'edit.cut': KeyShortcut(ModifierKeys.meta, 'X'),
  'edit.copy': KeyShortcut(ModifierKeys.meta, 'C'),
  'edit.paste': KeyShortcut(ModifierKeys.meta, 'V'),
  'edit.copy-as-markdown':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'C'),
  'edit.copy-as-html': KeyShortcut.none(),
  'edit.paste-as-plaintext':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'V'),
  'edit.select-all': KeyShortcut(ModifierKeys.meta, 'A'),
  'edit.duplicate': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'D'),
  'edit.create-paragraph':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'N'),
  'edit.delete-paragraph':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'D'),
  'edit.find': KeyShortcut(ModifierKeys.meta, 'F'),
  'edit.find-next': KeyShortcut(ModifierKeys.meta, 'G'),
  'edit.find-previous':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'G'),
  'edit.replace': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'F'),
  'edit.find-in-folder':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'F'),
  'edit.screenshot': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'A'),

  // Paragraph menu
  'paragraph.heading-1': KeyShortcut(ModifierKeys.meta, '1'),
  'paragraph.heading-2': KeyShortcut(ModifierKeys.meta, '2'),
  'paragraph.heading-3': KeyShortcut(ModifierKeys.meta, '3'),
  'paragraph.heading-4': KeyShortcut(ModifierKeys.meta, '4'),
  'paragraph.heading-5': KeyShortcut(ModifierKeys.meta, '5'),
  'paragraph.heading-6': KeyShortcut(ModifierKeys.meta, '6'),
  'paragraph.upgrade-heading': KeyShortcut(ModifierKeys.meta, '+'),
  'paragraph.degrade-heading': KeyShortcut(ModifierKeys.meta, '-'),
  'paragraph.table': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'T'),
  'paragraph.code-fence':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'C'),
  'paragraph.quote-block':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'Q'),
  'paragraph.math-formula':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'M'),
  'paragraph.html-block':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'J'),
  'paragraph.order-list':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'O'),
  'paragraph.bullet-list':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'U'),
  'paragraph.task-list': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'X'),
  'paragraph.loose-list-item':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'L'),
  'paragraph.paragraph': KeyShortcut(ModifierKeys.meta, '0'),
  'paragraph.horizontal-line':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, '-'),
  'paragraph.front-matter':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'Y'),

  // Format menu
  'format.strong': KeyShortcut(ModifierKeys.meta, 'B'),
  'format.emphasis': KeyShortcut(ModifierKeys.meta, 'I'),
  'format.underline': KeyShortcut(ModifierKeys.meta, 'U'),
  'format.superscript': KeyShortcut.none(),
  'format.subscript': KeyShortcut.none(),
  'format.highlight': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'H'),
  'format.inline-code': KeyShortcut(ModifierKeys.meta, '`'),
  'format.inline-math':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'M'),
  'format.strike': KeyShortcut(ModifierKeys.meta, 'D'),
  'format.hyperlink': KeyShortcut(ModifierKeys.meta, 'L'),
  'format.image': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'I'),
  'format.clear-format':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'R'),

  // Window menu
  'window.minimize': KeyShortcut(ModifierKeys.meta, 'M'),
  'window.toggle-always-on-top': KeyShortcut.none(),
  'window.zoom-in': KeyShortcut.none(),
  'window.zoom-out': KeyShortcut.none(),
  'window.toggle-full-screen':
      KeyShortcut(ModifierKeys.ctrl | ModifierKeys.meta, 'F'),

  // View menu
  'view.command-palette':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'P'),
  'view.source-code-mode':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'S'),
  'view.typewriter-mode':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'T'),
  'view.focus-mode': KeyShortcut(ModifierKeys.meta | ModifierKeys.shift, 'J'),
  'view.toggle-sidebar': KeyShortcut(ModifierKeys.meta, 'J'),
  'view.toggle-toc': KeyShortcut(ModifierKeys.meta, 'K'),
  'view.toggle-tabbar': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'B'),
  'view.toggle-dev-tools':
      KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'I'),
  'view.dev-reload': KeyShortcut(ModifierKeys.meta | ModifierKeys.alt, 'R'),
  'view.reload-images': KeyShortcut(ModifierKeys.meta, 'R'),

  // Not included in the application menu
  'tabs.cycle-forward': KeyShortcut(ModifierKeys.ctrl, 'Tab'),
  'tabs.cycle-backward':
      KeyShortcut(ModifierKeys.ctrl | ModifierKeys.shift, 'Tab'),
  'tabs.switch-to-left': KeyShortcut(ModifierKeys.meta, 'PageUp'),
  'tabs.switch-to-right': KeyShortcut(ModifierKeys.meta, 'PageDown'),
  'tabs.switch-to-first': KeyShortcut(ModifierKeys.ctrl, '1'),
  'tabs.switch-to-second': KeyShortcut(ModifierKeys.ctrl, '2'),
  'tabs.switch-to-third': KeyShortcut(ModifierKeys.ctrl, '3'),
  'tabs.switch-to-fourth': KeyShortcut(ModifierKeys.ctrl, '4'),
  'tabs.switch-to-fifth': KeyShortcut(ModifierKeys.ctrl, '5'),
  'tabs.switch-to-sixth': KeyShortcut(ModifierKeys.ctrl, '6'),
  'tabs.switch-to-seventh': KeyShortcut(ModifierKeys.ctrl, '7'),
  'tabs.switch-to-eighth': KeyShortcut(ModifierKeys.ctrl, '8'),
  'tabs.switch-to-ninth': KeyShortcut(ModifierKeys.ctrl, '9'),
  'tabs.switch-to-tenth': KeyShortcut(ModifierKeys.ctrl, '0'),
  'file.quick-open': KeyShortcut(ModifierKeys.meta, 'P'),
};
