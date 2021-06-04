import 'package:flutter/material.dart';
import 'package:track_my_page/data/data_provider.dart';
import 'package:track_my_page/models/counter_model.dart';
import 'package:track_my_page/shared_widget/black_card.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  final DataProvider provider = DataProvider();

  @override
  void initState() { 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      color: Colors.blueGrey.shade800,
      child: Center(
        child: BlackCard(
          child: FutureBuilder<CounterModel>(
            future: provider.getTotalVisitors(),
            builder: (context, snap) {
              if(snap.hasData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Visitantes', style: TextStyle(color: Colors.white, fontSize: 20.0),),
                    Text(snap.data!.count!.toString(), style: TextStyle(color: Colors.white, fontSize: 48.0),),
                    Text('Promedio ${snap.data!.avg!}', style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  ],
                );
              }
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}