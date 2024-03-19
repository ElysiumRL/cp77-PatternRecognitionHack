import CustomHackingSystem.Hacks.PatternRecognition.*
import PatternRecognitionHack.ModSettings.*

//left for debug purposes only
@wrapMethod(gameuiInGameMenuGameController)
private final func RegisterInputListenersForPlayer(playerPuppet: ref<GameObject>) -> Void
{
	wrappedMethod(playerPuppet);
	
	playerPuppet.RegisterInputListener(this, n"Choice2_Hold");
}

//left for debug purposes only
@wrapMethod(gameuiInGameMenuGameController)
protected cb func OnAction(action: ListenerAction, consumer: ListenerActionConsumer) -> Bool
{
	wrappedMethod(action, consumer);

	let actionName: CName = ListenerAction.GetName(action);
	let actionType: gameinputActionType = ListenerAction.GetType(action);

	if Equals(actionName, n"Choice2_Hold") && Equals(actionType, gameinputActionType.BUTTON_HOLD_COMPLETE)
	{
		let player: ref<PlayerPuppet> = this.GetPlayerControlledObject() as PlayerPuppet;
		let blackboard: ref<IBlackboard> = player.GetPlayerStateMachineBlackboard();
		let state: gamePSMVehicle = IntEnum(blackboard.GetInt(GetAllBlackboardDefs().PlayerStateMachine.Vehicle));

		if Equals(state, gamePSMVehicle.Default)
		{
			let minigameSettings:ref<PatternRecognitionHackSettings> = PatternRecognitionHackSettings.Default();
			minigameSettings.letterType = EPatternRecognitionHackLetterType.Alphabetical;
			PatternRecognitionHack.StartMinigame(minigameSettings, this.GetPlayerControlledObject().GetGame());
			ListenerActionConsumer.DontSendReleaseEvent(consumer);
		}
	}
}

@wrapMethod(gameuiInGameMenuGameController)
private final func RegisterGlobalBlackboards() -> Void
{
	wrappedMethod();
	let hackingMinigameBlackboard:ref<IBlackboard> = this.GetBlackboardSystem().Get(GetAllBlackboardDefs().HackingMinigame);

	if(IsDefined(hackingMinigameBlackboard))
	{
		let inGameMenuController:Variant = ToVariant(this);

		hackingMinigameBlackboard.SetVariant(GetAllBlackboardDefs().HackingMinigame.InGameMenuController, inGameMenuController);
	}
}

// Entry point for access points
@wrapMethod(Device)
private final func DisplayConnectionWindowOnPlayerHUD(shouldDisplay: Bool, attempt: Int32) -> Void
{
	// Fix for redscript no longer allowing to wrap this method using AccessPoint class.
	// Device should now be used for this specific wrap, but since Device is litteraly the entire universe...
	if(NotEquals(this as AccessPoint, null))
	{
		let modSettings = new PatternRecognitionModSettings();
		if(!modSettings.isEnabled || RandF() > modSettings.hackOverrideProbability)
		{
			wrappedMethod(shouldDisplay, attempt);
			return;
		}
		let minigameSettings:ref<PatternRecognitionHackSettings> = PatternRecognitionHackSettings.Default();
		PatternRecognitionHack.StartMinigame(minigameSettings, this.GetGame(),this as AccessPoint);
		//this.TogglePersonalLink(false, this.GetPlayerMainObject());
		//this.TurnOffDevice();
		//this.DeactivateDevice();
	}
	else
	{
		wrappedMethod(shouldDisplay,attempt);
	}
}