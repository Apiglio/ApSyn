unit apsyn_obj;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  TFileId = string;

  TApSyn = class(TComponent)
  private
    ListenPath:string;
    StorePath:string;

  public //basic function
    procedure init;
    procedure update;

  public //search and display function
    function CreateFileTree:TList;

  protected
    {ListenPath -> StorePath}
    function AddFile(pathname,filename:string):TFileId;

    {StorePath}


    {StorePath -> ListenPath}

  public
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;


  end;

implementation

procedure TApSyn.init;
begin

end;

procedure TApSyn.update;
begin

end;

function TApSyn.CreateFileTree:TList;
begin

end;

function TApSyn.AddFile(pathname,filename:string):TFileId;
begin

end;

constructor TApSyn.Create(AOwner:TComponent);
begin

end;

destructor TApSyn.Destroy;
begin

end;





end.

