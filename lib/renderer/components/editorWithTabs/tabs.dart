import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:your_app/tabs_bloc.dart'; // Import your bloc for handling tab actions

class TabsView extends StatefulWidget {
  @override
  _TabsViewState createState() => _TabsViewState();
}

class _TabsViewState extends State<TabsView> {
  TabBloc _tabBloc; // Initialize your bloc for handling tab actions

  @override
  void initState() {
    super.initState();
    _tabBloc = TabBloc(); // Initialize your bloc for handling tab actions
  }

  @override
  void dispose() {
    _tabBloc.dispose(); // Dispose your bloc when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TabItem>>(
        stream: _tabBloc.tabs,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          final tabs = snapshot.data;

          return Row(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: tabs.length,
                  itemBuilder: (context, index) {
                    final tab = tabs[index];
                    return _buildTab(tab, _tabBloc);
                  },
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _tabBloc.addNewTab(),
              ),
            ],
          );
        });
  }

  Widget _buildTab(TabItem tab, TabBloc tabBloc) {
    return GestureDetector(
      onTap: () => tabBloc.selectTab(tab.id),
      onLongPress: () => _showContextMenu(context, tab, tabBloc),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: tab.isActive ? Colors.white : Colors.grey[200],
          border: tab.isActive
              ? Border(bottom: BorderSide(width: 2, color: Colors.blue))
              : null,
        ),
        child: Row(
          children: [
            Text(
              tab.title,
              style: TextStyle(fontSize: 12, color: Colors.black),
              overflow: TextOverflow.ellipsis,
            ),
            if (tab.isUnsaved)
              Padding(
                padding: const EdgeInsets.only(left: 4),
                child: Icon(
                  Icons.circle,
                  size: 6,
                  color: Colors.blue,
                ),
              ),
            IconButton(
              icon: Icon(Icons.close, size: 14),
              onPressed: () => tabBloc.closeTab(tab.id),
            ),
          ],
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, TabItem tab, TabBloc tabBloc) {
    // Implement your context menu logic here
  }
}
