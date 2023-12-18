unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
  Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    label2: TLabel;
    pNum: TLabel;
    Label3: TLabel;
    edit: TEdit;
    fif: TButton;
    fHelp: TButton;
    next: TButton;
    Label1: TLabel;
    lBank1: TLabel;
    Label5: TLabel;
    pScore1: TLabel;
    Label4: TLabel;
    lBank2: TLabel;
    Label7: TLabel;
    pScore2: TLabel;
    L3: TLabel;
    lBank3: TLabel;
    L13: TLabel;
    pscore3: TLabel;
    L4: TLabel;
    lBank4: TLabel;
    L14: TLabel;
    pscore4: TLabel;
    L5: TLabel;
    LBank5: TLabel;
    L15: TLabel;
    pscore5: TLabel;
    L6: TLabel;
    lbank6: TLabel;
    L16: TLabel;
    pscore6: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    StopGolos: TButton;
    Oshibka: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure nextClick(Sender: TObject);
    procedure fifClick(Sender: TObject);
    procedure fHelpClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure StopGolosClick(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  alfovit = 'АЕИОУЫЭЮЯБВГДЖЗЙКЛМНПРСТФХЦЧШЩЬЪ';
  nBukv = 32;
  nPBank = 10;

var
  Form4: TForm4;
  bank: array [1 .. nBukv] of integer = (
    10,
    9,
    8,
    10,
    3,
    2,
    1,
    1,
    3,
    3,
    5,
    3,
    5,
    2,
    2,
    4,
    6,
    4,
    5,
    8,
    6,
    6,
    6,
    5,
    1,
    2,
    1,
    2,
    1,
    1,
    1,
    2
  );
  pBank: array of string;
  i, j: integer;
  nbank: integer;
  rand: integer;
  str: string;
  choice: integer;
  skip: integer;
  player: integer;
  exist: boolean;
  Bufer: string;
  wrong, vote: integer;
  words: text;
  word: string;
  golos: boolean;
  points: array of integer;
  lastword: string;
  sp1: array of boolean;
  sp2: array of boolean;
  mas_numbers: array of integer;
  PoN: integer;
  FlagFh, FlagFif: boolean;

implementation

{$R *.dfm}

uses unit3, unit5;

procedure TForm4.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked = true then
    inc(vote)
  else
    dec(vote)
end;

procedure TForm4.fHelpClick(Sender: TObject);
begin
  if not sp2[player - 1] then
  begin
    choice := 2;
    sp2[player - 1] := not sp2[player - 1];
    fHelp.Visible := false;
    fif.Visible := false;
    lBank1.Visible := true;
    lBank2.Visible := true;
    lBank3.Visible := true;
    lBank4.Visible := true;
    LBank5.Visible := true;
    lbank6.Visible := true;
    FlagFh := true
  end;
end;

procedure TForm4.fifClick(Sender: TObject);
begin
  if not sp1[player - 1] then
  begin
    choice := 1;
    sp1[player - 1] := not sp1[player - 1];
    fif.Visible := false;
    fHelp.Visible := false;
    FlagFif := true;
  end;
end;

procedure TForm4.nextClick(Sender: TObject);
var
  i, j: integer;
begin
  str := Trim(AnsiUpperCase(edit.text));
  golos := false;
  Oshibka.Visible := false;
  if (choice = 0) and (str = '') then
  begin
    inc(skip);
    wrong := 0
  end;
  if choice = 1 then
  begin
    if (length(str) = 5) and (length(pBank[player - 1]) >= 5) and (nbank >= 5)
    then
    begin
      Bufer := pBank[player - 1];
      i := 1;
      while (i <= 5) and (Pos(str[i], Bufer) > 0) do
      begin
        delete(Bufer, Pos(str[i], Bufer), 1);
        i := i + 1
      end;

      if i = 6 then
      begin
        pBank[player - 1] := Bufer;
        while length(pBank[player - 1]) < 10 do
        begin
          rand := 1 + random(32);
          if bank[rand] > 0 then
          begin
            insert(alfovit[rand], pBank[player - 1], 1);
            bank[rand] := bank[rand] - 1;
          end;
        end;
        nbank := nbank - 5;
        skip := 0;
        points[player - 1] := points[player - 1] - 2;
        wrong := 0;
      end
      else
      begin
        inc(wrong);
        points[player - 1] := points[player - 1] - length(str);
        Oshibka.Visible := true
      end;
    end
    else
    begin
      inc(wrong);
      points[player - 1] := points[player - 1] - length(str);
      Oshibka.Visible := true
    end;
  end;

  if choice = 2 then
  begin
    if (length(str) = 5) and (str[2] = '-') and (str[4] = '-') and
      ((strtoint(str[1]) in [1 .. NoP]) and (strtoint(str[1]) <> player)) then
    begin
      i := 1;
      while (i <= length(pBank[player - 1])) and
        (pBank[player - 1][i] <> str[3]) do
        inc(i);

      j := 1;
      while (j <= length(pBank[strtoint(str[1]) - 1])) and
        (pBank[strtoint(str[1]) - 1][j] <> str[5]) do
        inc(j);

      if (i <= length(pBank[player - 1])) and
        (j <= length(pBank[strtoint(str[1]) - 1])) and
        (strtoint(str[1]) <> player) then
      begin
        Bufer := pBank[player - 1][i];
        pBank[player - 1][i] := pBank[strtoint(str[1]) - 1][j];
        pBank[strtoint(str[1]) - 1][j] := Bufer[1];
        wrong := 0;
        case strtoint(str[1]) of
          1:
            lBank1.Caption := pBank[0];
          2:
            lBank2.Caption := pBank[1];
          3:
            lBank3.Caption := pBank[2];
          4:
            lBank4.Caption := pBank[3];
          5:
            LBank5.Caption := pBank[4];
          6:
            lbank6.Caption := pBank[5];
        end;
      end
      else
      begin
        inc(wrong);
        Oshibka.Visible := true;
      end;
    end
    else
    begin
      inc(wrong);
      Oshibka.Visible := true;
    end;
  end;

  if (choice = 0) and (str <> '') then
  begin
    Bufer := pBank[player - 1];
    i := 1;
    while (i <= length(str)) and (Pos(str[i], Bufer) > 0) do
    begin
      delete(Bufer, Pos(str[i], Bufer), 1);
      i := i + 1
    end;

    if i = length(str) + 1 then
    begin
      // Открываем наш словарь для чтения
      Assignfile(words, 'C:\WordList.txt', CP_UTF8);
      Reset(words);
      exist := false;

      // Просматриваем все слова в словаре
      while not Eof(words) do
      begin
        ReadLn(words, word);
        // Проверка слова на наличие в словаре
        if str = word then
          exist := true;
      end;

      // слово в словарь, вывод на экран слова
      if exist = true then
      begin
        if str[1] = lastword[length(lastword)] then
          points[player - 1] := points[player - 1] + length(str) * 2
        else
          points[player - 1] := points[player - 1] + length(str);

        lastword := str;
        pBank[player - 1] := Bufer;
        while (length(pBank[player - 1]) < nPBank) and (nbank > 0) do
        begin
          rand := 1 + random(32);
          if bank[rand] > 0 then
          begin
            insert(alfovit[rand], pBank[player - 1], 1);
            bank[rand] := bank[rand] - 1;
            nbank := nbank - 1
          end;
        end;
        closefile(words);
        wrong := 0
      end
      else
      begin
        vote := 1;
        if player <> 1 then
          CheckBox1.Visible := true;
        if (player <> 2) then
          CheckBox2.Visible := true;

        if (NoP > 2) and (player <> 3) then
          CheckBox3.Visible := true;
        if (NoP > 3) and (player <> 4) then
          CheckBox4.Visible := true;
        if (NoP > 4) and (player <> 5) then
          CheckBox5.Visible := true;
        if (NoP > 5) and (player <> 6) then
          CheckBox6.Visible := true;

        StopGolos.Visible := true;
        golos := true;
        Label6.Visible := false;
        Label8.Visible := false;
        edit.Visible := false;
        fif.Visible := false;
        fHelp.Visible := false;
      end;
    end
    else
    begin
      inc(wrong);
      points[player - 1] := points[player - 1] - length(str);
      Oshibka.Visible := true
    end;
  end;

  case player of
    1:
      begin
        lBank1.Caption := pBank[0];
        pScore1.Caption := inttostr(points[0]);
      end;
    2:
      begin
        lBank2.Caption := pBank[1];
        pScore2.Caption := inttostr(points[1]);
      end;
    3:
      begin
        lBank3.Caption := pBank[2];
        pscore3.Caption := inttostr(points[2]);
      end;
    4:
      begin
        lBank4.Caption := pBank[3];
        pscore4.Caption := inttostr(points[3])
      end;
    5:
      begin
        LBank5.Caption := pBank[4];
        pscore5.Caption := inttostr(points[4])
      end;
    6:
      begin
        lbank6.Caption := pBank[5];
        pscore6.Caption := inttostr(points[5])
      end;
  end;

  if not golos then
  begin
    edit.text := '';
    if wrong = 5 then
    begin
      player := player + 1;
      if player > NoP then
        player := 1;
      wrong := 0;
      choice := 0;
      inc(skip);
      if flagfh or flagfif then
        dec(player);
      flagfh:=false;
      flagfif:=false;
    end
    else if wrong = 0 then
    begin
      player := player + 1;
      if player > NoP then
        player := 1;
      choice := 0;
      if flagfh or flagfif then
        dec(player);
      flagfh:=false;
      flagfif:=false;
    end
  end;
  pNum.Caption := inttostr(player);

  if skip = NoP then
  begin
    Form4.Visible := false;
    Form5.Visible := true;
    for i := 0 to NoP - 1 do
    begin
      for j := NoP - 1 downto i + 1 do
      begin
        if points[j - 1] > points[j] then
        begin
          // Очки
          points[j] := points[j] + points[j - 1];
          points[j - 1] := points[j] - points[j - 1];
          points[j] := points[j] - points[j - 1];
          // Места игроков
          mas_numbers[j] := mas_numbers[j] + mas_numbers[j - 1];
          mas_numbers[j - 1] := mas_numbers[j] - mas_numbers[j - 1];
          mas_numbers[j] := mas_numbers[j] - mas_numbers[j - 1];
        end;
      end;
    end;

    PoN := NoP;
    i := 1;
    Form5.pnum1.Caption := inttostr(mas_numbers[NoP - 1]);
    Form5.sc1.Caption := inttostr(points[NoP - 1]);
    dec(NoP);

    if points[NoP] <> points[NoP - 1] then
      inc(i);

    Form5.pnum2.Caption := inttostr(mas_numbers[NoP - 1]);
    Form5.sc2.Caption := inttostr(points[NoP - 1]);
    Form5.pl2.Caption := inttostr(i);
    dec(NoP);

    if PoN > 2 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum3.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc3.Caption := inttostr(points[NoP - 1]);
      Form5.pl3.Caption := inttostr(i);
      Form5.pnum3.Visible := true;
      Form5.sc3.Visible := true;
      Form5.pl3.Visible := true;
      dec(NoP);
    end;
    if PoN > 3 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum4.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc4.Caption := inttostr(points[NoP - 1]);
      Form5.pl4.Caption := inttostr(i);
      Form5.pnum4.Visible := true;
      Form5.sc4.Visible := true;
      Form5.pl4.Visible := true;
      dec(NoP);
    end;
    if PoN > 4 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum5.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc5.Caption := inttostr(points[NoP - 1]);
      Form5.pl5.Caption := inttostr(i);
      Form5.pnum5.Visible := true;
      Form5.sc5.Visible := true;
      Form5.pl5.Visible := true;
      dec(NoP);
    end;
    if PoN > 5 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum6.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc6.Caption := inttostr(points[NoP - 1]);
      Form5.pl6.Caption := inttostr(i);
      Form5.pnum6.Visible := true;
      Form5.sc6.Visible := true;
      Form5.pl6.Visible := true;
      dec(NoP);
    end;
  end;

  if not golos then
  begin
    if sp1[player - 1] = false then
      fif.Visible := true
    else
      fif.Visible := false;

    if sp2[player - 1] = false then
      fHelp.Visible := true
    else
      fHelp.Visible := false;

    if not FlagFh then
    begin
      lBank1.Visible := false;
      lBank2.Visible := false;
      lBank3.Visible := false;
      lBank4.Visible := false;
      LBank5.Visible := false;
      lbank6.Visible := false;
    end
    else
      fif.Visible:=false;

    if flagFif then
      fHelp.Visible:=false;

    case player of
      1:
        lBank1.Visible := true;
      2:
        lBank2.Visible := true;
      3:
        lBank3.Visible := true;
      4:
        lBank4.Visible := true;
      5:
        LBank5.Visible := true;
      6:
        lbank6.Visible := true;
    end;
  end;

  vote := 1;
  Label10.Caption := lastword;
end;

procedure TForm4.StopGolosClick(Sender: TObject);
begin
  if ((vote * 2 >= NoP) and (NoP > 2)) or ((vote = 2) and (NoP = 2)) then
  begin
    if str[1] = lastword[length(lastword)] then
      points[player - 1] := points[player - 1] + length(str) * 2
    else
      points[player - 1] := points[player - 1] + length(str);

    pBank[player - 1] := Bufer;
    while (length(pBank[player - 1]) < nPBank) and (nbank > 0) do
    begin
      rand := 1 + random(32);
      if bank[rand] > 0 then
      begin
        insert(alfovit[rand], pBank[player - 1], 1);
        bank[rand] := bank[rand] - 1;
        nbank := nbank - 1
      end;
    end;
    lastword := str;
    wrong := 0;
    Append(words);
    Writeln(words, str);
    closefile(words);
  end
  else
  begin
    points[player - 1] := points[player - 1] - length(str);
    inc(wrong)
  end;

  CheckBox1.Visible := false;
  CheckBox2.Visible := false;
  CheckBox3.Visible := false;
  CheckBox4.Visible := false;
  CheckBox5.Visible := false;
  CheckBox6.Visible := false;
  case player of
    1:
      begin
        lBank1.Caption := pBank[0];
        pScore1.Caption := inttostr(points[0]);
      end;
    2:
      begin
        lBank2.Caption := pBank[1];
        pScore2.Caption := inttostr(points[1]);
      end;
    3:
      begin
        lBank3.Caption := pBank[2];
        pscore3.Caption := inttostr(points[2]);
      end;
    4:
      begin
        lBank4.Caption := pBank[3];
        pscore4.Caption := inttostr(points[3])
      end;
    5:
      begin
        LBank5.Caption := pBank[4];
        pscore5.Caption := inttostr(points[4])
      end;
    6:
      begin
        lbank6.Caption := pBank[5];
        pscore6.Caption := inttostr(points[5])
      end;
  end;

  if wrong = 5 then
  begin
    edit.text := '';
    player := player + 1;
    if player > NoP then
      player := 1;
    wrong := 0;
    inc(skip)
  end
  else if wrong = 0 then
  begin
    edit.text := '';
    player := player + 1;
    if player > NoP then
      player := 1;
  end
  else
  begin
    edit.text := '';
    Oshibka.Visible := true
  end;

  CheckBox1.Checked := false;
  CheckBox2.Checked := false;
  CheckBox3.Checked := false;
  CheckBox4.Checked := false;
  CheckBox5.Checked := false;
  CheckBox6.Checked := false;

  pNum.Caption := inttostr(player);
  StopGolos.Visible := false;
  if sp1[player - 1] = false then
    fif.Visible := true
  else
    fif.Visible := false;

  if sp2[player - 1] = false then
    fHelp.Visible := true
  else
    fHelp.Visible := false;

  lBank1.Visible := false;
  lBank2.Visible := false;
  lBank3.Visible := false;
  lBank4.Visible := false;
  LBank5.Visible := false;
  lbank6.Visible := false;

  case player of
    1:
      lBank1.Visible := true;
    2:
      lBank2.Visible := true;
    3:
      lBank3.Visible := true;
    4:
      lBank4.Visible := true;
    5:
      LBank5.Visible := true;
    6:
      lbank6.Visible := true;
  end;

  Label6.Visible := true;
  Label8.Visible := true;
  Label10.Caption := lastword;
  edit.Visible := true;
  vote := 1;

  if skip = NoP then
  begin
    Form4.Visible := false;
    Form5.Visible := true;
    for i := 0 to NoP - 1 do
    begin
      for j := NoP - 1 downto i + 1 do
      begin
        if points[j - 1] > points[j] then
        begin
          // Очки
          points[j] := points[j] + points[j - 1];
          points[j - 1] := points[j] - points[j - 1];
          points[j] := points[j] - points[j - 1];
          // Места игроков
          mas_numbers[j] := mas_numbers[j] + mas_numbers[j - 1];
          mas_numbers[j - 1] := mas_numbers[j] - mas_numbers[j - 1];
          mas_numbers[j] := mas_numbers[j] - mas_numbers[j - 1];
        end;
      end;
    end;

    PoN := NoP;
    i := 1;
    Form5.pnum1.Caption := inttostr(mas_numbers[NoP - 1]);
    Form5.sc1.Caption := inttostr(points[NoP - 1]);
    dec(NoP);

    if points[NoP] <> points[NoP - 1] then
      inc(i);

    Form5.pnum2.Caption := inttostr(mas_numbers[NoP - 1]);
    Form5.sc2.Caption := inttostr(points[NoP - 1]);
    Form5.pl2.Caption := inttostr(i);
    dec(NoP);

    if PoN > 2 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum3.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc3.Caption := inttostr(points[NoP - 1]);
      Form5.pl3.Caption := inttostr(i);
      Form5.pnum3.Visible := true;
      Form5.sc3.Visible := true;
      Form5.pl3.Visible := true;
      dec(NoP);
    end;
    if PoN > 3 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum4.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc4.Caption := inttostr(points[NoP - 1]);
      Form5.pl4.Caption := inttostr(i);
      Form5.pnum4.Visible := true;
      Form5.sc4.Visible := true;
      Form5.pl4.Visible := true;
      dec(NoP);
    end;
    if PoN > 4 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum5.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc5.Caption := inttostr(points[NoP - 1]);
      Form5.pl5.Caption := inttostr(i);
      Form5.pnum5.Visible := true;
      Form5.sc5.Visible := true;
      Form5.pl5.Visible := true;
      dec(NoP);
    end;
    if PoN > 5 then
    begin
      if points[NoP] <> points[NoP - 1] then
        inc(i);
      Form5.pnum6.Caption := inttostr(mas_numbers[NoP - 1]);
      Form5.sc6.Caption := inttostr(points[NoP - 1]);
      Form5.pl6.Caption := inttostr(i);
      Form5.pnum6.Visible := true;
      Form5.sc6.Visible := true;
      Form5.pl6.Visible := true;
      dec(NoP);
    end;
  end;
end;

end.
