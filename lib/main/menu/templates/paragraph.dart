PopupMenuButton buildParagraphMenu() {
  return PopupMenuButton(
    icon: Icon(Icons.format_align_left),
    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
      PopupMenuItem(
        value: 'heading1',
        child: Text('Heading 1'),
      ),
      PopupMenuItem(
        value: 'heading2',
        child: Text('Heading 2'),
      ),
      PopupMenuItem(
        value: 'heading3',
        child: Text('Heading 3'),
      ),
      PopupMenuItem(
        value: 'heading4',
        child: Text('Heading 4'),
      ),
      PopupMenuItem(
        value: 'heading5',
        child: Text('Heading 5'),
      ),
      PopupMenuItem(
        value: 'heading6',
        child: Text('Heading 6'),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 'promoteHeading',
        child: Text('Promote Heading'),
      ),
      PopupMenuItem(
        value: 'demoteHeading',
        child: Text('Demote Heading'),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 'table',
        child: Text('Table'),
      ),
      PopupMenuItem(
        value: 'codeFences',
        child: Text('Code Fences'),
      ),
      PopupMenuItem(
        value: 'quoteBlock',
        child: Text('Quote Block'),
      ),
      PopupMenuItem(
        value: 'mathBlock',
        child: Text('Math Block'),
      ),
      PopupMenuItem(
        value: 'htmlBlock',
        child: Text('HTML Block'),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 'orderedList',
        child: Text('Ordered List'),
      ),
      PopupMenuItem(
        value: 'bulletList',
        child: Text('Bullet List'),
      ),
      PopupMenuItem(
        value: 'taskList',
        child: Text('Task List'),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 'looseListItem',
        child: Text('Loose List Item'),
      ),
      PopupMenuDivider(),
      PopupMenuItem(
        value: 'paragraph',
        child: Text('Paragraph'),
      ),
      PopupMenuItem(
        value: 'horizontalLine',
        child: Text('Horizontal Rule'),
      ),
      PopupMenuItem(
        value: 'frontMatter',
        child: Text('Front Matter'),
      ),
    ],
    onSelected: (value) {
      print('Selected menu item: $value');
      // Implement actions based on the selected value
    },
  );
}
