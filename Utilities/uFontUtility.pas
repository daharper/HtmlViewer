unit uFontUtility;

interface

type

  {
    Utility for managing fonts. Delphi will automatically scale font size 12 as per the system settings.
    For headings, use this class for manual scaling.
  }
  TFontUtility = class
  private
    FH1:        single;
    FH2:        single;
    FH3:        single;
    FH4:        single;
    FH5:        single;
    FH6:        single;
    FSub1:      single;
    FSub2:      single;
    FBody1:     single;
    FBody2:     single;
    FNormal:    single;
    FOverline:  single;
    FScale:     single;

    constructor Create;

    class var
      FInstance: TFontUtility;

  public
{ 96 }
    property H1:       single read FH1;
    { 60 }
    property H2:       single read FH2;
    { 48 }
    property H3:       single read FH3;
    { 34 }
    property H4:       single read FH4;
    { 24 }
    property H5:       single read FH5;
    { 20 }
    property H6:       single read FH6;
    { 16 }
    property Sub1:     single read FSub1;
    { 14 }
    property Sub2:     single read FSub2;
    { 16 }
    property Body1:    single read FBody1;
    { 14 }
    property Body2:    single read FBody2;
    { 12 }
    property Normal:   single read FNormal;
    { 10 }
    property Overline: single read FOverline;

    property Scale:    single read FScale;

    class constructor Create;
    class destructor Destroy;
  end;

  { access TFontUtility via this function }
  function FmxFont: TFontUtility;

implementation

uses
  SysUtils, uScreenUtility;

{----------------------------------------------------------------------------------------------------------------------}
function FmxFont: TFontUtility;
begin
  Result := TFontUtility.FInstance;
end;

{ TFontUtility }

{----------------------------------------------------------------------------------------------------------------------}
class constructor TFontUtility.Create;
begin
  FInstance := TFontUtility.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
constructor TFontUtility.Create;
begin
  FScale := FmxScreen.FontScale;

  FH1       := 96.0 * FScale;
  FH2       := 60.0 * FScale;
  FH3       := 48.0 * FScale;
  FH4       := 34.0 * FScale;
  FH5       := 24.0 * FScale;
  FH6       := 20.0 * FScale;
  FSub1     := 16.0 * FScale;
  FSub2     := 14.0 * FScale;
  FBody1    := 16.0 * FScale;
  FBody2    := 14.0 * FScale;
  FNormal   := 12.0 * FScale;
  FOverline := 10.0 * FScale;
end;

{----------------------------------------------------------------------------------------------------------------------}
class destructor TFontUtility.Destroy;
begin
  FreeAndNil(FInstance);
end;

end.
