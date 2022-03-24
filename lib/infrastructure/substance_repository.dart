import 'dart:convert';

import 'package:http/http.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/scraping/models/psycho_substance.dart';

class SubstanceRepository {
  final Client _httpClient = Client();
  Future<List<Substance>> fetchSubstances() async {
    final List<Substance> result = [];
    final Response response = await _httpClient.get(Uri.http('pred.me:5002', '/getAllDrugs'));

    final Map<String, dynamic> substances = jsonDecode(response.body) as Map<String, dynamic>;
    for (final MapEntry<String, dynamic> sub in substances.entries) {
      final Substance substance = Substance.fromParsed(PsychoSubstance.fromJson(sub.value as Map<String, dynamic>));
      result.add(substance);
    }

    return result;
  }
}
