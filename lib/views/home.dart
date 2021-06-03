import 'package:flutter/material.dart';
import 'package:track_my_page/data/data_provider.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  final DataProvider provider = DataProvider();
  int? visitors = 0;
  double? average = 0;

  @override
  void initState() { 
    super.initState();
    provider.getTotalVisitors().then((value) {
      setState(() {
        visitors = value.count;
        average = value.avg;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Size _size = MediaQuery.of(context).size;

    return Container(
      color: Colors.blueGrey.shade800,
      child: Center(
        child: Container(
          height: _size.height * 0.35,
          width: _size.width * 0.75,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade900.withOpacity(0.5),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Visitantes', style: TextStyle(color: Colors.white, fontSize: 20.0),),
              Text(visitors!.toString(), style: TextStyle(color: Colors.white, fontSize: 48.0),),
              Text('Promedio $average', style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}