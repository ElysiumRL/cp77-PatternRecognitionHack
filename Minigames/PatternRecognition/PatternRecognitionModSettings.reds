module PatternRecognitionHack.ModSettings

public class PatternRecognitionModSettings extends IScriptable
{
    @runtimeProperty("ModSettings.mod","CustomHackingSystem")
    @runtimeProperty("ModSettings.category","Pattern Recognition Hack")
    @runtimeProperty("ModSettings.displayName","Enabled")
    @runtimeProperty("ModSettings.description","Toggles the hack")
    public let isEnabled : Bool = true;

    @runtimeProperty("ModSettings.mod","CustomHackingSystem")
    @runtimeProperty("ModSettings.category","Pattern Recognition Hack")
    @runtimeProperty("ModSettings.displayName","Apparition Probability")
    @runtimeProperty("ModSettings.step", "0.05")
    @runtimeProperty("ModSettings.min", "0.0")
    @runtimeProperty("ModSettings.max", "1.0")
    @runtimeProperty("ModSettings.description","Probability of the minigame appearing over the vanilla")
    public let hackOverrideProbability : Float = 1.0;
}
