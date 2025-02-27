unit FScrlXY;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, HUtil32;

type
  TFrmScrollMap = class(TForm)
    X: TLabel;
    Label1: TLabel;
    EdX: TEdit;
    EdY: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
    procedure Execute(var xscr, yscr: integer);
  end;

var
  FrmScrollMap: TFrmScrollMap;

implementation

{$R *.DFM}

procedure TFrmScrollMap.Execute(var xscr, yscr: integer);
begin
  EdX.Text := '';
  EdY.Text := '';

  ShowModal;

  xscr := StrToIntDef(EdX.Text, 0);
  yscr := StrToIntDef(EdY.Text, 0);

end;

procedure TFrmScrollMap.Button1Click(Sender: TObject);
begin
  Close;
end;

end.

