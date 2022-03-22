import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:imperium/database/models/category.dart';
import 'package:imperium/database/models/substance.dart';
import 'package:imperium/managers/effects_manager.dart';
import 'package:imperium/providers/loading.dart';
import 'package:imperium/scraping/models/psycho_substance.dart';

class SubstanceScraper {
  static final SubstanceScraper _substanceScraper = SubstanceScraper._internal();

  factory SubstanceScraper() => _substanceScraper;
  SubstanceScraper._internal();

  Client httpClient = Client();

  Future<String> _getImperiumResponse() async {
    try {
      final Response response = await httpClient.get(Uri.http('pred.me:5002', '/getAllDrugs'));
      return response.body;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, String>> getSubstanceCache(WidgetRef ref) async {
    final Map<String, String> result = {};
    print('SubstanceScraper::_getSubstanceCache: No substance cache found, fetching from the internet...');

    try {
      ref.watch(subtitleLoadingProvider.notifier).state = "Querying API...";
      result["api"] = await _getImperiumResponse();
    } catch (e) {
      print('ERROR!! SubstanceScraper::_getSubstanceCache: Something went wrong while getting drug cache! -- $e');
      // throw e;
    }

    return result;
  }

  Future<String> getCategoryCache(WidgetRef ref) async {
    try {
      print('SubstanceScraper::_getCategoryCache: No categories cache found, fetching from the internet...');
      ref.watch(subtitleLoadingProvider.notifier).state = "Fetching categories from API...";
      final Response tripsitResponse = await httpClient.get(Uri.http('pred.me:5002', '/getAllCategories'));
      return tripsitResponse.body;
    } catch (e) {
      print('ERROR!! SubstanceScraper::_getCategoryCache: Something went wrong while getting the category cache! -- $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> parseSubstance(Map<String, String> responses, WidgetRef ref) async {
    final Map<String, dynamic> result = {};
    Map<String, dynamic> tripsitMap = {};

    result['result'] = [];
    result['api'] = false;

    try {
      tripsitMap = json.decode(responses["api"]!) as Map<String, dynamic>;
    } catch (e) {
      print('ERROR!! SubstanceScraper::parseSubstance: Error while decoding API response -- $e');
      result['api'] = true;
    }

    if (!(result['api'] as bool)) {
      int count = 1;

      try {
        for (final MapEntry<String, dynamic> entryTop in tripsitMap.entries) {
          ref.watch(subtitleLoadingProvider.notifier).state = "Parsing items from API ($count / ${tripsitMap.length.toString()})";
          final Substance substance = Substance.fromParsed(PsychoSubstance.fromJson(entryTop.value as Map<String, dynamic>));

          result['result'].add(substance);
          count++;
        }
      } catch (e) {
        print('ERROR!! SubstanceScraper::parseSubstance: Error while parsing API response -- $e');
        // throw Exception(e);
      }
    }

    print('Unknown effects: ${EffectsManager().unknownEffectCount}');
    return result;
  }

  Future<Map<String, Category>> parseCategories(String input) async {
    final Map<String, Category> scrapedCategories = <String, Category>{};
    try {
      final List<dynamic> categories = json.decode(input) as List<dynamic>;
      for (final dynamic cat in categories) {
        final Category category = Category.fromJson(cat as Map<String, dynamic>);
        scrapedCategories[category.name!] = category;
      }
    } catch (e) {
      print('ERROR!! SubstanceScraper::parseCategories: $e');
      throw Exception(e.toString());
    }

    return scrapedCategories;
  }
}
