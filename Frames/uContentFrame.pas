unit uContentFrame;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TContentFrame = class(TFrame)
    BookSeperator: TLine;
    lblContent: TLabel;
    procedure FrameClick(Sender: TObject);
    procedure FrameTap(Sender: TObject; const Point: TPointF);
  private
    FHandler: TNotifyEvent;
    FLink: string;
    function GetTitle: string;
    procedure SetTitle(const Value: string);

  public
    property Link: string read FLink write FLink;
    property Title: string read GetTitle write SetTitle;

    function WithSelect(AHandler: TNotifyEvent): TContentFrame;

    class function Build(AParent: TControl; ATitle, ALink: string): TContentFrame;

  end;

implementation

{$R *.fmx}

uses
  uFontUtility;

{ TContentFrame }

{--------------------------------------------------------------------------------------------------}
class function TContentFrame.Build(AParent: TControl; ATitle, ALink: string): TContentFrame;
begin
  Assert(Assigned(AParent), 'missing parent');

  Result := TContentFrame.Create(nil);

  Result.Align := TAlignLayout.Top;
  Result.Title := ATitle;
  Result.Link  := ALink;
  Result.lblContent.Font.Size := FmxFont.Body1;

  AParent.AddObject(Result);
end;

{--------------------------------------------------------------------------------------------------}
function TContentFrame.WithSelect(AHandler: TNotifyEvent): TContentFrame;
begin
  FHandler := AHandler;
  Result := self;
end;

{--------------------------------------------------------------------------------------------------}
procedure TContentFrame.FrameClick(Sender: TObject);
begin
{$IF defined(MSWINDOWS)|| defined(MACOS)}
  if Assigned(FHandler) then
    FHandler(self);
{$ENDIF}
end;

{--------------------------------------------------------------------------------------------------}
procedure TContentFrame.FrameTap(Sender: TObject; const Point: TPointF);
begin
  if Assigned(FHandler) then
    FHandler(self);
end;

{--------------------------------------------------------------------------------------------------}
function TContentFrame.GetTitle: string;
begin
  Result := lblContent.Text;
end;

{--------------------------------------------------------------------------------------------------}
procedure TContentFrame.SetTitle(const Value: string);
begin
  lblContent.Text := value;
end;

end.

