unit apsyn_hash;

//通过逻辑斯蒂映射的混沌性对文件进行抽样
//敏感度非常差，仅用作排序和快速检测

//x_{n+1} = lambda * x_n * ( 1- x_n )
//参数: x_0∈[0,1]
//参数: lambda∈[3.6,4.0]
//x_0 = ln(filesize+2) mod 1
//lambda = 3.6 + 0.4 * (filesize mod 32767 / 32766)

{$mode objfpc}{$H+}
{$inline on}

interface

uses
  Classes, SysUtils;


function LogisticHash(str:TStream;digit:integer):string;
function GetLogHash(filename:string;digit:integer):string;


implementation

function ByteToSeg(byt:byte):string;inline;
begin
  result:=IntToHex(byt,2);
end;

function LogisticHash(str:TStream;digit:integer):string;
var x0,xn,lambda:double;
    filesize,seekindex:int64;
begin
  result:='';
  filesize:=str.Size;
  if filesize=0 then exit;
  x0:=frac(ln(filesize+2));
  lambda:=3.6+0.4*(filesize mod 32767)/32766;
  xn:=x0;
  while length(result)<digit do
    begin
      x0:=lambda*x0*(1-x0);
      xn:=xn+x0;
      seekindex:=trunc(x0*(filesize-1));
      str.Seek(seekindex,soFromBeginning);
      result:=result+ByteToSeg(str.ReadByte);
    end;
end;

function GetLogHash(filename:string;digit:integer):string;
var filestr:TFileStream;
begin
  result:='';
  filestr:=TFileStream.Create(filename,fmOpenRead);
  try
    result:=LogisticHash(filestr,digit);
  finally
    filestr.Free;
  end;
end;


end.

