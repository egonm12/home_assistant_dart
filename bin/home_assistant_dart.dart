import 'package:home_assistant_dart/home_assistant_dart.dart';
import 'constants.dart';

void main(List<String> arguments) async {
  final remote = HomeAssistantDart(token: authToken, baseUrl: baseUrl);

  await remote.setState('light.hue_ambiance_werkkamer', 'on');
  await remote.callService('light', 'toggle', {'entity_id': 'light.hue_go_1'});
  final state = await remote.getState('light.hue_go_1');
  print(state);
}
