import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase/supabase.dart';

final SupabaseClient clientSupabase = SupabaseClient(dotenv.env['BASE_URL'].toString(), dotenv.env['API_KEY'].toString());

