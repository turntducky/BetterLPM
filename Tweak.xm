@interface _CDBatterySaver : NSObject
+ (id)batterySaver;
- (int)getPowerMode;
- (int)setMode:(int)arg1;
@end

%hook SBUIController // Hooks the class SBUIController.h file to write the tweak
- (void)updateBatteryState:(id)arg1 { //Updates the battery state 
  %orig; // Override the original statement
     UIDevice *device = [UIDevice currentDevice]; // Get current device
     [device setBatteryMonitoringEnabled:YES]; // Set this to true to grab battery percentage
     UIDeviceBatteryState deviceBatteryState = [UIDevice currentDevice].batteryState; // Get the current state of the battery
      if (deviceBatteryState == UIDeviceBatteryStateCharging) { // If the device is charging
          [[%c(_CDBatterySaver) batterySaver] setMode:0]; // Set Low Power Mode to off
        }
     if (deviceBatteryState == UIDeviceBatteryStateUnplugged) { // If the device isn't charging
          [[%c(_CDBatterySaver) batterySaver] setMode:1]; // Set Low Power Mode to on
   }
}
%end
