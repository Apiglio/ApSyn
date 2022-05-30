unit ApSyn_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
  private

  public

  end;

var
  Form1: TForm1;

implementation
uses apsyn_hash, md5;

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormDropFiles(Sender: TObject; const FileNames: array of String);
var len:int64;
begin
  Memo1.Clear;
  len:=Length(FileNames);
  if len<>1 then begin
    Memo1.Lines.Add('仅支持拖拽一个文件。');
    exit;
  end;
  Memo1.Lines.Add('【文件名】'+FileNames[0]);
  Memo1.Lines.Add('');
  Memo1.Lines.Add('【LogHash-8】');
  Memo1.Lines.Add(GetLogHash(FileNames[0],8));
  Memo1.Lines.Add('');
  Memo1.Lines.Add('【LogHash-64】');
  Memo1.Lines.Add(GetLogHash(FileNames[0],64));
  Memo1.Lines.Add('');
  Memo1.Lines.Add('【LogHash-256】');
  Memo1.Lines.Add(GetLogHash(FileNames[0],256));
  Memo1.Lines.Add('');
  Memo1.Lines.Add('【LogHash-2048】');
  Memo1.Lines.Add(GetLogHash(FileNames[0],2048));
  Memo1.Lines.Add('');
  Memo1.Lines.Add('【md5】');
  Memo1.Lines.Add(MD5Print(MD5File(FileNames[0])));



end;

end.

