import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imperium/database/models/effect.dart';
import 'package:imperium/database/models/enums/effect_category.dart';
import 'package:imperium/database/models/enums/effect_type.dart';
import 'package:imperium/database/models/enums/sub_effect_category.dart';
import 'package:imperium/utils/string_manipulation.dart';

class EffectsManager {
  static final EffectsManager _effectsManager = EffectsManager._internal();

  factory EffectsManager() => _effectsManager;
  EffectsManager._internal();

  Map<EffectCategory, Map<SubEffectCategory, Map<String, EffectType>>> effects = <EffectCategory, Map<SubEffectCategory, Map<String, EffectType>>>{};
  int unknownEffectCount = 0;

  bool _effectsInit = false;

  void initEffects() {
    effects[EffectCategory.Visual] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Cognitive] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Physical] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Auditory] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Disconnective] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Tactile] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.SmellTaste] = <SubEffectCategory, Map<String, EffectType>>{};
    effects[EffectCategory.Multisensory] = <SubEffectCategory, Map<String, EffectType>>{};
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
    if (temp.contains('#')) temp = temp.substring(findCharPos(temp, '#', false) + 1);
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
    if (effects[EffectCategory.Visual]![SubEffectCategory.Enhancements] == null) {
      effects[EffectCategory.Visual]![SubEffectCategory.Enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'acuity enhancement':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'colour enhancement':
      case 'color enhancement':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'brightened colour':
      case 'brightening of colors':
      case 'brightened color':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'frame rate enhancement':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'magnification':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'pattern recognition enhancement':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'peripheral vision enhancement':
        effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Visual,
      subCategory: SubEffectCategory.Enhancements,
      type: effects[EffectCategory.Visual]![SubEffectCategory.Enhancements]![effect],
    );
  }

  Effect _parseVisualSuppressions(String effect) {
    if (effects[EffectCategory.Visual]![SubEffectCategory.Suppressions] == null) {
      effects[EffectCategory.Visual]![SubEffectCategory.Suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'acuity suppression':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'colour suppression':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'double vision':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'frame rate suppression':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'pattern recognition suppression':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'peripheral information misinterpretation':
        effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Visual,
      subCategory: SubEffectCategory.Suppressions,
      type: effects[EffectCategory.Visual]![SubEffectCategory.Suppressions]![effect],
    );
  }

  Effect _parseVisualDistortions(String effect) {
    if (effects[EffectCategory.Visual]![SubEffectCategory.Distortions] == null) {
      effects[EffectCategory.Visual]![SubEffectCategory.Distortions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'after images':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'brightness alteration':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'colour replacement':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'colour shifting':
      case 'color shifting':
      case 'hue shifts':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'colour tinting':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'depth perception distortions':
      case 'visual distortions':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'diffraction':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'closed/open eye visuals':
      case 'powerful closed/open eye visuals':
      case 'closed and open eye visuals':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'open eye visuals':
      case "mild oev's":
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'closed eye visuals':
      case "strong cev's":
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'drifting':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'environmental cubism':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'environmental patterning':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'environmental orbism':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'object alteration':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'perspective distortion':
      case 'radical shift in perspective and perception':
      case 'radical perspective shifting':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'recursion':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'scenery slicing':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'symmetrical texture repetition':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'texture liquidation':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'tracers':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'visual flipping':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'visual haze':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'visual stretching':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
      case 'visual snow':
        effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Visual,
      subCategory: SubEffectCategory.Distortions,
      type: effects[EffectCategory.Visual]![SubEffectCategory.Distortions]![effect],
    );
  }

  Effect _parseVisualGeometry(String effect) {
    if (effects[EffectCategory.Visual]![SubEffectCategory.Geometry] == null) {
      effects[EffectCategory.Visual]![SubEffectCategory.Geometry] = <String, EffectType>{};
    }

    switch (effect) {
      case '8a geometry - perceived exposure to semantic concept network':
        effects[EffectCategory.Visual]![SubEffectCategory.Geometry]![effect] = EffectType.Neutral;
        break;
      case '8b geometry - perceived exposure to inner mechanics of consciousness':
        effects[EffectCategory.Visual]![SubEffectCategory.Geometry]![effect] = EffectType.Neutral;
        break;
      case 'geometry':
        effects[EffectCategory.Visual]![SubEffectCategory.Geometry]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Visual,
      subCategory: SubEffectCategory.Geometry,
      type: effects[EffectCategory.Visual]![SubEffectCategory.Geometry]![effect],
    );
  }

  Effect _parseVisualHallucinatory(String effect) {
    if (effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory] == null) {
      effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory] = <String, EffectType>{};
    }

    switch (effect) {
      case 'autonomous entity':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'external hallucination':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'internal hallucination':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'object activation':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'perspective hallucination':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'settings, sceneries, and landscapes':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'shadow people':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Negative;
        break;
      case 'transformations':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Neutral;
        break;
      case 'unspeakable horrors':
        effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect] = EffectType.Negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Visual,
      subCategory: SubEffectCategory.Hallucinatory,
      type: effects[EffectCategory.Visual]![SubEffectCategory.Hallucinatory]![effect],
    );
  }

  Effect _parseCognitiveEnhancements(String effect) {
    if (effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements] == null) {
      effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'analysis enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'anxiety':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Negative;
        break;
      case 'creativity':
      case 'creativity enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'dream potentiation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'hyper-inflated ego':
      case 'ego inflation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'mood lift':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'ego softening':
      case 'ego-softening':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'emotion enhancement':
      case 'moodiness':
      case 'heightend emotions':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'empathy, affection, and sociability enhancement':
      case 'empathy, affection and sociability enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'empathy':
      case 'feelings of empathy':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'increased sociability':
      case 'sociability':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'excessive talking':
      case 'increased desire to talk':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'insight':
      case 'feelings of insight':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'increased focus':
      case 'focus enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'immersion enhancement':
      case 'immersive experience':
      case 'cognitive enhancement':
      case 'increase in cognitive abilities':
      case 'sensory enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'increased music appreciation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'increased sense of humor':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'irritability':
      case 'increase in irritability':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Negative;
        break;
      case 'agressiveness':
      case 'aggressiveness':
      case 'rage':
      case 'aggression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Negative;
        break;
      case 'memory enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'motivation enhancement':
      case 'increased motivation':
      case 'incresed motivation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'novelty enhancement':
      case 'a sense of childlike wonder':
      case 'sense of wonder':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'personal meaning enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'suggestibility enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'thought acceleration':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'racing thoughts':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Negative;
        break;
      case 'thought connectivity':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'thought organization':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'wakefulness':
      case 'increased alertness':
      case 'decreased need for sleep':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'elevated mood':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Cognitive,
      subCategory: SubEffectCategory.Enhancements,
      type: effects[EffectCategory.Cognitive]![SubEffectCategory.Enhancements]![effect],
    );
  }

  Effect _parseCognitiveSuppressions(String effect) {
    if (effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions] == null) {
      effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'addiction suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'amnesia':
      case 'amnesic':
      case 'blackouts':
      case 'memory loss':
      case 'blackout potential':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'analysis suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'anxiety suppression':
      case 'anxiety supression':
      case 'anxiolytic':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'cognitive fatigue':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'fatigue':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'confusion':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'creativity suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'delirium':
      case 'delirium tremens':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'disinhibition':
      case 'loss of inhibition':
      case 'lowered inhibitions':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'dream suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'emotion suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'focus suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'language suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'memory suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'motivation suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'personal bias suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'sleepiness':
      case 'tiredness':
      case 'hypnotic':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'lethargy':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'suggestibility suppression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'thought deceleration':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'thought disorganization':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Cognitive,
      subCategory: SubEffectCategory.Suppressions,
      type: effects[EffectCategory.Cognitive]![SubEffectCategory.Suppressions]![effect],
    );
  }

  Effect _parseCognitiveNovel(String effect) {
    if (effects[EffectCategory.Cognitive]![SubEffectCategory.Novel] == null) {
      effects[EffectCategory.Cognitive]![SubEffectCategory.Novel] = <String, EffectType>{};
    }

    switch (effect) {
      case 'autonomous voice communication':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'cognitive dysphoria':
      case 'dysphoria':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Negative;
        break;
      case 'cognitive euphoria':
      case 'euphoria':
      case 'a strong sense of wellbeing':
      case 'euphoric':
      case 'feelings of euphoria':
      case 'with euphoria':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Positive;
        break;
      case 'compulsive redosing':
      case 'compulsion to redose':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Negative;
        break;
      case 'conceptual thinking':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'enhancement and suppression cycles':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'glossolalia':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'multiple thought streams':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'simultaneous emotions':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'spatial disorientation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'thought loop':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Negative;
        break;
      case 'time distortion':
      case 'change in perception of time':
      case 'changes in perception of time':
      case 'change in perception of  time':
      case 'loss of time':
      case 'changes in perception-of-time':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'change in perception':
      case 'altered perception':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'general change in consciousness':
      case 'change in consciousness':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
      case 'dissociation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Cognitive,
      subCategory: SubEffectCategory.Novel,
      type: effects[EffectCategory.Cognitive]![SubEffectCategory.Novel]![effect],
    );
  }

  Effect _parseCognitivePsychological(String effect) {
    if (effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological] == null) {
      effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological] = <String, EffectType>{};
    }

    switch (effect) {
      case 'catharsis':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Positive;
        break;
      case 'delusions':
      case 'delusion':
      case 'delusions of sobriety':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'depersonalization':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'derealization':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'depression':
      case 'apathy':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'déjà vu':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'ego replacement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'feelings of impending doom':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'introspection':
      case 'introspective insight':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'mania':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'mindfulness':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Positive;
        break;
      case 'panic attack':
      case 'panic':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'overwhelming fear':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'fear':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'paranoia':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'personality regression':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'personality changes':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Neutral;
        break;
      case 'psychosis':
      case 'stimulant psychosis':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'rejuvenation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Positive;
        break;
      case 'suicidal ideation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'sleep paralysis':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'insomnia':
      case 'distrubed sleep patterns':
      case 'disturbed sleep patterns':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Negative;
        break;
      case 'relaxation':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect] = EffectType.Positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Cognitive,
      subCategory: SubEffectCategory.Psychological,
      type: effects[EffectCategory.Cognitive]![SubEffectCategory.Psychological]![effect],
    );
  }

  Effect _parseCognitiveTranspersonal(String effect) {
    if (effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal] == null) {
      effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal] = <String, EffectType>{};
    }

    switch (effect) {
      case 'existential self-realization':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'profound life-changing spiritual experiences':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Positive;
        break;
      case 'identity alteration':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'perceived exposure to inner mechanics of consciousness':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'perception of eternalism':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'perception of interdependent opposites':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'perception of predeterminism':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'perception of self-design':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Neutral;
        break;
      case 'spirituality enhancement':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Positive;
        break;
      case 'unity and interconnectedness':
      case 'a sense of connectedness with people and the environment around you':
      case 'a sense of conectedness with the world around you':
        effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect] = EffectType.Positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Cognitive,
      subCategory: SubEffectCategory.Transpersonal,
      type: effects[EffectCategory.Cognitive]![SubEffectCategory.Transpersonal]![effect],
    );
  }

  Effect _parsePhysicalEnhancements(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Enhancements] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Enhancements] = <String, EffectType>{};
    }

    switch (effect) {
      case 'appetite enhancement':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'bodily control enhancement':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'increased libido':
      case 'increase sexuality':
      case 'increased sexuality':
      case 'sexual enhancement':
      case 'increased sex drive':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Neutral;
        break;
      case 'stamina enhancement':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'enhanced tactile sensation':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'anti-inflammation':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
      case 'stimulation':
      case 'mental/physical stimulation':
      case 'increased energy/alertness':
      case 'mental and physical stimulation':
      case 'stimulation (mental and physical)':
      case 'stimulating high':
        effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect] = EffectType.Positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Enhancements,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Enhancements]![effect],
    );
  }

  Effect _parsePhysicalSuppressions(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Suppressions] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Suppressions] = <String, EffectType>{};
    }

    switch (effect) {
      case 'appetite suppression':
      case 'appetite suppressant':
      case 'decreased appetite':
      case 'reduced appetite':
      case 'loss of apetite':
      case 'loss of appettite':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'cough suppression':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'decreased libido':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'motor control loss':
      case 'dystaxia':
      case 'loss of motor skills':
      case 'inability to control muscles':
      case 'motor skill impairment':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'nausea suppression':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'orgasm suppression':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Negative;
        break;
      case 'pain relief':
      case 'analgesia':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'sedation':
      case 'sedative':
      case 'sedative effects':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'seizure suppression':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
      case 'drowsiness':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Neutral;
        break;
      case 'feelings of relaxation':
        effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect] = EffectType.Positive;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Suppressions,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Suppressions]![effect],
    );
  }

  Effect _parsePhysicalAlterations(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Alterations] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Alterations] = <String, EffectType>{};
    }

    switch (effect) {
      case 'body odor alteration':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'bronchodilation':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Positive;
        break;
      case 'changes in felt bodily form':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'changes in felt gravity':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'excessive yawning':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'laughter fits':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Positive;
        break;
      case 'giggling':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Positive;
        break;
      case 'mouth numbing':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'muscle relaxation':
      case 'relaxant':
      case 'muscle relaxant':
      case 'skeletal muscle relaxant':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Positive;
        break;
      case 'perception of bodily heaviness':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'perception of bodily lightness':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'physical autonomy':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'physical euphoria':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Positive;
        break;
      case 'pupil constriction':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'pupil dilation':
      case 'pupil-dilation':
      case 'pupil dialation':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'gait alteration':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'rapid breathing':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
      case 'powerful rushing of sensation':
        effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Alterations,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Alterations]![effect],
    );
  }

  Effect _parsePhysicalCardiovascular(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular] = <String, EffectType>{};
    }

    switch (effect) {
      case 'abnormal heartbeat':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Negative;
        break;
      case 'decreased heart rate':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'decreased blood pressure':
      case 'low blood pressure':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'increased blood pressure':
      case 'hypertension':
      case 'high blood pressure':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'increased heart rate':
      case 'elevated heart rate':
      case 'tachychardia':
      case 'elevated heartrate':
      case 'raised heartrate':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'vasoconstriction':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'vasodilation':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Neutral;
        break;
      case 'heartburn':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Negative;
        break;
      case 'reflex syncope':
        effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect] = EffectType.Negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Cardiovascular,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Cardiovascular]![effect],
    );
  }

  Effect _parsePhysicalCerebrovascular(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular] = <String, EffectType>{};
    }

    switch (effect) {
      case 'brain zaps':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Negative;
        break;
      case 'dizziness':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Negative;
        break;
      case 'headache':
      case 'headaches':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Negative;
        break;
      case 'increased bodily temperature':
      case 'increased body temperature':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Neutral;
        break;
      case 'seizure':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Negative;
        break;
      case 'temperature regulation suppression':
      case 'sweating/chills':
        effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Cerebrovascular,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Cerebrovascular]![effect],
    );
  }

  Effect _parsePhysicalBodily(String effect) {
    if (effects[EffectCategory.Physical]![SubEffectCategory.Bodily] == null) {
      effects[EffectCategory.Physical]![SubEffectCategory.Bodily] = <String, EffectType>{};
    }

    switch (effect) {
      case 'back pain':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'bodily pressures':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'constipation':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'dehydration':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'diarrhea':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'difficulty urinating':
      case 'urinary retention':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'dry mouth':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'frequent urination':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'increased phlegm production':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'increased perspiration':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'increased salivation':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'itchiness':
      case 'itching':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'muscle cramps':
      case 'muscle cramp':
      case 'muscle contractions':
      case 'muscle spasms':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'muscle tension':
      case 'muscle-tension':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'muscle twitching':
      case 'muscle stiffness':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'tremors':
      case 'muscle tremors':
      case 'body tremors':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'nausea':
      case 'nausea (particularly at high doses)':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'vomiting':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'optical sliding':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'photophobia':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'physical fatigue':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'respiratory depression':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'restless legs':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'restlessness':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'runny nose':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'salivation':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'skin flushing':
      case 'flushed skin':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'stomach bloating':
      case 'stomach pain':
      case 'stomach discomfort':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'stomach cramp':
      case 'stomach cramps':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'teeth grinding':
      case 'bruxia':
      case 'bruxism':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'temporary erectile dysfunction':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'vibrating vision':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'watery eyes':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'nasal damage':
      case 'nose bleeds':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'ear ringing':
      case 'tinnitus':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'ear pressure':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'dysarthria':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'convulsions':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'anticonvulsant':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Positive;
        break;
      case 'weight gain':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'weight loss':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'sweating':
      case 'perspiration':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Neutral;
        break;
      case 'shortness of breath':
      case 'difficulty breathing':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
      case 'slurred speech':
        effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect] = EffectType.Negative;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Physical,
      subCategory: SubEffectCategory.Bodily,
      type: effects[EffectCategory.Physical]![SubEffectCategory.Bodily]![effect],
    );
  }

  Effect _parseAuditory(String effect) {
    if (effects[EffectCategory.Auditory]![SubEffectCategory.Misc] == null) {
      effects[EffectCategory.Auditory]![SubEffectCategory.Misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'auditory distortion':
        effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'auditory enhancement':
        effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'auditory hallucinations':
      case 'auditory hallucination':
        effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'auditory misinterpretation':
        effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'auditory suppression':
        effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Auditory,
      subCategory: SubEffectCategory.Misc,
      type: effects[EffectCategory.Auditory]![SubEffectCategory.Misc]![effect],
    );
  }

  Effect _parseTactile(String effect) {
    if (effects[EffectCategory.Tactile]![SubEffectCategory.Misc] == null) {
      effects[EffectCategory.Tactile]![SubEffectCategory.Misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'spontaneous bodily sensations':
        effects[EffectCategory.Tactile]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'tactile enhancement':
        effects[EffectCategory.Tactile]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'tactile hallucination':
        effects[EffectCategory.Tactile]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'tactile suppression':
        effects[EffectCategory.Tactile]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Tactile,
      subCategory: SubEffectCategory.Misc,
      type: effects[EffectCategory.Tactile]![SubEffectCategory.Misc]![effect],
    );
  }

  Effect _parseDisconnective(String effect) {
    if (effects[EffectCategory.Disconnective]![SubEffectCategory.Misc] == null) {
      effects[EffectCategory.Disconnective]![SubEffectCategory.Misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'cognitive disconnection':
        effects[EffectCategory.Disconnective]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'detachment plateaus':
        effects[EffectCategory.Disconnective]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'physical disconnection':
        effects[EffectCategory.Disconnective]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'visual disconnection':
      case 'holes.2c spaces and voids':
      case 'structures':
        effects[EffectCategory.Disconnective]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Disconnective,
      subCategory: SubEffectCategory.Misc,
      type: effects[EffectCategory.Disconnective]![SubEffectCategory.Misc]![effect],
    );
  }

  Effect _parseSmellTaste(String effect) {
    if (effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc] == null) {
      effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'gustatory enhancement':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'olfactory enhancement':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'gustatory hallucination':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'olfactory hallucination':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'gustatory suppression':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'olfactory suppression':
        effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.SmellTaste,
      subCategory: SubEffectCategory.Misc,
      type: effects[EffectCategory.SmellTaste]![SubEffectCategory.Misc]![effect],
    );
  }

  Effect _parseMultisensory(String effect) {
    if (effects[EffectCategory.Multisensory]![SubEffectCategory.Misc] == null) {
      effects[EffectCategory.Multisensory]![SubEffectCategory.Misc] = <String, EffectType>{};
    }

    switch (effect) {
      case 'anticipatory response':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'component controllability':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'dosage independent intensity':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'machinescapes':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'memory replays':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'scenarios and plots':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'spontaneous physical movements':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
      case 'synaesthesia':
      case 'hallucinations through all physical means':
      case 'hallucinations through all physical senses':
        effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect] = EffectType.Neutral;
        break;
    }

    return Effect(
      name: effect,
      category: EffectCategory.Multisensory,
      subCategory: SubEffectCategory.Misc,
      type: effects[EffectCategory.Multisensory]![SubEffectCategory.Misc]![effect],
    );
  }
}
