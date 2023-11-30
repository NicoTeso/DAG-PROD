trigger NBK_VoiceCallTrigger on VoiceCall (before insert, before update, after insert, after update) {    
    new NBK_VoiceCallTriggerController().run();
}