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
  alfovit = 'ј≈»ќ”џЁёяЅ¬√ƒ∆«… ЋћЌѕ–—“‘’÷„Ўў№Џ';
  nBukv = 32;
  nPBank = 10;

var
  Form4: TForm4;
  bank: array [1 .. nBukv] of integer = (
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    8,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4,
    4
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
    fHelp.Visible := false
  end;
end;

procedure TForm4.fifClick(Sender: TObject);
begin
  if not sp1[player - 1] then
  begin
    choice := 1;
    sp1[player - 1] := not sp1[player - 1];
    fif.Visible := false
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
        wrong := 0
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
        wrong := 0
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
      // ќткрываем наш словарь дл€ чтени€
      Assignfile(words, 'C:\WordList.txt', CP_UTF8);
      Reset(words);
      exist := false;

      // ѕросматриваем все слова в словаре
      while not Eof(words) do
      begin
        ReadLn(words, word);
        // ѕроверка слова на наличие в словаре
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
  /// //////////////
  /// //////////// помощь друга банки
  lBank1.Caption := pBank[0];
  pScore1.Caption := inttostr(points[0]);
  lBank2.Caption := pBank[1];
  pScore2.Caption := inttostr(points[1]);
  if NoP > 2 then
  begin
    lBank3.Caption := pBank[2];
    pscore3.Caption := inttostr(points[2])
  end;
  if NoP > 3 then
  begin
    lBank4.Caption := pBank[3];
    pscore4.Caption := inttostr(points[3])
  end;
  if NoP > 4 then
  begin
    LBank5.Caption := pBank[4];
    pscore5.Caption := inttostr(points[4])
  end;
  if NoP > 5 then
  begin
    lbank6.Caption := pBank[5];
    pscore6.Caption := inttostr(points[5])
  end;

  if not golos then
  begin

    if wrong = 5 then
    begin
      edit.text := '';
      player := player + 1;
      if player > NoP then
        player := 1;
      wrong := 0;
      choice := 0;
      inc(skip);
    end
    else if wrong = 0 then
    begin
      edit.text := '';
      player := player + 1;
      if player > NoP then
        player := 1;
      choice := 0;
    end
    else
      edit.text := '';
  end;

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
          // ќчки
          points[j] := points[j] + points[j - 1];
          points[j - 1] := points[j] - points[j - 1];
          points[j] := points[j] - points[j - 1];
          // ћеста игроков
          mas_numbers[j] := mas_numbers[j] + mas_numbers[j - 1];
          mas_numbers[j - 1] := mas_numbers[j] - mas_numbers[j - 1];
          mas_numbers[j] := mas_numbers[j] - mas_numbers[j - 1];
        end;
      end;
    end;

  end;
  pNum.Caption := inttostr(player);

  if sp1[player - 1] = false then
    fif.Visible := true
  else
    fif.Visible := false;

  if sp2[player - 1] = false then
    fHelp.Visible := true
  else
    fHelp.Visible := false;

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

  edit.Visible := true;
  fif.Visible := true;
  fHelp.Visible := true;

  lBank1.Caption := pBank[0];
  pScore1.Caption := inttostr(points[0]);
  lBank2.Caption := pBank[1];
  pScore2.Caption := inttostr(points[1]);
  if NoP > 2 then
  begin
    lBank3.Caption := pBank[2];
    pscore3.Caption := inttostr(points[2])
  end;
  if NoP > 3 then
  begin
    lBank4.Caption := pBank[3];
    pscore4.Caption := inttostr(points[3])
  end;
  if NoP > 4 then
  begin
    LBank5.Caption := pBank[4];
    pscore5.Caption := inttostr(points[4])
  end;
  if NoP > 5 then
  begin
    lbank6.Caption := pBank[5];
    pscore6.Caption := inttostr(points[5])
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

  pNum.Caption := inttostr(player);
  StopGolos.Visible := false;
  Label10.Caption := lastword;
end;

end.
