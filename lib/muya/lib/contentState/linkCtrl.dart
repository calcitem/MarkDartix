void linkCtrl(dynamic contentState) {
  contentState.unlink = (Map<String, dynamic> linkInfo) {
    String key = linkInfo['key'];
    Map<String, dynamic> token = linkInfo['token'];
    dynamic block = contentState.getBlock(key);
    String text = block.text;
    String? anchor;

    switch (token['type']) {
      case 'html_tag':
        anchor = token['content'];
        break;
      case 'link':
        anchor = token['href'];
        break;
      case 'text':
        {
          RegExpMatch? match = RegExp(r'^\[(.+?)\]').firstMatch(token['raw']);
          if (match != null && match.group(1) != null) {
            anchor = match.group(1)!;
          }
          break;
        }
    }

    if (anchor == null) {
      print('Cannot find anchor when unlink');
      return;
    }

    block.text = text.substring(0, token['range']['start']) +
        anchor +
        text.substring(token['range']['end']);

    contentState.cursor = {
      'start': {'key': key, 'offset': token['range']['start']},
      'end': {'key': key, 'offset': token['range']['start'] + anchor.length},
    };

    contentState.singleRender(block);
    return contentState.muya.dispatchChange();
  };
}
