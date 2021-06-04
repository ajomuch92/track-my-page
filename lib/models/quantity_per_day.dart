
import 'package:track_my_page/models/chart_model.dart';

class QuantityPerDay{
  const QuantityPerDay._({this.day, this.month, this.year, this.quantity,});
  final int? day;
  final int? month;
  final int? year;
  final int? quantity; 

  
  static QuantityPerDay fromJson(Map<String, dynamic> json){
    return QuantityPerDay._(day:json['_day'], month:json['_month'], year:json['_year'], quantity:json['quantity'],);
  }

  Map<String, dynamic> toJson(){
    return {'day': day, 'month': month, 'year': year, 'quantity': quantity,};
  }

  ChartModel toChartModel() {
    return ChartModel(
      label: '$day/$month/$year',
      value: quantity!.toDouble(),
    );
  }
    
}
    