import 'package:flutter/widgets.dart';
import 'package:muya/utils/get_link_info.dart';
import 'package:muya/utils/collect_footnotes.dart';
import 'muya.dart';
import 'event_center.dart';

class MouseEvent {
  Muya muya;
  EventCenter eventCenter;

  MouseEvent(this.muya) {
    eventCenter = muya.eventCenter;
    mouseBinding();
    mouseDown();
  }

  void mouseBinding() {
    final handler = (PointerEvent event) {
      final target = event.originalTarget as Element;
      final parent = target.parent;
      final preSibling = target.previousElementSibling;
      final parentPreSibling = parent?.previousElementSibling;
      final hideLinkPopup = muya.options['hideLinkPopup'];
      final footnote = muya.options['footnote'];
      final rect = parent.getBoundingClientRect();
      final reference = {
        'getBoundingClientRect': () {
          return rect;
        },
      };

      if (!hideLinkPopup &&
          parent != null &&
          parent.tagName == 'A' &&
          parent.classes.contains('ag-inline-rule') &&
          parentPreSibling != null &&
          parentPreSibling.classes.contains('ag-hide')) {
        eventCenter.dispatch('muya-link-tools', {
          'reference': reference,
          'linkInfo': getLinkInfo(parent),
        });
      }

      if (footnote &&
          parent != null &&
          parent.tagName == 'SUP' &&
          parent.classes.contains('ag-inline-footnote-identifier') &&
          preSibling != null &&
          preSibling.classes.contains('ag-hide')) {
        final identifier = target.text;
        eventCenter.dispatch('muya-footnote-tool', {
          'reference': reference,
          'identifier': identifier,
          'footnotes': collectFootnotes(muya.contentState.blocks),
        });
      }
    };

    final leaveHandler = (PointerEvent event) {
      final target = event.originalTarget as Element;
      final parent = target.parent;
      final preSibling = target.previousElementSibling;
      final footnote = muya.options['footnote'];

      if (parent != null &&
          parent.tagName == 'A' &&
          parent.classes.contains('ag-inline-rule')) {
        eventCenter.dispatch('muya-link-tools', {
          'reference': null,
        });
      }

      if (footnote &&
          parent != null &&
          parent.tagName == 'SUP' &&
          parent.classes.contains('ag-inline-footnote-identifier') &&
          preSibling != null &&
          preSibling.classes.contains('ag-hide')) {
        eventCenter.dispatch('muya-footnote-tool', {
          'reference': null,
        });
      }
    };

    eventCenter.attachDOMEvent(
        muya.container, 'pointermove', handler, false);
    eventCenter.attachDOMEvent(
        muya.container, 'pointerout', leaveHandler, false);
  }

  void mouseDown() {
    final handler = (PointerDownEvent event) {
      final target = event.originalTarget as Element;
      if (target.classes.contains('ag-drag-handler')) {
        muya.contentState.handleMouseDown(event);
      } else if (target.closest('tr') != null) {
        muya.contentState.handleCellMouseDown(event);
      }
    };

    eventCenter.attachDOMEvent(
        muya.container, 'pointerdown', handler, false);
  }
}
