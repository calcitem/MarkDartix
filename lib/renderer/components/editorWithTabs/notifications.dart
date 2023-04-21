import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notifications extends StatefulWidget {
  // Pass required data via constructor
  Notifications(
      {Key? key,
      required this.currentNotification,
      required this.showSideBar,
      required this.sideBarWidth})
      : super(key: key);

  final Map<String, dynamic>? currentNotification;
  final bool showSideBar;
  final double sideBarWidth;

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    if (widget.currentNotification == null) {
      return SizedBox.shrink();
    }
    return Container(
      width: widget.showSideBar
          ? MediaQuery.of(context).size.width - widget.sideBarWidth
          : MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              widget.currentNotification!['msg'],
              style: TextStyle(fontSize: 13),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.currentNotification!['showConfirm']
                  ? InkWell(
                      onTap: () => handleClick(true),
                      child: Container(
                        width: 24,
                        height: 24,
                        alignment: Alignment.center,
                        child: Text(
                          'Ok',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    )
                  : SizedBox.shrink(),
              InkWell(
                onTap: () => handleClick(false),
                child: Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    'assets/icons/close_small.svg',
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void handleClick(bool status) {
    if (widget.currentNotification == null) {
      print('notifications::handleClick: Cannot find notification on stack.');
      return;
    }
    final action = widget.currentNotification!['action'];
    if (action != null) {
      action(status);
    }
  }
}
