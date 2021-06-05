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
  List<QuantityPerCountry> _listQuantityPerCountry = [];
  List<QuantityPerDay> _listQuantityPerDay = [];

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
      _listQuantityPerCountry = list;
    });
  }
  
  Future<void> initQuantityPerDay() async {
    List<QuantityPerDay> list = await provider.getQuantityPerDay();
    List<ChartModel> _data = [];
    list.sort((a,b) => a.date!.compareTo(b.date!));
    for(var d in list) {
      _data.add(d.toChartModel());
    }
    setState(() {
      _pieData2 = _data;
      _listQuantityPerDay = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget _separator = SizedBox(
      height: 10.0,
    );

    return Container(
      color: Colors.blueGrey.shade800,
      child: ListView(
        padding: EdgeInsets.all(8.0),
        children: [
          ChartCard(
            title: 'Visitas por país',
            pieData: _pieData,
          ),
          _separator,
          _getTableViewPerCountry(),
          _separator,
          ChartCard(
            title: 'Visitas por día',
            pieData: _pieData2,
          ),
          _separator,
          _getTableViewPerDay(),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _getTableViewPerCountry() {
    List<TableRow> list = [
      TableRow(
        children: [
          Column(children: [Text('País', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          Column(children: [Text('Visitas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
        ]
      )
    ];
    for(QuantityPerCountry q in _listQuantityPerCountry) {
      list.add(
        TableRow(
          children: [
            Column(children: [Text(q.countryName!, style: TextStyle(color: Colors.white))]),
            Column(children: [Text(q.quantity!.toString(), style: TextStyle(color: Colors.white))]),
          ]
        )
      );
    }
    return Table(
      border: TableBorder.all(  
        color: Colors.white,  
        style: BorderStyle.solid,  
        width: 2
      ),
      children: list,
    );
  }

  Widget _getTableViewPerDay() {
    List<TableRow> list = [
      TableRow(
        children: [
          Column(children: [Text('Día', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
          Column(children: [Text('Visitas', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))]),
        ]
      )
    ];
    for(QuantityPerDay q in _listQuantityPerDay) {
      list.add(
        TableRow(
          children: [
            Column(children: [Text('${q.day}-${q.month}-${q.year}', style: TextStyle(color: Colors.white))]),
            Column(children: [Text(q.quantity!.toString(), style: TextStyle(color: Colors.white))]),
          ]
        )
      );
    }
    return Table(
      border: TableBorder.all(  
        color: Colors.white,  
        style: BorderStyle.solid,  
        width: 2
      ),
      children: list,
    );
  }
}