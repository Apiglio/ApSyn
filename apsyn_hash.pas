unit apsyn_hash;

//通过逻辑斯蒂映射的混沌性对文件进行抽样
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

function LogisticHash8(str:TStream):string;
function LogisticHash32(str:TStream):string;
function LogisticHash256(str:TStream):string;

implementation

function ByteToSeg(byt:byte):string;inline;
begin
  result:=IntToHex(byt,2);
end;

function LogisticHash(str:TStream;digit:integer):string;
var x0,xn,lambda:double;
    filesize,seekindex:int64;
begin
  filesize:=str.Size;
  x0:=frac(ln(filesize+2));
  lambda:=3.6+0.4*(filesize mod 32767)/32766;
  result:='';
  xn:=x0;
  while length(result)>=digit do
    begin
      xn:=lambda*xn*(1-xn);
      seekindex:=int64(xn*(filesize-1));
      str.Seek(seekindex,soFromBeginning);
      result:=result+ByteToSeg(str.ReadByte);
    end;
end;

function LogisticHash8(str:TStream):string;inline;
begin
  LogisticHash(str,4);
end;

function LogisticHash32(str:TStream):string;inline;
begin
  LogisticHash(str,16);
end;

function LogisticHash256(str:TStream):string;inline;
begin
  LogisticHash(str,128);
end;


end.

