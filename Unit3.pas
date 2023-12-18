unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    LNoP: TLabel;
    up: TButton;
    down: TButton;
    ok: TButton;
    procedure downClick(Sender: TObject);
    procedure upClick(Sender: TObject);
    procedure okClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  NoP: integer;

implementation

{$R *.dfm}

uses Unit4;

procedure TForm3.downClick(Sender: TObject);
begin
  if LNoP.Caption > '2' then
    LNoP.Caption := inttostr(strtoint(LNoP.Caption) - 1)
end;

procedure TForm3.upClick(Sender: TObject);
begin
  if LNoP.Caption < '6' then
    LNoP.Caption := inttostr(strtoint(LNoP.Caption) + 1)
end;

procedure TForm3.okClick(Sender: TObject);
var i:integer;
begin
  Form3.Visible := false;
  form4.Visible := true;
  NoP := strtoint(LNoP.Caption);
  randomize;

  setlength(pBank, NoP);

  for i := 0 to NoP - 1 do
    while length(pBank[i]) < nPBank do
    begin
      rand := 1 + random(32);
      if bank[rand] > 0 then
      begin
        insert(alfovit[rand], pBank[i], 1);
        bank[rand] := bank[rand] - 1;
      end;
    end;

  form4.lBank1.Caption:=pbank[0];
  form4.lBank2.Caption:=pbank[1];
  if NoP > 2 then
  begin
    form4.L3.Visible := true;
    form4.L13.Visible := true;
    form4.pscore3.Visible := true;
    form4.lBank3.Caption:=pbank[2]
  end;

  if NoP > 3 then
  begin
    form4.L4.Visible := true;
    form4.L14.Visible := true;
    form4.pscore4.Visible := true;
    form4.lBank4.Caption:=pbank[3]
  end;

  if NoP > 4 then
  begin
    form4.L5.Visible := true;
    form4.L15.Visible := true;
    form4.pscore5.Visible := true;
    form4.lBank5.Caption:=pbank[4];
  end;

  if NoP > 5 then
  begin
    form4.L6.Visible := true;
    form4.L16.Visible := true;
    form4.pscore6.Visible := true;
    form4.lBank6.Caption:=pbank[5];
  end;

  skip:=0;
  choice:=0;
  vote:=1;
  nbank:=128-10*NoP;
  player:=1;
  wrong:=0;
  setlength(points,NoP);
  lastword:='-';
  setlength(sp1,NoP);
  setlength(sp2,NoP);
  setlength(mas_numbers,NoP);
  for i := 0 to NoP-1 do
  begin
    points[i] := 0;
    mas_numbers[i] := i+1;
  end;

end;

end.
