import 'package:mydiet/domain/mois.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MoisRepository<T> {
  final SupabaseClient _client = Supabase.instance.client;

  Future<void> fetchMois(Function(List<dynamic>) onSuccess) async {
    final response = await _client.from("Mois").select();

    final data = response as List<dynamic>;
    onSuccess(data);
  }

  void insert(Mois mois) async {
    await _client
        .from('Mois')
        .insert(mois);
  }
}