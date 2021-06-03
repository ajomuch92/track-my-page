
import 'package:supabase/supabase.dart';
import 'package:track_my_page/data/supabase_client.dart';
import 'package:track_my_page/models/counter_model.dart';

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
}