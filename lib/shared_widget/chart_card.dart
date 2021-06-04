import 'package:flutter/material.dart';
import 'package:glyphicon/glyphicon.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:track_my_page/models/chart_model.dart';
import 'package:track_my_page/shared_widget/black_card.dart';

class ChartCard extends StatefulWidget {
  final String? title;
  final List<ChartModel>? pieData;

  ChartCard({Key? key, this.title, this.pieData}) : super(key: key);

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  int _indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    return BlackCard(
      child: Stack(
        children: [
          _indexSelected == 1? 
          SfCircularChart(
            title: ChartTitle(text: widget.title!,
              alignment: ChartAlignment.near, 
              textStyle: TextStyle(color: Colors.white)
            ),
            series: <CircularSeries>[
              PieSeries<ChartModel, String>(
                dataSource: widget.pieData,
                xValueMapper: (ChartModel data, _) => data.label,
                yValueMapper: (ChartModel data, _) => data.value,
                dataLabelMapper: (ChartModel data, _) => '${data.label} ${data.value}',
                enableTooltip: true,
                dataLabelSettings: DataLabelSettings(isVisible : true)
              )
            ]
          )
          :
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SfCartesianChart(
              title: ChartTitle(text: widget.title!, 
                alignment: ChartAlignment.near, 
              ),
              primaryXAxis: CategoryAxis(),
              backgroundColor: Colors.white,
              series: <ChartSeries>[
                LineSeries<ChartModel, String>(
                  dataSource: widget.pieData!,
                  xValueMapper: (ChartModel data, _) => data.label,
                  yValueMapper: (ChartModel data, _) => data.value,
                  dataLabelSettings: DataLabelSettings(isVisible : true)
                )
              ]
            ),
          ),
          Positioned(
            right: 10.0,
            top: 10.0,
            child: ToggleSwitch(
              initialLabelIndex: _indexSelected,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              labels: ['', ''],
              icons: [Glyphicon.graph_up, Glyphicon.pie_chart_fill],
              iconSize: 15.0,
              onToggle: (index) {
                setState(() {
                  _indexSelected = index;
                });
              },
            ),
          ),
        ],
      )
    );
  }
}