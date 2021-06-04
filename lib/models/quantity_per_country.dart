
import 'package:track_my_page/models/chart_model.dart';

class QuantityPerCountry{
  const QuantityPerCountry._({this.countryName, this.quantity,});
  final String? countryName;
  final int? quantity; 
  
  static QuantityPerCountry fromJson(Map<String, dynamic> json){
    return QuantityPerCountry._(countryName:json['countryName'], quantity:json['quantity'],);
  }
    
  Map<String, dynamic> toJson(){
    return {'countryName': countryName, 'quantity': quantity,};
  }

  ChartModel toChartModel() {
    return ChartModel(
      label: countryName,
      value: quantity!.toDouble(),
    );
  }
    
}
    