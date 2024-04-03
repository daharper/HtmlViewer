unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  fmx.fhtmlcomp, FMX.MultiView, uFiles;

type
  TMainForm = class(TForm)
    Rectangle1: TRectangle;
    btnDrawer: TSpeedButton;
    HtPanel1: THtPanel;
    MultiView1: TMultiView;
    btnRefresh: TSpeedButton;
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

procedure TMainForm.btnRefreshClick(Sender: TObject);
begin
  var filename := TFiles.GetPath('content.html');

  HtPanel1.LoadFromFile(filename);
end;

end.
