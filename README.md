# SPYTestLog

## XCTest meet XcodeColors

SPYTestLog is a simple test utility to add some color to your Xcode console.  Instead of the drab and plain logs of plain ole XCTestLog

![XCTestLog](http://imgur.com/3hZwVqa.png)

You get the colorful output of SPYTestLog

![SPYTestLog](http://imgur.com/VgxCuY3.png)

## Integration

SPYTestLog has a dependency on [XcodeColors](https://github.com/robbiehanson/XcodeColors) to display colorful output in your Xcode console.  You should first follow the instructions to get that installed (probably easiest through [Alcatraz](https://github.com/supermarin/Alcatraz)).  Please note that if you’re working with a team and they don’t have XcodeColors installed then they will continue to see the same default XCTestLogs.

The best and fastest way of integrating SPYTestLog is with CocoaPods.  SPYTestLog should only be added to your test target so adding it would look something like

```
target :YOUR_TEST_TARGET, :exclusive => true do
  pod 'SPYTestLog'
end
```

After adding that to your pod file and pod updating or installing you can tell your project to use SPYTestLog by adding the following to your application:didFinishLaunchingWithOptions:
 
 ```
 #ifdef DEBUG
     [[NSUserDefaults standardUserDefaults] setObject:@"SPYTestLog" forKey:@"XCTestObserverClass"];
     [[NSUserDefaults standardUserDefaults] synchronize];
 #endif
 ```
 
 This is the Apple’s preferred way of adding TestLogs to XCTest.
 

## Caveats
One caveat is that SPYTestLog will add the format for XcodeColors to command line builds as well.  This means that if locally you run ‘xcodebuild’ there will be formatting in some of your test logs.  This also means that if locally you use ‘xcodebuild’ with something like [XCPretty](https://github.com/supermarin/xcpretty) you won’t get any output for your test logs.  If you have any suggestions for a way to fix this I’m all ears.

This however shouldn’t effect Continuous Integration servers (assuming they don’t have XcodeColors installed) as SPYTestLog will just fall back to the normal log if XcodeColors is not installed.

This also doesn’t seem to effect command line builds using [XCTool](https://github.com/facebook/xctool).

## Subclassing
Subclasses can override the colors of the output by overriding
```
- (NSString *)testCasePassedColor;
- (NSString *)testCaseFailedColor;
```
and providing a properly formatted XcodeColor.  For reference the implementation of looks like this.
```
- (NSString *)testCasePassedColor
{
    return @"fg127,175,27;";
}
```
