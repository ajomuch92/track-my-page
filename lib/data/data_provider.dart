
import 'package:supabase/supabase.dart';
import 'package:track_my_page/data/supabase_client.dart';
import 'package:track_my_page/models/counter_model.dart';
import 'package:track_my_page/models/quantity_per_country.dart';
import 'package:track_my_page/models/quantity_per_day.dart';

class DataProvider {
  final SupabaseClient _client = clientSupabase;

  Future<CounterModel> getTotalVisitors() async {
    final result = await _client.from('page_log').select('id').execute();
    if(result.status == 200){
      List<dynamic> data = result.data;
      DateTime initDate = DateTime(2021, 5, 23);
      DateTime now = DateTime.now();
      Duration diff = now.difference(initDate);
      double avg = double.parse((data.length / diff.inDays).toStringAsFixed(2));
      return CounterModel(count: data.length, avg: avg);
    }
    return CounterModel(count: 0, avg: 0);
  }

  Future<List<QuantityPerCountry>> getQuantityPerCountry() async {
    List<QuantityPerCountry> list = [];
    final result = await _client.from('vw_visitors_per_country').select().execute();
    if(result.status == 200) {
      List<dynamic> data = result.data;
      for(var d in data) {
        QuantityPerCountry quantity = QuantityPerCountry.fromJson(d);
        list.add(quantity);
      }
    }
    return list;
  }

  Future<List<QuantityPerDay>> getQuantityPerDay() async {
    List<QuantityPerDay> list = [];
    final result = await _client.from('vw_visitors_per_day')
      .select()
      .order('_year')
      .order('_month')
      .order('_day')
      .limit(21)
      .execute();
    if(result.status == 200) {
      List<dynamic> data = result.data;
      for(var d in data) {
        QuantityPerDay quantity = QuantityPerDay.fromJson(d);
        list.add(quantity);
      }
    }
    return list;
  }
}