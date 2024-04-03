unit uFileUtility;

interface

uses
  System.Classes, uLanguageUtility;

type

  {
    Provides functions to help with file management.
  }
  TFileUtility = class
  private
    FPaths: TStrIndex;

    constructor Create;

    class var
      FInstance: TFileUtility;

  public
    destructor Destroy; override;

    function GetDocumentPath(RelativePath: string): string;
    function ReadDocument(RelativePath: string): TStringList;

    procedure WriteDocument(RelativePath: string; Lines: TStringList); overload;
    procedure WriteDocument(RelativePath: string; Text: string); overload;

    class constructor Create;
    class destructor Destroy;
  end;

  { Access the TFileUtility via this function }
  function FmxFile: TFileUtility;

implementation

uses
 System.SysUtils, System.IOUtils;

{----------------------------------------------------------------------------------------------------------------------}
function FmxFile: TFileUtility;
begin
  Result := TFileUtility.FInstance;
end;

{ TFileUtility }

{----------------------------------------------------------------------------------------------------------------------}
constructor TFileUtility.Create;
begin
  FPaths := TStrIndex.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
destructor TFileUtility.Destroy;
begin
  FPaths.Free;

  inherited;
end;

{----------------------------------------------------------------------------------------------------------------------}
function TFileUtility.GetDocumentPath(RelativePath: string): string;
begin
  if not FPaths.TryGetValue(RelativePath, Result) then
  begin
    Result := TPath.Combine(TPath.GetDocumentsPath, RelativePath);
    FPaths.Add(RelativePath, Result);
  end;
end;

{----------------------------------------------------------------------------------------------------------------------}
function TFileUtility.ReadDocument(RelativePath: string): TStringList;
begin
  var path := GetDocumentPath(RelativePath);

  Result := TStringList.Create;
  Result.LoadFromFile(path);
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TFileUtility.WriteDocument(RelativePath, Text: string);
begin
  var path := GetDocumentPath(RelativePath);

  TFile.WriteAllText(path, Text);
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TFileUtility.WriteDocument(RelativePath: string; Lines: TStringList);
begin
  var path := GetDocumentPath(RelativePath);

  Lines.SaveToFile(path);
end;

{----------------------------------------------------------------------------------------------------------------------}
class constructor TFileUtility.Create;
begin
  FInstance := TFileUtility.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
class destructor TFileUtility.Destroy;
begin
  FreeAndNil(FInstance);
end;

end.
