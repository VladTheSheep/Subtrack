import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:subtrack/database/models/effect.dart';
import 'package:subtrack/database/models/enums/effect_category.dart';
import 'package:subtrack/database/models/enums/effect_type.dart';
import 'package:subtrack/database/models/enums/sub_effect_category.dart';
import 'package:subtrack/utils/string_manipulation.dart';

class EffectsManager {
  static final EffectsManager _effectsManager = EffectsManager._internal();

  factory EffectsManager() => _effectsManager;
  EffectsManager._internal();

  Map<EffectCategory, Map<SubEffectCategory, Map<String, EffectType>>> effects = <EffectCategory, Map<SubEffectCategory, Map<String, EffectType>>>{};
  int unknownEffectCount = 0;

  bool _effectsInit = false;

  void initEffects() {
    effects[EffectCategory.visual] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.cognitive] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.physical] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.auditory] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.disconnective] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.tactile] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.smellTaste] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.multisensory] = <SubEffectCategory, Map<String, EffectType>>{};
    _effectsInit = true;
  }

  Widget getEffectIcon(Effect effect, {double? size = 14.0, Color? color}) {
    return SvgPicture.asset(getEffectCategorySvgPath(effect.category), width: size, height: size, color: color ?? getEffectTypeColor(effect.type));
  }

  List<Effect>? parseEffects(Map<String, dynamic>? input) {
    if (input != null && input.isNotEmpty) {
      final List<Effect> result = [];
      for (final MapEntry<String, dynamic> entry in input.entries) {
        final Effect? tempEffect = parseEffect(entry.key);
        if (tempEffect != null) {
          tempEffect.url = entry.value.toString();
          result.add(tempEffect);
        }
      }
      return result;
    }
    print("ERROR!! EffectsManager::parseEffects: Invalid input given");
    return null;
  }

  Effect? parseEffect(String? effect) {
    if (!_effectsInit) initEffects();
    if (effect == null || effect.isEmpty) return null;

    String temp = effect.toLowerCase();
    if (temp.contains('#')) temp = temp.substring(findCharPos(temp, '#') + 1);
    switch (temp) {
      case 'acuity enhancement':
      case 'colour enhancement':
      case 'color enhancement':
      case 'brightened colour':
      case 'brightening of colors':
      case 'brightened color':
      case 'brightened colors':
      case 'frame rate enhancement':
      case 'magnification':
      case 'pattern recognition enhancement':
      case 'peripheral vision enhancement':
        return _parseVisualEnhancements(temp);

      case 'acuity suppression':
      case 'colour suppression':
      case 'double vision':
      case 'frame rate suppression':
      case 'pattern recognition suppression':
      case 'peripheral information misinterpretation':
        return _parseVisualSuppressions(temp);

      case 'after images':
      case 'brightness alteration':
      case 'colour replacement':
      case 'colour shifting':
      case 'color shifting':
      case 'hue shifts':
      case 'colour tinting':
      case 'depth perception distortions':
      case 'diffraction':
      case 'drifting':
      case 'environmental cubism':
      case 'environmental patterning':
      case 'environmental orbism':
      case 'object alteration':
      case 'perspective distortion':
      case 'radical shift in perspective and perception':
      case 'radical perspective shifting':
      case 'closed/open eye visuals':
      case 'closed and open eye visuals':
      case 'powerful closed/open eye visuals':
      case 'open eye visuals':
      case 'closed eye visuals':
      case "mild oev's":
      case "strong cev's":
      case 'recursion':
      case 'scenery slicing':
      case 'symmetrical texture repetition':
      case 'texture liquidation':
      case 'tracers':
      case 'visual flipping':
      case 'visual haze':
      case 'visual stretching':
      case 'visual snow':
      case 'visual distortions':
        return _parseVisualDistortions(temp);

      case '8a geometry - perceived exposure to semantic concept network':
      case '8b geometry - perceived exposure to inner mechanics of consciousness':
      case 'geometry':
        return _parseVisualGeometry(temp);

      case 'autonomous entity':
      case 'external hallucination':
      case 'internal hallucination':
      case 'object activation':
      case 'perspective hallucination':
      case 'settings, sceneries, and landscapes':
      case 'shadow people':
      case 'transformations':
      case 'unspeakable horrors':
        return _parseVisualHallucinatory(temp);

      case 'analysis enhancement':
      case 'anxiety':
      case 'creativity enhancement':
      case 'creativity':
      case 'dream potentiation':
      case 'ego inflation':
      case 'hyper-inflated ego':
      case 'ego softening':
      case 'ego-softening':
      case 'ego  softening':
      case 'emotion enhancement':
      case 'elevated mood':
      case 'heightend emotions':
      case 'moodiness':
      case 'empathy, affection, and sociability enhancement':
      case 'empathy, affection and sociability enhancement':
      case 'empathy':
      case 'feelings of empathy':
      case 'insight':
      case 'feelings of insight':
      case 'focus enhancement':
      case 'increased focus':
      case 'immersion enhancement':
      case 'sensory enhancement':
      case 'increased music appreciation':
      case 'increased sense of humor':
      case 'irritability':
      case 'increase in irritability':
      case 'agressiveness':
      case 'aggressiveness':
      case 'aggression':
      case 'rage':
      case 'memory enhancement':
      case 'motivation enhancement':
      case 'increased motivation':
      case 'incresed motivation':
      case 'novelty enhancement':
      case 'a sense of childlike wonder':
      case 'sense of wonder':
      case 'personal meaning enhancement':
      case 'suggestibility enhancement':
      case 'thought acceleration':
      case 'thought connectivity':
      case 'thought organization':
      case 'wakefulness':
      case 'increased alertness':
      case 'decreased need for sleep':
      case 'increased sociability':
      case 'sociability':
      case 'mood lift':
      case 'excessive talking':
      case 'increased desire to talk':
      case 'racing thoughts':
      case 'immersive experience':
      case 'cognitive enhancement':
      case 'increase in cognitive abilities':
        return _parseCognitiveEnhancements(temp);

      case 'addiction suppression':
      case 'amnesia':
      case 'amnesic':
      case 'blackouts':
      case 'memory loss':
      case 'blackout potential':
      case 'analysis suppression':
      case 'anxiety suppression':
      case 'anxiety supression':
      case 'anxiolytic':
      case 'cognitive fatigue':
      case 'fatigue':
      case 'confusion':
      case 'creativity suppression':
      case 'delirium':
      case 'delirium tremens':
      case 'disinhibition':
      case 'loss of inhibition':
      case 'lowered inhibitions':
      case 'dream suppression':
      case 'emotion suppression':
      case 'focus suppression':
      case 'language suppression':
      case 'memory suppression':
      case 'motivation suppression':
      case 'personal bias suppression':
      case 'sleepiness':
      case 'hypnotic':
      case 'tiredness':
      case 'lethargy':
      case 'suggestibility suppression':
      case 'thought deceleration':
      case 'thought disorganization':
        return _parseCognitiveSuppressions(temp);

      case 'autonomous voice communication':
      case 'cognitive dysphoria':
      case 'dysphoria':
      case 'cognitive euphoria':
      case 'euphoria':
      case 'feelings of euphoria':
      case 'euphoric':
      case 'with euphoria':
      case 'a strong sense of wellbeing':
      case 'compulsive redosing':
      case 'conceptual thinking':
      case 'enhancement and suppression cycles':
      case 'glossolalia':
      case 'multiple thought streams':
      case 'simultaneous emotions':
      case 'spatial disorientation':
      case 'thought loop':
      case 'change in perception':
      case 'altered perception':
      case 'time distortion':
      case 'loss of time':
      case 'change in perception of time':
      case 'changes in perception of time':
      case 'change in perception of  time':
      case 'changes in perception-of-time':
      case 'general change in consciousness':
      case 'change in consciousness':
      case 'dissociation':
        return _parseCognitiveNovel(temp);

      case 'catharsis':
      case 'delusions':
      case 'delusion':
      case 'delusions of sobriety':
      case 'depersonalization':
      case 'derealization':
      case 'depression':
      case 'déjà vu':
      case 'ego replacement':
      case 'feelings of impending doom':
      case 'introspection':
      case 'introspective insight':
      case 'mania':
      case 'mindfulness':
      case 'panic attack':
      case 'panic':
      case 'paranoia':
      case 'personality regression':
      case 'personality changes':
      case 'psychosis':
      case 'stimulant psychosis':
      case 'rejuvenation':
      case 'suicidal ideation':
      case 'sleep paralysis':
      case 'apathy':
      case 'insomnia':
      case 'distrubed sleep patterns':
      case 'disturbed sleep patterns':
      case 'overwhelming fear':
      case 'fear':
      case 'relaxation':
        return _parseCognitivePsychological(temp);

      case 'existential self-realization':
      case 'identity alteration':
      case 'perceived exposure to inner mechanics of consciousness':
      case 'perception of eternalism':
      case 'perception of interdependent opposites':
      case 'perception of predeterminism':
      case 'perception of self-design':
      case 'spirituality enhancement':
      case 'unity and interconnectedness':
      case 'a sense of connectedness with people and the environment around you':
      case 'a sense of conectedness with the world around you':
      case 'profound life-changing spiritual experiences':
        return _parseCognitiveTranspersonal(temp);

      case 'appetite enhancement':
      case 'bodily control enhancement':
      case 'enhanced tactile sensation':
      case 'increased libido':
      case 'sexual enhancement':
      case 'increased sex drive':
      case 'increase sexuality':
      case 'increased sexuality':
      case 'stamina enhancement':
      case 'stimulation':
      case 'mental/physical stimulation':
      case 'mental and physical stimulation':
      case 'stimulation (mental and physical)':
      case 'stimulating high':
      case 'increased energy/alertness':
      case 'anti-inflammation':
        return _parsePhysicalEnhancements(temp);

      case 'appetite suppression':
      case 'appetite suppressant':
      case 'decreased appetite':
      case 'reduced appetite':
      case 'loss of appettite':
      case 'loss of apetite':
      case 'cough suppression':
      case 'decreased libido':
      case 'motor control loss':
      case 'motor skill impairment':
      case 'dystaxia':
      case 'loss of motor skills':
      case 'inability to control muscles':
      case 'nausea suppression':
      case 'orgasm suppression':
      case 'pain relief':
      case 'analgesia':
      case 'sedation':
      case 'drowsiness':
      case 'sedative':
      case 'sedative effects':
      case 'feelings of relaxation':
      case 'seizure suppression':
        return _parsePhysicalSuppressions(temp);

      case 'body odor alteration':
      case 'bronchodilation':
      case 'changes in felt bodily form':
      case 'changes in felt gravity':
      case 'excessive yawning':
      case 'laughter fits':
      case 'giggling':
      case 'mouth numbing':
      case 'muscle relaxation':
      case 'muscle relaxant':
      case 'relaxant':
      case 'perception of bodily heaviness':
      case 'perception of bodily lightness':
      case 'physical autonomy':
      case 'physical euphoria':
      case 'pupil constriction':
      case 'pupil dilation':
      case 'pupil-dilation':
      case 'pupil dialation':
      case 'gait alteration':
      case 'rapid breathing':
      case 'skeletal muscle relaxant':
      case 'powerful rushing of sensation':
        return _parsePhysicalAlterations(temp);

      case 'abnormal heartbeat':
      case 'tachychardia':
      case 'decreased heart rate':
      case 'decreased blood pressure':
      case 'low blood pressure':
      case 'increased blood pressure':
      case 'high blood pressure':
      case 'hypertension':
      case 'increased heart rate':
      case 'elevated heart rate':
      case 'elevated heartrate':
      case 'raised heartrate':
      case 'vasoconstriction':
      case 'vasodilation':
      case 'heartburn':
      case 'reflex syncope':
        return _parsePhysicalCardiovascular(temp);

      case 'brain zaps':
      case 'dizziness':
      case 'headache':
      case 'headaches':
      case 'increased bodily temperature':
      case 'increased body temperature':
      case 'seizure':
      case 'temperature regulation suppression':
      case 'sweating/chills':
        return _parsePhysicalCerebrovascular(temp);

      case 'back pain':
      case 'bodily pressures':
      case 'constipation':
      case 'dehydration':
      case 'diarrhea':
      case 'difficulty urinating':
      case 'urinary retention':
      case 'dry mouth':
      case 'frequent urination':
      case 'increased phlegm production':
      case 'increased perspiration':
      case 'increased salivation':
      case 'itchiness':
      case 'itching':
      case 'muscle cramps':
      case 'muscle cramp':
      case 'muscle contractions':
      case 'muscle twitching':
      case 'muscle tension':
      case 'muscle-tension':
      case 'muscle tremors':
      case 'tremors':
      case 'body tremors':
      case 'muscle stiffness':
      case 'convulsions':
      case 'anticonvulsant':
      case 'nausea':
      case 'nausea (particularly at high doses)':
      case 'vomiting':
      case 'optical sliding':
      case 'photophobia':
      case 'physical fatigue':
      case 'respiratory depression':
      case 'restless legs':
      case 'runny nose':
      case 'salivation':
      case 'skin flushing':
      case 'flushed skin':
      case 'stomach bloating':
      case 'stomach cramp':
      case 'stomach cramps':
      case 'stomach discomfort':
      case 'teeth grinding':
      case 'bruxia':
      case 'bruxism':
      case 'restlessness':
      case 'temporary erectile dysfunction':
      case 'vibrating vision':
      case 'watery eyes':
      case 'nasal damage':
      case 'ear ringing':
      case 'tinnitus':
      case 'ear pressure':
      case 'dysarthria':
      case 'stomach pain':
      case 'nose bleeds':
      case 'weight gain':
      case 'weight loss':
      case 'sweating':
      case 'perspiration':
      case 'difficulty breathing':
      case 'shortness of breath':
      case 'muscle spasms':
      case 'slurred speech':
        return _parsePhysicalBodily(temp);

      case 'auditory distortion':
      case 'auditory enhancement':
      case 'auditory hallucination':
      case 'auditory hallucinations':
      case 'auditory misinterpretation':
      case 'auditory suppression':
        return _parseAuditory(temp);

      case 'spontaneous bodily sensations':
      case 'tactile enhancement':
      case 'tactile hallucination':
      case 'tactile suppression':
        return _parseTactile(temp);

      case 'cognitive disconnection':
      case 'detachment plateaus':
      case 'physical disconnection':
      case 'visual disconnection':
      case 'holes.2c spaces and voids':
      case 'structures':
        return _parseDisconnective(temp);

      case 'gustatory enhancement':
      case 'olfactory enhancement':
      case 'gustatory hallucination':
      case 'olfactory hallucination':
      case 'gustatory suppression':
      case 'olfactory suppression':
        return _parseSmellTaste(temp);

      case 'anticipatory response':
      case 'component controllability':
      case 'dosage independent intensity':
      case 'machinescapes':
      case 'memory replays':
      case 'scenarios and plots':
      case 'spontaneous physical movements':
      case 'synaesthesia':
      case 'hallucinations through all physical means':
      case 'hallucinations through all physical senses':
        return _parseMultisensory(temp);

      default:
        // print('Warning! EffectsManager::parseEffect: Unknown effect -- ' + effect);
        ++unknownEffectCount;
        return null;
    }
  }

  Effect _parseVisualEnhancements(String effect) {
    if (effects[EffectCategory.visual]![SubEffectCategory.enhancements] == null) {
      effects[EffectCategory.visual]![SubEffectCategory.enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'acuity enhancement':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'colour enhancement':
      case 'color enhancement':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'brightened colour':
      case 'brightening of colors':
      case 'brightened color':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'frame rate enhancement':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'magnification':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'pattern recognition enhancement':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'peripheral vision enhancement':
        effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.visual,
      subCategory: SubEffectCategory.enhancements,
      type: effects[EffectCategory.visual]![SubEffectCategory.enhancements]![effect],
    );
  }

  Effect _parseVisualSuppressions(String effect) {
    if (effects[EffectCategory.visual]![SubEffectCategory.suppressions] == null) {
      effects[EffectCategory.visual]![SubEffectCategory.suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'acuity suppression':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'colour suppression':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'double vision':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'frame rate suppression':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'pattern recognition suppression':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'peripheral information misinterpretation':
        effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.visual,
      subCategory: SubEffectCategory.suppressions,
      type: effects[EffectCategory.visual]![SubEffectCategory.suppressions]![effect],
    );
  }

  Effect _parseVisualDistortions(String effect) {
    if (effects[EffectCategory.visual]![SubEffectCategory.distortions] == null) {
      effects[EffectCategory.visual]![SubEffectCategory.distortions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'after images':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'brightness alteration':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'colour replacement':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'colour shifting':
      case 'color shifting':
      case 'hue shifts':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'colour tinting':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'depth perception distortions':
      case 'visual distortions':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'diffraction':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'closed/open eye visuals':
      case 'powerful closed/open eye visuals':
      case 'closed and open eye visuals':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'open eye visuals':
      case "mild oev's":
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'closed eye visuals':
      case "strong cev's":
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'drifting':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'environmental cubism':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'environmental patterning':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'environmental orbism':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'object alteration':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'perspective distortion':
      case 'radical shift in perspective and perception':
      case 'radical perspective shifting':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'recursion':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'scenery slicing':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'symmetrical texture repetition':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'texture liquidation':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'tracers':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'visual flipping':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'visual haze':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'visual stretching':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
      case 'visual snow':
        effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.visual,
      subCategory: SubEffectCategory.distortions,
      type: effects[EffectCategory.visual]![SubEffectCategory.distortions]![effect],
    );
  }

  Effect _parseVisualGeometry(String effect) {
    if (effects[EffectCategory.visual]![SubEffectCategory.geometry] == null) {
      effects[EffectCategory.visual]![SubEffectCategory.geometry] = <String, EffectType>{};
    }

    switch (effect) {
      case '8a geometry - perceived exposure to semantic concept network':
        effects[EffectCategory.visual]![SubEffectCategory.geometry]![effect] = EffectType.neutral;
        break;
      case '8b geometry - perceived exposure to inner mechanics of consciousness':
        effects[EffectCategory.visual]![SubEffectCategory.geometry]![effect] = EffectType.neutral;
        break;
      case 'geometry':
        effects[EffectCategory.visual]![SubEffectCategory.geometry]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.visual,
      subCategory: SubEffectCategory.geometry,
      type: effects[EffectCategory.visual]![SubEffectCategory.geometry]![effect],
    );
  }

  Effect _parseVisualHallucinatory(String effect) {
    if (effects[EffectCategory.visual]![SubEffectCategory.hallucinatory] == null) {
      effects[EffectCategory.visual]![SubEffectCategory.hallucinatory] = <String, EffectType>{};
    }

    switch (effect) {
      case 'autonomous entity':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'external hallucination':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'internal hallucination':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'object activation':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'perspective hallucination':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'settings, sceneries, and landscapes':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'shadow people':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.negative;
        break;
      case 'transformations':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.neutral;
        break;
      case 'unspeakable horrors':
        effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect] = EffectType.negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.visual,
      subCategory: SubEffectCategory.hallucinatory,
      type: effects[EffectCategory.visual]![SubEffectCategory.hallucinatory]![effect],
    );
  }

  Effect _parseCognitiveEnhancements(String effect) {
    if (effects[EffectCategory.cognitive]![SubEffectCategory.enhancements] == null) {
      effects[EffectCategory.cognitive]![SubEffectCategory.enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'analysis enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'anxiety':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.negative;
        break;
      case 'creativity':
      case 'creativity enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'dream potentiation':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'hyper-inflated ego':
      case 'ego inflation':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'mood lift':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'ego softening':
      case 'ego-softening':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'emotion enhancement':
      case 'moodiness':
      case 'heightend emotions':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'empathy, affection, and sociability enhancement':
      case 'empathy, affection and sociability enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'empathy':
      case 'feelings of empathy':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'increased sociability':
      case 'sociability':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'excessive talking':
      case 'increased desire to talk':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'insight':
      case 'feelings of insight':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'increased focus':
      case 'focus enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'immersion enhancement':
      case 'immersive experience':
      case 'cognitive enhancement':
      case 'increase in cognitive abilities':
      case 'sensory enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'increased music appreciation':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'increased sense of humor':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'irritability':
      case 'increase in irritability':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.negative;
        break;
      case 'agressiveness':
      case 'aggressiveness':
      case 'rage':
      case 'aggression':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.negative;
        break;
      case 'memory enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'motivation enhancement':
      case 'increased motivation':
      case 'incresed motivation':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'novelty enhancement':
      case 'a sense of childlike wonder':
      case 'sense of wonder':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'personal meaning enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'suggestibility enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'thought acceleration':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'racing thoughts':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.negative;
        break;
      case 'thought connectivity':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'thought organization':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'wakefulness':
      case 'increased alertness':
      case 'decreased need for sleep':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'elevated mood':
        effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.cognitive,
      subCategory: SubEffectCategory.enhancements,
      type: effects[EffectCategory.cognitive]![SubEffectCategory.enhancements]![effect],
    );
  }

  Effect _parseCognitiveSuppressions(String effect) {
    if (effects[EffectCategory.cognitive]![SubEffectCategory.suppressions] == null) {
      effects[EffectCategory.cognitive]![SubEffectCategory.suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'addiction suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'amnesia':
      case 'amnesic':
      case 'blackouts':
      case 'memory loss':
      case 'blackout potential':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'analysis suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'anxiety suppression':
      case 'anxiety supression':
      case 'anxiolytic':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'cognitive fatigue':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'fatigue':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'confusion':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'creativity suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'delirium':
      case 'delirium tremens':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'disinhibition':
      case 'loss of inhibition':
      case 'lowered inhibitions':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'dream suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'emotion suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'focus suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'language suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'memory suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'motivation suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'personal bias suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'sleepiness':
      case 'tiredness':
      case 'hypnotic':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'lethargy':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'suggestibility suppression':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'thought deceleration':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'thought disorganization':
        effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.cognitive,
      subCategory: SubEffectCategory.suppressions,
      type: effects[EffectCategory.cognitive]![SubEffectCategory.suppressions]![effect],
    );
  }

  Effect _parseCognitiveNovel(String effect) {
    if (effects[EffectCategory.cognitive]![SubEffectCategory.novel] == null) {
      effects[EffectCategory.cognitive]![SubEffectCategory.novel] = <String, EffectType>{};
    }

    switch (effect) {
      case 'autonomous voice communication':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'cognitive dysphoria':
      case 'dysphoria':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.negative;
        break;
      case 'cognitive euphoria':
      case 'euphoria':
      case 'a strong sense of wellbeing':
      case 'euphoric':
      case 'feelings of euphoria':
      case 'with euphoria':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.positive;
        break;
      case 'compulsive redosing':
      case 'compulsion to redose':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.negative;
        break;
      case 'conceptual thinking':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'enhancement and suppression cycles':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'glossolalia':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'multiple thought streams':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'simultaneous emotions':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'spatial disorientation':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'thought loop':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.negative;
        break;
      case 'time distortion':
      case 'change in perception of time':
      case 'changes in perception of time':
      case 'change in perception of  time':
      case 'loss of time':
      case 'changes in perception-of-time':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'change in perception':
      case 'altered perception':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'general change in consciousness':
      case 'change in consciousness':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
      case 'dissociation':
        effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.cognitive,
      subCategory: SubEffectCategory.novel,
      type: effects[EffectCategory.cognitive]![SubEffectCategory.novel]![effect],
    );
  }

  Effect _parseCognitivePsychological(String effect) {
    if (effects[EffectCategory.cognitive]![SubEffectCategory.psychological] == null) {
      effects[EffectCategory.cognitive]![SubEffectCategory.psychological] = <String, EffectType>{};
    }

    switch (effect) {
      case 'catharsis':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.positive;
        break;
      case 'delusions':
      case 'delusion':
      case 'delusions of sobriety':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'depersonalization':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'derealization':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'depression':
      case 'apathy':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'déjà vu':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'ego replacement':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'feelings of impending doom':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'introspection':
      case 'introspective insight':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'mania':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'mindfulness':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.positive;
        break;
      case 'panic attack':
      case 'panic':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'overwhelming fear':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'fear':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'paranoia':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'personality regression':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'personality changes':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.neutral;
        break;
      case 'psychosis':
      case 'stimulant psychosis':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'rejuvenation':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.positive;
        break;
      case 'suicidal ideation':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'sleep paralysis':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'insomnia':
      case 'distrubed sleep patterns':
      case 'disturbed sleep patterns':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.negative;
        break;
      case 'relaxation':
        effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect] = EffectType.positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.cognitive,
      subCategory: SubEffectCategory.psychological,
      type: effects[EffectCategory.cognitive]![SubEffectCategory.psychological]![effect],
    );
  }

  Effect _parseCognitiveTranspersonal(String effect) {
    if (effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal] == null) {
      effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal] = <String, EffectType>{};
    }

    switch (effect) {
      case 'existential self-realization':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'profound life-changing spiritual experiences':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.positive;
        break;
      case 'identity alteration':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'perceived exposure to inner mechanics of consciousness':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'perception of eternalism':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'perception of interdependent opposites':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'perception of predeterminism':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'perception of self-design':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.neutral;
        break;
      case 'spirituality enhancement':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.positive;
        break;
      case 'unity and interconnectedness':
      case 'a sense of connectedness with people and the environment around you':
      case 'a sense of conectedness with the world around you':
        effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect] = EffectType.positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.cognitive,
      subCategory: SubEffectCategory.transpersonal,
      type: effects[EffectCategory.cognitive]![SubEffectCategory.transpersonal]![effect],
    );
  }

  Effect _parsePhysicalEnhancements(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.enhancements] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'appetite enhancement':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'bodily control enhancement':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'increased libido':
      case 'increase sexuality':
      case 'increased sexuality':
      case 'sexual enhancement':
      case 'increased sex drive':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.neutral;
        break;
      case 'stamina enhancement':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'enhanced tactile sensation':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'anti-inflammation':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
      case 'stimulation':
      case 'mental/physical stimulation':
      case 'increased energy/alertness':
      case 'mental and physical stimulation':
      case 'stimulation (mental and physical)':
      case 'stimulating high':
        effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect] = EffectType.positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.enhancements,
      type: effects[EffectCategory.physical]![SubEffectCategory.enhancements]![effect],
    );
  }

  Effect _parsePhysicalSuppressions(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.suppressions] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'appetite suppression':
      case 'appetite suppressant':
      case 'decreased appetite':
      case 'reduced appetite':
      case 'loss of apetite':
      case 'loss of appettite':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'cough suppression':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'decreased libido':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'motor control loss':
      case 'dystaxia':
      case 'loss of motor skills':
      case 'inability to control muscles':
      case 'motor skill impairment':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'nausea suppression':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'orgasm suppression':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.negative;
        break;
      case 'pain relief':
      case 'analgesia':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'sedation':
      case 'sedative':
      case 'sedative effects':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'seizure suppression':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
      case 'drowsiness':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.neutral;
        break;
      case 'feelings of relaxation':
        effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect] = EffectType.positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.suppressions,
      type: effects[EffectCategory.physical]![SubEffectCategory.suppressions]![effect],
    );
  }

  Effect _parsePhysicalAlterations(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.alterations] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.alterations] = <String, EffectType>{};
    }

    switch (effect) {
      case 'body odor alteration':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'bronchodilation':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.positive;
        break;
      case 'changes in felt bodily form':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'changes in felt gravity':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'excessive yawning':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'laughter fits':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.positive;
        break;
      case 'giggling':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.positive;
        break;
      case 'mouth numbing':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'muscle relaxation':
      case 'relaxant':
      case 'muscle relaxant':
      case 'skeletal muscle relaxant':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.positive;
        break;
      case 'perception of bodily heaviness':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'perception of bodily lightness':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'physical autonomy':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'physical euphoria':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.positive;
        break;
      case 'pupil constriction':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'pupil dilation':
      case 'pupil-dilation':
      case 'pupil dialation':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'gait alteration':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'rapid breathing':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
      case 'powerful rushing of sensation':
        effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.alterations,
      type: effects[EffectCategory.physical]![SubEffectCategory.alterations]![effect],
    );
  }

  Effect _parsePhysicalCardiovascular(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.cardiovascular] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.cardiovascular] = <String, EffectType>{};
    }

    switch (effect) {
      case 'abnormal heartbeat':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.negative;
        break;
      case 'decreased heart rate':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'decreased blood pressure':
      case 'low blood pressure':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'increased blood pressure':
      case 'hypertension':
      case 'high blood pressure':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'increased heart rate':
      case 'elevated heart rate':
      case 'tachychardia':
      case 'elevated heartrate':
      case 'raised heartrate':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'vasoconstriction':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'vasodilation':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.neutral;
        break;
      case 'heartburn':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.negative;
        break;
      case 'reflex syncope':
        effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect] = EffectType.negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.cardiovascular,
      type: effects[EffectCategory.physical]![SubEffectCategory.cardiovascular]![effect],
    );
  }

  Effect _parsePhysicalCerebrovascular(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular] = <String, EffectType>{};
    }

    switch (effect) {
      case 'brain zaps':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.negative;
        break;
      case 'dizziness':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.negative;
        break;
      case 'headache':
      case 'headaches':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.negative;
        break;
      case 'increased bodily temperature':
      case 'increased body temperature':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.neutral;
        break;
      case 'seizure':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.negative;
        break;
      case 'temperature regulation suppression':
      case 'sweating/chills':
        effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.cerebrovascular,
      type: effects[EffectCategory.physical]![SubEffectCategory.cerebrovascular]![effect],
    );
  }

  Effect _parsePhysicalBodily(String effect) {
    if (effects[EffectCategory.physical]![SubEffectCategory.bodily] == null) {
      effects[EffectCategory.physical]![SubEffectCategory.bodily] = <String, EffectType>{};
    }

    switch (effect) {
      case 'back pain':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'bodily pressures':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'constipation':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'dehydration':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'diarrhea':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'difficulty urinating':
      case 'urinary retention':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'dry mouth':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'frequent urination':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'increased phlegm production':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'increased perspiration':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'increased salivation':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'itchiness':
      case 'itching':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'muscle cramps':
      case 'muscle cramp':
      case 'muscle contractions':
      case 'muscle spasms':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'muscle tension':
      case 'muscle-tension':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'muscle twitching':
      case 'muscle stiffness':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'tremors':
      case 'muscle tremors':
      case 'body tremors':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'nausea':
      case 'nausea (particularly at high doses)':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'vomiting':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'optical sliding':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'photophobia':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'physical fatigue':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'respiratory depression':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'restless legs':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'restlessness':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'runny nose':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'salivation':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'skin flushing':
      case 'flushed skin':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'stomach bloating':
      case 'stomach pain':
      case 'stomach discomfort':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'stomach cramp':
      case 'stomach cramps':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'teeth grinding':
      case 'bruxia':
      case 'bruxism':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'temporary erectile dysfunction':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'vibrating vision':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'watery eyes':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'nasal damage':
      case 'nose bleeds':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'ear ringing':
      case 'tinnitus':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'ear pressure':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'dysarthria':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'convulsions':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'anticonvulsant':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.positive;
        break;
      case 'weight gain':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'weight loss':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'sweating':
      case 'perspiration':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.neutral;
        break;
      case 'shortness of breath':
      case 'difficulty breathing':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
      case 'slurred speech':
        effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect] = EffectType.negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.physical,
      subCategory: SubEffectCategory.bodily,
      type: effects[EffectCategory.physical]![SubEffectCategory.bodily]![effect],
    );
  }

  Effect _parseAuditory(String effect) {
    if (effects[EffectCategory.auditory]![SubEffectCategory.misc] == null) {
      effects[EffectCategory.auditory]![SubEffectCategory.misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'auditory distortion':
        effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'auditory enhancement':
        effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'auditory hallucinations':
      case 'auditory hallucination':
        effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'auditory misinterpretation':
        effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'auditory suppression':
        effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.auditory,
      subCategory: SubEffectCategory.misc,
      type: effects[EffectCategory.auditory]![SubEffectCategory.misc]![effect],
    );
  }

  Effect _parseTactile(String effect) {
    if (effects[EffectCategory.tactile]![SubEffectCategory.misc] == null) {
      effects[EffectCategory.tactile]![SubEffectCategory.misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'spontaneous bodily sensations':
        effects[EffectCategory.tactile]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'tactile enhancement':
        effects[EffectCategory.tactile]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'tactile hallucination':
        effects[EffectCategory.tactile]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'tactile suppression':
        effects[EffectCategory.tactile]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.tactile,
      subCategory: SubEffectCategory.misc,
      type: effects[EffectCategory.tactile]![SubEffectCategory.misc]![effect],
    );
  }

  Effect _parseDisconnective(String effect) {
    if (effects[EffectCategory.disconnective]![SubEffectCategory.misc] == null) {
      effects[EffectCategory.disconnective]![SubEffectCategory.misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'cognitive disconnection':
        effects[EffectCategory.disconnective]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'detachment plateaus':
        effects[EffectCategory.disconnective]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'physical disconnection':
        effects[EffectCategory.disconnective]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'visual disconnection':
      case 'holes.2c spaces and voids':
      case 'structures':
        effects[EffectCategory.disconnective]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.disconnective,
      subCategory: SubEffectCategory.misc,
      type: effects[EffectCategory.disconnective]![SubEffectCategory.misc]![effect],
    );
  }

  Effect _parseSmellTaste(String effect) {
    if (effects[EffectCategory.smellTaste]![SubEffectCategory.misc] == null) {
      effects[EffectCategory.smellTaste]![SubEffectCategory.misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'gustatory enhancement':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'olfactory enhancement':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'gustatory hallucination':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'olfactory hallucination':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'gustatory suppression':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'olfactory suppression':
        effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.smellTaste,
      subCategory: SubEffectCategory.misc,
      type: effects[EffectCategory.smellTaste]![SubEffectCategory.misc]![effect],
    );
  }

  Effect _parseMultisensory(String effect) {
    if (effects[EffectCategory.multisensory]![SubEffectCategory.misc] == null) {
      effects[EffectCategory.multisensory]![SubEffectCategory.misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'anticipatory response':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'component controllability':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'dosage independent intensity':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'machinescapes':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'memory replays':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'scenarios and plots':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'spontaneous physical movements':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
      case 'synaesthesia':
      case 'hallucinations through all physical means':
      case 'hallucinations through all physical senses':
        effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect] = EffectType.neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.multisensory,
      subCategory: SubEffectCategory.misc,
      type: effects[EffectCategory.multisensory]![SubEffectCategory.misc]![effect],
    );
  }
}
