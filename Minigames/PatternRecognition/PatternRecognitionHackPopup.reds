module CustomHackingSystem.Hacks.PatternRecognition
import HackingExtensions.CustomMinigame.*
import Codeware.UI.*

public class PatternRecognitionHackPopup extends CustomMinigameHackPopup
{
	public func UseCursor() -> Bool
	{
		return true;
	}

	protected cb func OnCreate() -> Void
	{
		super.OnCreate();

		let minigame:ref<HackingGrid> = HackingGrid.Create();
		minigame.popupParent = this;
		minigame.Reparent(this.baseWidget);
	}

	protected cb func OnInitialize() -> Void
	{
		super.OnInitialize();
	}

	public static func Show(requester: ref<inkGameController>) -> Void
	{
		let popup: ref<PatternRecognitionHackPopup> = new PatternRecognitionHackPopup();
		popup.Open(requester);
	}
}
