import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:track_my_page/views/graph.dart';
import 'package:track_my_page/views/home.dart';

class Index extends StatefulWidget {
  Index({Key? key}) : super(key: key);

  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track my page - Demo'),
        backgroundColor: Colors.blueGrey.shade800,
        elevation: 0,
      ),
      body: PageView(
        controller: _controller,
        children: <Widget>[
          Home(),
          Graph(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        flat: true,
        items: [
          RollingBottomBarItem(Glyphicon.house_fill, label: 'Inicio'),
          RollingBottomBarItem(Glyphicon.bar_chart_steps, label: 'Gráficos'),
        ],
        activeItemColor: Colors.blueAccent,
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}