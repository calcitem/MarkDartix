import 'dart:html';
import 'package:muya/utils.dart';

class EventCenter {
  List<Map<String, dynamic>> events = [];
  Map<String, List<Map<String, dynamic>>> listeners = {};

  String attachDOMEvent(
      EventTarget target, String event, EventListener listener, bool capture) {
    if (checkHasBind(target, event, listener, capture)) return null;
    final eventId = getUniqueId();
    target.addEventListener(event, listener, capture);
    events.add({
      'eventId': eventId,
      'target': target,
      'event': event,
      'listener': listener,
      'capture': capture,
    });
    return eventId;
  }

  void detachDOMEvent(String eventId) {
    if (eventId == null) return;
    final index = events.indexWhere((e) => e['eventId'] == eventId);
    if (index > -1) {
      final target = events[index]['target'];
      final event = events[index]['event'];
      final listener = events[index]['listener'];
      final capture = events[index]['capture'];
      target.removeEventListener(event, listener, capture);
      events.removeAt(index);
    }
  }

  void detachAllDomEvents() {
    events.forEach((event) => detachDOMEvent(event['eventId']));
  }

  void _subscribe(String event, EventListener listener, bool once) {
    final handlers = listeners[event];
    final handler = {'listener': listener, 'once': once};
    if (handlers != null && handlers is List) {
      handlers.add(handler);
    } else {
      listeners[event] = [handler];
    }
  }

  void subscribe(String event, EventListener listener) {
    _subscribe(event, listener, false);
  }

  void unsubscribe(String event, EventListener listener) {
    final handlers = listeners[event];
    if (handlers != null && handlers is List) {
      final index =
          handlers.indexWhere((handler) => handler['listener'] == listener);
      if (index > -1) {
        handlers.removeAt(index);
      }
    }
  }

  void subscribeOnce(String event, EventListener listener) {
    _subscribe(event, listener, true);
  }

  void dispatch(String event, List<dynamic> data) {
    final eventListeners = listeners[event];
    if (eventListeners != null && eventListeners is List) {
      eventListeners.forEach((handler) {
        final listener = handler['listener'];
        final once = handler['once'];
        listener(data);
        if (once) {
          unsubscribe(event, listener);
        }
      });
    }
  }

  bool checkHasBind(EventTarget cTarget, String cEvent, EventListener cListener,
      bool cCapture) {
    for (final event in events) {
      final target = event['target'];
      final eventType = event['event'];
      final listener = event['listener'];
      final capture = event['capture'];

      if (target == cTarget &&
          eventType == cEvent &&
          listener == cListener &&
          capture == cCapture) {
        return true;
      }
    }
    return false;
  }
}
