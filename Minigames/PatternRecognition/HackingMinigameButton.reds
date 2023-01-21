module CustomHackingSystem.Hacks.PatternRecognition
import Codeware.UI.*

public class HackingMinigameButton extends CustomButton {
	protected let m_isFlipped: Bool;

	//protected let m_bg: wref<inkImage>;

	//protected let m_fill: wref<inkImage>;
	
	protected let minigameOwner: ref<HackingGrid>;

    public const func AllowDrag() -> Bool
	{
		return false;
	}

	protected let m_frame: wref<inkImage>;

	public let displayedText: String = "--";

	public let indexInGrid:Int32 = 0;

	protected func CreateWidgets() -> Void {
		let root: ref<inkCanvas> = new inkCanvas();
		root.SetName(n"button");
		root.SetSize(100.0, 100.0);
		root.SetAnchorPoint(new Vector2(0.5, 0.5));
		root.SetInteractive(true);

		let frame: ref<inkImage> = new inkImage();
		frame.SetName(n"frame");
		frame.SetAtlasResource(r"base\\gameplay\\gui\\common\\shapes\\atlas_shapes_sync.inkatlas");
		frame.SetOpacity(1.0);
		frame.SetAnchor(inkEAnchor.Fill);
		frame.SetNineSliceScale(true);
		frame.SetNineSliceGrid(new inkMargin(0.0, 0.0, 10.0, 0.0));
		frame.Reparent(root);

		let label: ref<inkText> = new inkText();
		label.SetName(n"label");
		label.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
		label.SetFontStyle(n"Medium");
		label.SetFontSize(50);
		label.SetOpacity(1.0);
		label.SetLetterCase(textLetterCase.UpperCase);
		label.SetVisible(true);

		label.SetTintColor(MainColors.Grey());
		label.SetAnchor(inkEAnchor.Fill);
		label.SetHorizontalAlignment(textHorizontalAlignment.Center);
		label.SetVerticalAlignment(textVerticalAlignment.Center);
		label.SetText("--");
		label.Reparent(root);

		this.m_root = root;
		this.m_label = label;
		this.m_frame = frame;

		this.SetRootWidget(root);
		this.ApplyFlippedState();
	}

	protected func CreateAnimations() -> Void
	{

	}

	protected func ApplyFlippedState() -> Void {
		//this.m_bg.SetTexturePart(this.m_isFlipped ? n"cell_flip_bg" : n"cell_bg");
		//this.m_fill.SetTexturePart(this.m_isFlipped ? n"cell_flip_bg" : n"cell_bg");
		this.m_frame.SetTexturePart(this.m_isFlipped ? n"cell_flip_fg" : n"cell_fg");
	}
//
//	protected func ApplyDisabledState() -> Void {
//		let reverseAnimOpts: inkAnimOptions;
//		reverseAnimOpts.playReversed = !this.m_isDisabled;
//
//		this.m_disabledRootAnimProxy.Stop();
//		this.m_disabledRootAnimProxy = this.m_root.PlayAnimationWithOptions(this.m_disabledRootAnimDef, reverseAnimOpts);
//	}

	protected func ApplyHoveredState() -> Void {
		//if(IsDefined(this.m_textOpeningAnimProxy))
		//{
		//	this.m_textOpeningAnimProxy.Stop();
		//}
		this.m_label.TintShift(MainColors.Grey(), MainColors.CombatRed(), 0.2, true, !this.m_isHovered);
	}

	protected func ApplyPressedState() -> Void {
		this.m_label.TintShift(MainColors.CombatRed(), MainColors.Grey(), 0.1, true, !this.m_isPressed);
	}

	public func SetFlipped(isFlipped: Bool) -> Void {
		this.m_isFlipped = isFlipped;

		this.ApplyFlippedState();
	}

	public func SetText(text: String) -> Void
	{
		super.SetText(text);
		this.displayedText = text;
	}

	public static func Create(text: String) -> ref<HackingMinigameButton> {
		let button: ref<HackingMinigameButton> = new HackingMinigameButton();
		button.CreateInstance();
		button.m_label.SetText(text);
		return button;
	}

	protected cb func OnHoverOver(evt: ref<inkPointerEvent>) -> Bool {
		super.OnHoverOver(evt);
		this.minigameOwner.OnHoverInAllSelections(this.indexInGrid);
	}

	protected cb func OnHoverOut(evt: ref<inkPointerEvent>) -> Bool {
		super.OnHoverOut(evt);
		this.minigameOwner.OnHoverOutAllSelections(this.indexInGrid);
	}

}
