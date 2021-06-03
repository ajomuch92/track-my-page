import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase/supabase.dart';

final SupabaseClient client = SupabaseClient(dotenv.env['VAR_NAME'].toString(), dotenv.env['VAR_NAME'].toString());

