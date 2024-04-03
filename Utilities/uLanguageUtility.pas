unit uLanguageUtility;

interface

uses
  System.Generics.Collections;

type
  TStrIndex = TDictionary<string, string>;
  TStrArray = array of string;
  TStrList = TList<string>;
  TIntList = TList<Integer>;

  { Returns the TrueValue if the Condition is true, otherwise the FalseValue }
  function Iff(Condition: boolean; TrueValue, FalseValue: integer): integer; overload;
  function Iff(Condition: boolean; TrueValue, FalseValue: string): string; overload;
  function Iff(Condition: boolean; TrueValue, FalseValue: single): single; overload;

implementation

{----------------------------------------------------------------------------------------------------------------------}
function Iff(Condition: boolean; TrueValue, FalseValue: integer): integer;
begin
  if Condition then
    Result := TrueValue
  else
    Result := FalseValue;
end;

{----------------------------------------------------------------------------------------------------------------------}
function Iff(Condition: boolean; TrueValue, FalseValue: string): string;
begin
  if Condition then
    Result := TrueValue
  else
    Result := FalseValue;
end;

{----------------------------------------------------------------------------------------------------------------------}
function Iff(Condition: boolean; TrueValue, FalseValue: single): single;
begin
  if Condition then
    Result := TrueValue
  else
    Result := FalseValue;
end;

end.
