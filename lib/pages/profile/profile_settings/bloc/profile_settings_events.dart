abstract class ProfileSettingsEvents {
  const ProfileSettingsEvents();
}

class TriggerProfileSettings extends ProfileSettingsEvents {
  final int index;
  const TriggerProfileSettings(this.index) : super();
}
