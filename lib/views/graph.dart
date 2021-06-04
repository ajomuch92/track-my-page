import 'package:flutter/material.dart';
import 'package:track_my_page/data/data_provider.dart';
import 'package:track_my_page/models/chart_model.dart';
import 'package:track_my_page/models/quantity_per_country.dart';
import 'package:track_my_page/models/quantity_per_day.dart';
import 'package:track_my_page/shared_widget/chart_card.dart';

class Graph extends StatefulWidget {
  Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> with AutomaticKeepAliveClientMixin{
  final DataProvider provider = DataProvider();
  List<ChartModel> _pieData = [];
  List<ChartModel> _pieData2 = [];

  @override
  void initState() { 
    super.initState();
    initQuantityPerCountry();
    initQuantityPerDay();
  }

  Future<void> initQuantityPerCountry() async {
    List<QuantityPerCountry> list = await provider.getQuantityPerCountry();
    List<ChartModel> _data = [];
    for(var d in list) {
      _data.add(d.toChartModel());
    }
    setState(() {
      _pieData = _data;
    });
  }
  
  Future<void> initQuantityPerDay() async {
    List<QuantityPerDay> list = await provider.getQuantityPerDay();
    List<ChartModel> _data = [];
    for(var d in list) {
      _data.add(d.toChartModel());
    }
    setState(() {
      _pieData2 = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.blueGrey.shade800,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          ChartCard(
            title: 'Visitas por país',
            pieData: _pieData,
          ),
          ChartCard(
            title: 'Visitas por día',
            pieData: _pieData2,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}