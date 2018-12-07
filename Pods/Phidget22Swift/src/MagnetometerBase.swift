import Foundation
import Phidget22_C

/**
The Magnetometer class gathers magnetic compass data from Phidget boards. Phidget magnetometers usually have multiple sensors, each oriented in a different axis, so multiple dimensions of compass bearing can be recorded.

If the Phidget you're using also has a gyroscope and an accelerometer, you may want to use the Spatial class in order to get all of the data at the same time, in a single event.
*/
public class MagnetometerBase : Phidget {

	public init() {
		var h: PhidgetHandle?
		PhidgetMagnetometer_create(&h)
		super.init(h!)
		initializeEvents()
	}

	internal override init(_ handle: PhidgetHandle) {
		super.init(handle)
	}

	deinit {
		if (retained) {
			Phidget_release(&chandle)
		} else {
			uninitializeEvents()
			PhidgetMagnetometer_delete(&chandle)
		}
	}

	/**
	The number of axes the channel can measure field strength on.

	*   See your device's User Guide for more information about the number of axes and their orientation.

	- returns:
	The axis count value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getAxisCount() throws -> Int {
		let result: PhidgetReturnCode
		var axisCount: Int32 = 0
		result = PhidgetMagnetometer_getAxisCount(chandle, &axisCount)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return Int(axisCount)
	}

	/**
	Calibrate your device for the environment it will be used in.

	*   Due to physical location, hard and soft iron offsets, and even bias errors, your device should be calibrated. We have created a calibration program that will provide you with the `CompassCorrectionParameters` for your specific situation. See your device's User Guide for more information.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- magneticField: Ambient magnetic field value.
		- offset0: Provided by calibration program.
		- offset1: Provided by calibration program.
		- offset2: Provided by calibration program.
		- gain0: Provided by calibration program.
		- gain1: Provided by calibration program.
		- gain2: Provided by calibration program.
		- T0: Provided by calibration program.
		- T1: Provided by calibration program.
		- T2: Provided by calibration program.
		- T3: Provided by calibration program.
		- T4: Provided by calibration program.
		- T5: Provided by calibration program.
	*/
	public func setCorrectionParameters(magneticField: Double, offset0: Double, offset1: Double, offset2: Double, gain0: Double, gain1: Double, gain2: Double, T0: Double, T1: Double, T2: Double, T3: Double, T4: Double, T5: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMagnetometer_setCorrectionParameters(chandle, magneticField, offset0, offset1, offset2, gain0, gain1, gain2, T0, T1, T2, T3, T4, T5)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `MagneticFieldChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `MagneticFieldChange` events can also affected by the `MagneticFieldChangeTrigger`.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var dataInterval: UInt32 = 0
		result = PhidgetMagnetometer_getDataInterval(chandle, &dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return dataInterval
	}

	/**
	The `DataInterval` is the time that must elapse before the channel will fire another `MagneticFieldChange` event.

	*   The data interval is bounded by `MinDataInterval` and `MaxDataInterval`.
	*   The timing between `MagneticFieldChange` events can also affected by the `MagneticFieldChangeTrigger`.

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- dataInterval: The data interval value
	*/
	public func setDataInterval(_ dataInterval: UInt32) throws {
		let result: PhidgetReturnCode
		result = PhidgetMagnetometer_setDataInterval(chandle, dataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var minDataInterval: UInt32 = 0
		result = PhidgetMagnetometer_getMinDataInterval(chandle, &minDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minDataInterval
	}

	/**
	The maximum value that `DataInterval` can be set to.

	- returns:
	The data interval value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxDataInterval() throws -> UInt32 {
		let result: PhidgetReturnCode
		var maxDataInterval: UInt32 = 0
		result = PhidgetMagnetometer_getMaxDataInterval(chandle, &maxDataInterval)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxDataInterval
	}

	/**
	The most recent field strength value that the channel has reported.

	*   This value will always be between `MinMagneticField` and `MaxMagneticField`.

	- returns:
	The channel's measured MagneticField

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMagneticField() throws -> [Double] {
		let result: PhidgetReturnCode
		var magneticField: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetMagnetometer_getMagneticField(chandle, &magneticField)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &magneticField.0, count: 3))
	}

	/**
	The minimum value the `MagneticFieldChange` event will report.

	- returns:
	The field strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinMagneticField() throws -> [Double] {
		let result: PhidgetReturnCode
		var minMagneticField: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetMagnetometer_getMinMagneticField(chandle, &minMagneticField)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &minMagneticField.0, count: 3))
	}

	/**
	The maximum value the `MagneticFieldChange` event will report.

	- returns:
	The field strength value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxMagneticField() throws -> [Double] {
		let result: PhidgetReturnCode
		var maxMagneticField: (Double, Double, Double) = (0, 0, 0)
		result = PhidgetMagnetometer_getMaxMagneticField(chandle, &maxMagneticField)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return [Double](UnsafeBufferPointer(start: &maxMagneticField.0, count: 3))
	}

	/**
	The channel will not issue a `MagneticFieldChange` event until the field strength value has changed by the amount specified by the `MagneticFieldChangeTrigger`.

	*   Setting the `MagneticFieldChangeTrigger` to 0 will result in the channel firing events every `DataInterval`. This is useful for applications that implement their own data filtering

	- returns:
	The change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMagneticFieldChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var magneticFieldChangeTrigger: Double = 0
		result = PhidgetMagnetometer_getMagneticFieldChangeTrigger(chandle, &magneticFieldChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return magneticFieldChangeTrigger
	}

	/**
	The channel will not issue a `MagneticFieldChange` event until the field strength value has changed by the amount specified by the `MagneticFieldChangeTrigger`.

	*   Setting the `MagneticFieldChangeTrigger` to 0 will result in the channel firing events every `DataInterval`. This is useful for applications that implement their own data filtering

	- throws:
	An error or type `PhidgetError`

	- parameters:
		- magneticFieldChangeTrigger: The change trigger value
	*/
	public func setMagneticFieldChangeTrigger(_ magneticFieldChangeTrigger: Double) throws {
		let result: PhidgetReturnCode
		result = PhidgetMagnetometer_setMagneticFieldChangeTrigger(chandle, magneticFieldChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The minimum value that `MagneticFieldChangeTrigger` can be set to.

	- returns:
	The change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMinMagneticFieldChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var minMagneticFieldChangeTrigger: Double = 0
		result = PhidgetMagnetometer_getMinMagneticFieldChangeTrigger(chandle, &minMagneticFieldChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return minMagneticFieldChangeTrigger
	}

	/**
	The maximum value that `MagneticFieldChangeTrigger` can be set to.

	- returns:
	The change trigger value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getMaxMagneticFieldChangeTrigger() throws -> Double {
		let result: PhidgetReturnCode
		var maxMagneticFieldChangeTrigger: Double = 0
		result = PhidgetMagnetometer_getMaxMagneticFieldChangeTrigger(chandle, &maxMagneticFieldChangeTrigger)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return maxMagneticFieldChangeTrigger
	}

	/**
	Resets the `CompassCorrectionParameters` to their default values.

	*   Due to physical location, hard and soft iron offsets, and even bias errors, your device should be calibrated. We have created a calibration program that will provide you with the `CompassCorrectionParameters` for your specific situation. See your device's User Guide for more information.

	- throws:
	An error or type `PhidgetError`
	*/
	public func resetCorrectionParameters() throws {
		let result: PhidgetReturnCode
		result = PhidgetMagnetometer_resetCorrectionParameters(chandle)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	Saves the `CalibrationParameters`.

	*   Due to physical location, hard and soft iron offsets, and even bias errors, your device should be calibrated. We have created a calibration program that will provide you with the `CompassCorrectionParameters` for your specific situation. See your device's User Guide for more information.

	- throws:
	An error or type `PhidgetError`
	*/
	public func saveCorrectionParameters() throws {
		let result: PhidgetReturnCode
		result = PhidgetMagnetometer_saveCorrectionParameters(chandle)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
	}

	/**
	The most recent timestamp value that the channel has reported. This is an extremely accurate time measurement streamed from the device.

	*   If your application requires a time measurement, you should use this value over a local software timestamp.

	- returns:
	The timestamp value

	- throws:
	An error or type `PhidgetError`
	*/
	public func getTimestamp() throws -> Double {
		let result: PhidgetReturnCode
		var timestamp: Double = 0
		result = PhidgetMagnetometer_getTimestamp(chandle, &timestamp)
		if result != EPHIDGET_OK {
			throw (PhidgetError(code: result))
		}
		return timestamp
	}

	internal override func initializeEvents() {
		initializeBaseEvents()
		PhidgetMagnetometer_setOnMagneticFieldChangeHandler(chandle, nativeMagneticFieldChangeHandler, UnsafeMutableRawPointer(selfCtx!.toOpaque()))
	}

	internal override func uninitializeEvents() {
		uninitializeBaseEvents()
		PhidgetMagnetometer_setOnMagneticFieldChangeHandler(chandle, nil, nil)
	}

	/**
	The most recent magnetic field values the channel has measured will be reported in this event, which occurs when the `DataInterval` has elapsed.

	*   If a `MagneticFieldChangeTrigger` has been set to a non-zero value, the `MagneticFieldChange` event will not occur until the field strength has changed by at least the `MagneticFieldChangeTrigger` value.

	---
	## Parameters:
	*   `magneticField`: The magnetic field values
	*   `timestamp`: The timestamp value
	*/
	public let magneticFieldChange = Event<Magnetometer, (magneticField: [Double], timestamp: Double)> ()
	let nativeMagneticFieldChangeHandler : PhidgetMagnetometer_OnMagneticFieldChangeCallback = { ch, ctx, magneticField, timestamp in
		let me = Unmanaged<Magnetometer>.fromOpaque(ctx!).takeUnretainedValue()
		me.magneticFieldChange.raise(me, ([Double](UnsafeBufferPointer(start: magneticField!, count: 3)), timestamp));
	}

}
