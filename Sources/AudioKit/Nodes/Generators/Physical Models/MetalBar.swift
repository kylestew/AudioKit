// Copyright AudioKit. All Rights Reserved. Revision History at http://github.com/AudioKit/AudioKit/
// This file was auto-autogenerated by scripts and templates at http://github.com/AudioKit/AudioKitDevTools/

import AVFoundation
import CAudioKit

/// Physical model approximating the sound of a struck metal bar
/// TODO This node needs to have tests
/// 
public class MetalBar: Node, AudioUnitContainer, Toggleable {

    public static let ComponentDescription = AudioComponentDescription(generator: "mbar")

    public typealias AudioUnitType = InternalAU

    public private(set) var internalAU: AudioUnitType?

    // MARK: - Parameters

    public static let leftBoundaryConditionDef = NodeParameterDef(
        identifier: "leftBoundaryCondition",
        name: "Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free",
        address: akGetParameterAddress("MetalBarParameterLeftBoundaryCondition"),
        range: 1 ... 3,
        unit: .hertz,
        flags: .default)

    /// Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free
    @Parameter public var leftBoundaryCondition: AUValue

    public static let rightBoundaryConditionDef = NodeParameterDef(
        identifier: "rightBoundaryCondition",
        name: "Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free",
        address: akGetParameterAddress("MetalBarParameterRightBoundaryCondition"),
        range: 1 ... 3,
        unit: .hertz,
        flags: .default)

    /// Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free
    @Parameter public var rightBoundaryCondition: AUValue

    public static let decayDurationDef = NodeParameterDef(
        identifier: "decayDuration",
        name: "30db decay time (in seconds).",
        address: akGetParameterAddress("MetalBarParameterDecayDuration"),
        range: 0 ... 10,
        unit: .hertz,
        flags: .default)

    /// 30db decay time (in seconds).
    @Parameter public var decayDuration: AUValue

    public static let scanSpeedDef = NodeParameterDef(
        identifier: "scanSpeed",
        name: "Speed of scanning the output location.",
        address: akGetParameterAddress("MetalBarParameterScanSpeed"),
        range: 0 ... 100,
        unit: .hertz,
        flags: .default)

    /// Speed of scanning the output location.
    @Parameter public var scanSpeed: AUValue

    public static let positionDef = NodeParameterDef(
        identifier: "position",
        name: "Position along bar that strike occurs.",
        address: akGetParameterAddress("MetalBarParameterPosition"),
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Position along bar that strike occurs.
    @Parameter public var position: AUValue

    public static let strikeVelocityDef = NodeParameterDef(
        identifier: "strikeVelocity",
        name: "Normalized strike velocity",
        address: akGetParameterAddress("MetalBarParameterStrikeVelocity"),
        range: 0 ... 1_000,
        unit: .generic,
        flags: .default)

    /// Normalized strike velocity
    @Parameter public var strikeVelocity: AUValue

    public static let strikeWidthDef = NodeParameterDef(
        identifier: "strikeWidth",
        name: "Spatial width of strike.",
        address: akGetParameterAddress("MetalBarParameterStrikeWidth"),
        range: 0 ... 1,
        unit: .generic,
        flags: .default)

    /// Spatial width of strike.
    @Parameter public var strikeWidth: AUValue

    // MARK: - Audio Unit

    public class InternalAU: AudioUnitBase {

        public override func getParameterDefs() -> [NodeParameterDef] {
            [MetalBar.leftBoundaryConditionDef,
             MetalBar.rightBoundaryConditionDef,
             MetalBar.decayDurationDef,
             MetalBar.scanSpeedDef,
             MetalBar.positionDef,
             MetalBar.strikeVelocityDef,
             MetalBar.strikeWidthDef]
        }

        public override func createDSP() -> DSPRef {
            akCreateDSP("MetalBarDSP")
        }
    }

    // MARK: - Initialization

    /// Initialize this Bar node
    ///
    /// - Parameters:
    ///   - leftBoundaryCondition: Boundary condition at left end of bar. 1 = clamped, 2 = pivoting, 3 = free
    ///   - rightBoundaryCondition: Boundary condition at right end of bar. 1 = clamped, 2 = pivoting, 3 = free
    ///   - decayDuration: 30db decay time (in seconds).
    ///   - scanSpeed: Speed of scanning the output location.
    ///   - position: Position along bar that strike occurs.
    ///   - strikeVelocity: Normalized strike velocity
    ///   - strikeWidth: Spatial width of strike.
    ///   - stiffness: Dimensionless stiffness parameter
    ///   - highFrequencyDamping: High-frequency loss parameter. Keep this small
    ///
    public init(
        leftBoundaryCondition: AUValue = 1,
        rightBoundaryCondition: AUValue = 1,
        decayDuration: AUValue = 3,
        scanSpeed: AUValue = 0.25,
        position: AUValue = 0.2,
        strikeVelocity: AUValue = 500,
        strikeWidth: AUValue = 0.05,
        stiffness: AUValue = 3,
        highFrequencyDamping: AUValue = 0.001
    ) {
        super.init(avAudioNode: AVAudioNode())

        instantiateAudioUnit { avAudioUnit in
            self.avAudioUnit = avAudioUnit
            self.avAudioNode = avAudioUnit

            guard let audioUnit = avAudioUnit.auAudioUnit as? AudioUnitType else {
                fatalError("Couldn't create audio unit")
            }
            self.internalAU = audioUnit
            self.stop()

            self.leftBoundaryCondition = leftBoundaryCondition
            self.rightBoundaryCondition = rightBoundaryCondition
            self.decayDuration = decayDuration
            self.scanSpeed = scanSpeed
            self.position = position
            self.strikeVelocity = strikeVelocity
            self.strikeWidth = strikeWidth
        }

    }
}
