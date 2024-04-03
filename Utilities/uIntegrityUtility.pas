unit uIntegrityUtility;

interface

uses
  uLanguageUtility;

type
  TGuardUtility = class
  private
    procedure Throw(error: string = 'Precondition failure');

    constructor Create;

    class var
      FInstance: TGuardUtility;

  public
    function IsNotBlank(const item: string; error: string = ''): TGuardUtility;
    function IsNotPresent(const item: string; items: TStrList; error: string = ''): TGuardUtility;

    class constructor Create;
    class destructor Destroy;
  end;

  function Guard: TGuardUtility;

implementation

uses
  System.SysUtils;

{----------------------------------------------------------------------------------------------------------------------}
function Guard: TGuardUtility;
begin
  Result := TGuardUtility.FInstance;
end;

{ TGuardUtility }

{----------------------------------------------------------------------------------------------------------------------}
constructor TGuardUtility.Create;
begin
  //
end;

{----------------------------------------------------------------------------------------------------------------------}
class constructor TGuardUtility.Create;
begin
  FInstance := TGuardUtility.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
class destructor TGuardUtility.Destroy;
begin
  FreeAndNil(FInstance);
end;

{----------------------------------------------------------------------------------------------------------------------}
function TGuardUtility.IsNotBlank(const item: string; error: string = ''): TGuardUtility;
begin
  if string.IsNullOrWhiteSpace(item) then
  begin
    error := Iff(string.IsNullOrEmpty(error), 'precondition error: value was blank.', error);
    Throw(error);
  end;

  Result := self;
end;

{----------------------------------------------------------------------------------------------------------------------}
function TGuardUtility.IsNotPresent(const item: string; items: TStrList; error: string = ''): TGuardUtility;
begin
  if items.Contains(item) then
  begin
    error := Iff(string.IsNullOrEmpty(error), 'precondition error: ' + item + ' already present in list.', error);
    Throw(error);
  end;

  Result := self;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TGuardUtility.Throw(error: string);
begin
  raise Exception.Create(error);
end;

end.
