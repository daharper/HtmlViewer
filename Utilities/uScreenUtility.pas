unit uScreenUtility;

interface

uses
{$IFDEF IOS}
  iOSapi.UIKit,
{$ENDIF IOS}

{$IFDEF ANDROID}
  Androidapi.Helpers, Androidapi.JNI.GraphicsContentViewText, FMX.Platform.Android,
{$ENDIF ANDROID}
  FMX.Types, FMX.Platform;

type
  TScreenUtility = class
  private
    FFontScale:   single;
    FIsSupported: boolean;
    FScreen:      IFmxScreenService;

    constructor Create;

    procedure InitFontScale;

    class var
      FInstance: TScreenUtility;

  public
    { disables landscape mode }
    procedure DisableLandscape;

    { sends the application to the background }
    procedure Hide;

    { gets the fontscale from the system settings }
    property FontScale: single read FFontScale;

    destructor Destroy; override;

    class constructor Create;
    class destructor Destroy;
  end;

  { access the TScreenUtility via this function }
  function FmxScreen: TScreenUtility;

implementation

uses
  System.SysUtils;

{ FmxScreen }

{----------------------------------------------------------------------------------------------------------------------}
function FmxScreen: TScreenUtility;
begin
  Result := TScreenUtility.FInstance;
end;

{ TScreenUtility }

{----------------------------------------------------------------------------------------------------------------------}
constructor TScreenUtility.Create;
begin
  FIsSupported := TPlatformServices.Current.SupportsPlatformService(IFMXScreenService);

  if FIsSupported then
    FScreen := TPlatFormServices.Current.GetPlatformService(IFMXScreenService) as IFMXScreenService;

  InitFontScale;
end;

{----------------------------------------------------------------------------------------------------------------------}
destructor TScreenUtility.Destroy;
begin
  FScreen := nil;

  Inherited;
end;

{----------------------------------------------------------------------------------------------------------------------}
class constructor TScreenUtility.Create;
begin
  FInstance := TScreenUtility.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
class destructor TScreenUtility.Destroy;
begin
  FreeAndNil(FInstance);
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TScreenUtility.DisableLandscape;
begin
  if FIsSupported then
    FScreen.SetSupportedScreenOrientations([TScreenOrientation.Portrait]);
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TScreenUtility.Hide;
begin
{$IFDEF ANDROID}
  MainActivity.moveTaskToBack(true);
{$ENDIF}
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TScreenUtility.InitFontScale;
begin
  FFontScale := 1.0;

{$IFDEF ANDROID}
  if TAndroidHelper.Context <> nil then begin
    var resources := TAndroidHelper.Context.getResources;

    if resources <> nil then begin
      var config := resources.getConfiguration;

      if config <> nil then
        FFontScale := config.fontScale;
    end;
  end;
{$ENDIF ANDROID}

{$IFDEF IOS}
  var f := TUIFontDescriptor.OCClass.preferredFontDescriptorWithTextStyle(UIFontTextStyleBody);
  FFontScale := f.pointSize / 17.0;
{$ENDIF IOS}
end;

end.
