program HtmlViewer;

uses
  System.StartUpCopy,
  FMX.Forms,
  uMainForm in 'Forms\uMainForm.pas' {MainForm},
  uFileUtility in 'Utilities\uFileUtility.pas',
  uContentFrame in 'Frames\uContentFrame.pas' {Frame1: TFrame},
  uFontUtility in 'Utilities\uFontUtility.pas',
  uScreenUtility in 'Utilities\uScreenUtility.pas',
  uLanguageUtility in 'Utilities\uLanguageUtility.pas',
  uBook in 'Domain\uBook.pas',
  uIntegrityUtility in 'Utilities\uIntegrityUtility.pas',
  uDataModule in 'Forms\uDataModule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
