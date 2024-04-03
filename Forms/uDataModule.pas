unit uDataModule;

interface

uses
  System.SysUtils, System.Classes, FMX.Types, FMX.Controls;

type
  TDM = class(TDataModule)
    AppStyleBook: TStyleBook;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

end.
