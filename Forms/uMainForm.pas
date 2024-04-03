unit uMainForm;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Layouts,
  fmx.fhtmlcomp, fmx.fhtmldraw, htmlpars, FMX.MultiView, uDataModule, uBook;

type
  TMainForm = class(TForm)
    Rectangle1: TRectangle;
    btnDrawer: TSpeedButton;
    HtPanel1: THtPanel;
    MultiView1: TMultiView;
    btnRefresh: TSpeedButton;
    Layout1: TLayout;
    recCover: TRectangle;
    lblTitle: TLabel;
    lblAuthor: TLabel;
    vsbContents: TVertScrollBox;
    ScaleTrackBar: TTrackBar;
    btnToggleChrome: TSpeedButton;
    procedure btnRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ScaleTrackBarChange(Sender: TObject);
    procedure btnToggleChromeClick(Sender: TObject);
  private
    procedure LoadProfileImage(book: TBook);
  public
    procedure OnSelect(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

uses
  uContentFrame, uFileUtility, uLanguageUtility;

{$R *.fmx}

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.btnRefreshClick(Sender: TObject);
begin
 { load book details }
  var book := TBookRepository.Load;

  HtPanel1.LoadFromFile(book.HtmlPath);

  { update contents header information }
  LoadProfileImage(book);

  lblTitle.Text := book.Title;
  lblAuthor.Text := book.Author;

  { rebuild table of contents }
  vsbContents.BeginUpdate;

  try
    { remove existing, reuse is hard because parent reorders on visibility changes }
    for var i := vsbContents.Content.ChildrenCount-1 downto 0 do
    begin
      var obj := vsbContents.Content.Children[i];
      vsbContents.Content.RemoveObject(obj);
      obj.Free;
    end;

    { create the new contents items }
    for var i := 0 to book.ContentCount - 1 do
      TContentFrame.Build(vsbContents, book.ContentNames[i], book.ContentLinks[i])
                   .WithSelect(OnSelect);
  finally
    vsbContents.EndUpdate;
    book.Free;
  end;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.LoadProfileImage(book: TBook);
begin
  var maxWidth := recCover.Width;
  var maxHeight := recCover.Height;

  var bitmap := TBitmap.Create;
  bitmap.LoadFromFile(book.ImagePath);

  recCover.Fill.Kind := TbrushKind.Bitmap;
  recCover.Fill.Bitmap.WrapMode := TWrapMode.TileOriginal;
  recCover.Fill.Bitmap.Bitmap.Assign(nil);
  recCover.Width := Iff(bitmap.Width > maxWidth, maxWidth, bitmap.Width);
  recCover.Height := Iff(bitmap.Height > maxHeight, maxHeight, bitmap.Height);
  recCover.Fill.Bitmap.Bitmap := bitmap;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.btnToggleChromeClick(Sender: TObject);
begin
  if BorderStyle = TFmxFormBorderStyle.Sizeable then
    BorderStyle := TFmxFormBorderStyle.None
  else
    BorderStyle := TFmxFormBorderStyle.Sizeable;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.FormShow(Sender: TObject);
begin
  Left := (Trunc(Screen.DesktopWidth) div 2) * -1;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.OnSelect(Sender: TObject);
begin
  inherited;

  var content := Sender as TContentFrame;
  var element := HtPanel1.Doc.GetElementbyId(content.Link);

  if Assigned(element) then begin
    HtPanel1.ScrollIntoTop(element);
    MultiView1.HideMaster;
  end;
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TMainForm.ScaleTrackBarChange(Sender: TObject);
begin
  HtPanel1.ContentScale := 1 + ScaleTrackBar.Value * 0.2;
end;

end.
