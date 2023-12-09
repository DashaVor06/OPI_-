unit gulna;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    LabelPN: TLabel;
    upPN: TButton;
    downNP: TButton;
    OK: TButton;
    Label2: TLabel;
    NPCount: TLabel;
    Label3: TLabel;
    Edit: TEdit;
    errorLab: TLabel;
    golos: TButton;
    fiftyF: TButton;
    fHelp: TButton;
    next: TButton;
    Plab1: TLabel;
    Bank1: TLabel;
    Bank2: TLabel;
    PLab2: TLabel;
    PLab3: TLabel;
    Bank3: TLabel;
    Bank4: TLabel;
    Plab4: TLabel;
    PLab5: TLabel;
    Bank5: TLabel;
    Bank6: TLabel;
    PLab6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure upPNClick(Sender: TObject);
    procedure downNPClick(Sender: TObject);
    procedure OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
const
  nBukv=33;
  // количество букв в алфовите
  nPBank=10;
  // максимальный размер банка букв
  alfovit='АЕЁИОУЫЭЮЯБВГДЖЗЙКЛМНПРСТФХЦЧШЩЬЪ';
  // после
var
  Form2: TForm2;
  NPlayers:integer;
  bank: array [1..nBukv] of integer=(8,8,8,8,8,8,8,8,8,8,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4);
  pBank:array of string;
  i,j:integer;
  rand:integer;
  flag:boolean;
  str:string;
  {
   NPlayers- количество игроков
   bank- банк букв, по сути счётчик количество букв, соответвует значению alfovit
   alfovit- алфовит в нужном порядке
   pBank- банк букв игрока, 10 строчных букв
   i,j- параметры циклов
   rand- рандомный символ из алфовита
   flag- шобы было
   str- просто шобы было
  }
implementation

{$R *.dfm}

procedure TForm2.downNPClick(Sender: TObject);
begin
  if labelpn.Caption>'2' then
    labelpn.Caption:=inttostr(strtoint(labelpn.Caption)-1);
end;

procedure TForm2.upPNClick(Sender: TObject);
begin
  if labelpn.Caption<'6' then
    labelpn.Caption:=inttostr(strtoint(labelpn.Caption)+1);
end;


procedure TForm2.OKClick(Sender: TObject);
begin
  NPlayers:=strtoint(labelpn.Caption);
  randomize;
  setlength(pBank,NPlayers);


  for i := 0 to Nplayers-1 do
    while length(pBank[i])<nPBank do
    begin
      rand:=1+random(33);
      if bank[rand]>0 then
      begin
        insert(alfovit[rand],pBank[i],1);
        bank[rand]:=bank[rand]-1;
      end;
    end;


  labelpn.Visible:=false;
  label1.Visible:=false;
  upPN.Visible:=false;
  downNP.Visible:=false;
  OK.Visible:=false;

  Bank1.Caption:=pBank[0];
  Bank2.Caption:=pBank[1];

  NPCount.Visible:=true;
  label3.Visible:=true;
  label2.Visible:=true;
  Edit.Visible:=true;
  fiftyF.Visible:=true;
  fHelp.Visible:=true;
  next.Visible:=true;
  PLab1.Visible:=true;
  Bank1.Visible:=true;
  PLab2.Visible:=true;
  Bank2.Visible:=true;

  if NPlayers>2 then
  begin
    PLab3.Visible:=true;
    Bank3.Caption:=pBank[2];
    Bank3.Visible:=true;
  end;
  if NPlayers>3 then
  begin
    PLab4.Visible:=true;
    Bank4.Caption:=pBank[3];
    Bank4.Visible:=true;
  end;
  if NPlayers>4 then
  begin
    PLab5.Visible:=true;
    Bank5.Caption:=pBank[4];
    Bank5.Visible:=true;
  end;
  if NPlayers>5 then
  begin
    PLab6.Visible:=true;
    Bank6.Caption:=pBank[5];
    Bank6.Visible:=true;
  end;

end;
 {
 что происходит при нажатии на кнопку "Следующий ход"
 варианты
 1) пустая строка
 2) не пустая строка->обработка строки, можете у себя работать
    с любой строковой переменной
  2.1)если слова нет в словаре, то этот кусок запилит Костя,
      т.к. там полностью интерфейсная реализация
 3) перед этим было нажатие 50 на 50
 4) было нажатие помощи друга
 }
end.
