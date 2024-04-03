unit uBook;

interface

uses
  uLanguageUtility;

type
  TBook = class
  private
    FTitle: string;
    FAuthor: string;
    FImagePath: string;
    FHtmlPath: string;
    FContentNames: TStrList;
    FContentLinks: TStrList;

    function GetContentLink(idx: integer): string;
    function GetContentName(idx: integer): string;

    procedure AddContentLink(const name: string; const link: string);

    constructor Create;

  public
    property Author: string read FAuthor write FAuthor;
    property Title: string read FTitle write FTitle;
    property HtmlPath: string read FHtmlPath write FHtmlPath;
    property ImagePath: string read FImagePath write FImagePath;
    property ContentNames[idx: integer]: string read GetContentName;
    property ContentLinks[idx: integer]: string read GetContentLink;

    function ContentCount: integer;

    destructor Destroy; override;
  end;

  TBookRepository = class
  public
    class function Load: TBook;
  end;

implementation

uses
  System.SysUtils, System.StrUtils, System.Classes, uIntegrityUtility, uFileUtility;

{ TBookModel }

{----------------------------------------------------------------------------------------------------------------------}
function TBook.ContentCount: integer;
begin
  Result := FContentNames.Count;
end;

{----------------------------------------------------------------------------------------------------------------------}
constructor TBook.Create;
begin
  FContentNames := TStrList.Create;
  FContentLinks := TStrList.Create;
end;

{----------------------------------------------------------------------------------------------------------------------}
destructor TBook.Destroy;
begin
  FreeAndNil(FContentNames);
  FreeAndNil(FContentLinks);

  inherited;
end;

{----------------------------------------------------------------------------------------------------------------------}
function TBook.GetContentLink(idx: integer): string;
begin
  Result := FContentLinks[idx];
end;

{----------------------------------------------------------------------------------------------------------------------}
function TBook.GetContentName(idx: integer): string;
begin
  Result := FContentNames[idx];
end;

{----------------------------------------------------------------------------------------------------------------------}
procedure TBook.AddContentLink(const name: string; const link: string);
begin
  Guard.IsNotBlank(name).IsNotBlank(link).IsNotPresent(name, FContentNames);

  FContentNames.Add(name);
  FContentLinks.Add(link);
end;

{ TBookRepository }

{----------------------------------------------------------------------------------------------------------------------}
class function TBookRepository.Load: TBook;
const
  Properties : array[0..3] of String = ('Author', 'Title', 'Html', 'Image');
begin
  var book := TBook.Create;
  var lines := FmxFile.ReadDocument('Hub\\manifest.txt');

  for var line in lines do
  begin
    if string.IsNullOrWhitespace(line) then continue;

    var parts := line.Split(['|']);
    if Length(parts) <> 2 then continue;

    var key   := parts[0].Trim;
    var value := parts[1].Trim;

    case IndexText(key, Properties) of
      0: book.Title := value;
      1: book.Author := value;
      2: book.HtmlPath := FmxFile.GetDocumentPath(value);
      3: book.ImagePath := FmxFile.GetDocumentPath(value);
    else
      book.AddContentLink(key, value);
    end;
  end;

  Result := book;
end;

end.
