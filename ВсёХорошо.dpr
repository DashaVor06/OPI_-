program ��������;

uses
  System.SysUtils;

Var
  Words: Text;
  //words - ��� �������
  i, j, Choice : integer;
  //i,j - ������������ ����������
  {choice - ��������� �������� �� 0 �� 3 � ������������ �� ������������� ������������
  0 - ������� ������ � ������� ����������� �� ������������
  1 - 50 �� 50
  2 - ������ �����
  3 - ������� ����}

  player, Chislo_Igrokov, wrong : integer;
  //Player - ����� ��������������� ������
  //Chislo_Igrokov - ����� �������
  //Wrong - ���������� �������� ������

  mas_points, mas_numbers : array of integer;
  //mas_points - ������ ����� �������
  //mas_numbers - ������ ������� ������� ��� ����������� ��������

  Skip : array of boolean;
  //Skip - ������ ��������� ���� ������� ������ �� �����
  CountSkip : integer;
  //CountSkip - ����� ���� ��������� �� �����
  Finish, Next : boolean;
  //Finish - ���� ��� ���������� ��� ����� ��������� � ����������� ��������
  //Next - ����� ������� ���� ������� �����

  wordInDictionary, wordAddedByPlayers, _50_na_50, Help_friend: Boolean;
  //wordInDictionary - ������� ����� � �������
  //wordAddedByPlayers - ����� ���� ������� ��������
  //_50_na_50 - ����� �� ���� ������ ��� ������ �����������
  //Help_friend - ����� �� ���� ������ ��� ������ �����������

  Str,  last_word: String;
  //Str - ������ ��� �������� Choise
  //last_word - - ���������� ���������� �������� �����
  Str1, Str2, Str3, Str0: string;
  //Str1 - ������ ��� ����� 5 ���� ��� 50 �� 50
  //Str2 - ������ ��� ����� �����-�����-����� ��� ������ �����
  //Str3 - ������ ��� �������� ����?
  //Str0 - ������ ��� ����������� ����� ��� choice = 0
  Word, Str_1: String;
  //Word - ����� �� �������
  //Str_1 - ������ ��� ����� �����������
  exist: boolean;
  //exist - ����� ���� � �������

  Bufer: Char;
  //Bufer - �������� ���������� ��� ������ ���� � ������ �����
  Err, point, Randm, Found, vote: Integer;
  //Err - ����� �� �������� ���������� � ������ (��� Val)
  //point - ����� ����������� ��� ��������� ������ �� �����
  //Randm - ����� ��������� ����� �� ����� ����
  //Found - ������� ���� ������ � ������ ������
  //vote - ����� ������� � ����������� �� �������� ����� � �������

  totalBank: String = ('�����������������������������������');
  //totalBank - ����� ���� ����
  playerBank: array [1 .. 3] of String = ('����������','����������','����������');
  //playerBank - ������ ������ ������ �������


//���, ������ ���������
begin
  {������ �������������}
  Writeln ('������� ����� �������: ');
  readln(Chislo_Igrokov);

  SetLength (mas_numbers, Chislo_Igrokov);
  SetLength(mas_points, Chislo_Igrokov);
  SetLength(Skip, Chislo_Igrokov);

  {��������� ������� ������ ������� � ������� ������ +
  ���������� ������� � �������� ������� }
  for i := 0 to Chislo_Igrokov-1 do
  begin
    mas_points[i] := 0;
    mas_numbers[i] := i;
  end;

  // ������������� ����������
  player := 1;
  Finish := false;
  CountSkip := 0;
  last_word := '-';

  wordInDictionary := False;
  wordAddedByPlayers := False;
  _50_na_50 := False;
  Found := 0;
  {����� �������������}

  {���� �1. ������ ���� ��� �� ��������� ��� �� ������}
  repeat

    {���� �1.1. ���������� �� ������� ������ � ������}
    while player <= Chislo_Igrokov do
    Begin

      WriteLn('����� ����� ', player);
      Repeat
        Write('��������� �����/�����������: ');
        ReadLn(Str);
        Val(Str, Choice, Err);
        if (Err <> 0) or (Choice > 3) and (Choice < 0) then
          WriteLn('������������ ������. ��������� ����');
      Until (Err = 0) and (Choice >= 0) or (Choice < 4);

      Wrong := 0;

      {���� �1.1.1. ������ ����� ����� �� ������ ����� �������}
      Repeat
        Next := false;

        //���� ������� ����������� 50 �� 50
        if (Choice = 1) then
        begin

          //�������� ����
          WriteLn('������� ����� (5), ������� ������ ��������');
          ReadLn(Str1);
          Str1 := AnsiUpperCase(Str1);

          if Length(Str1) = 5 then
          begin
            for i := 1 to Length(Str1) do
            begin
              // ��������� ������� ����� � ����� ������
              if Pos(Str1[i], playerBank[player]) > 0 then
                inc(Found);
            end;

            if(Found = 5) then
            begin
              Writeln('�� ������');
              _50_na_50 := true;
              Next := true;
            end
            else
            begin
              WriteLn('������������ ����� ����.');
              inc(Wrong);
            end;

          end
          else
          begin
            WriteLn('������������ ����� ������.');
            inc(Wrong);
          end;

          // ���� ���� ���� �� ����, �� ������������� ������������ ��������,���� ����, �� ������� ����
          if (Length(playerBank[player]) >= 5) and (Length(totalBank) >= 5 ) then
          Begin
            Randomize;
            If _50_na_50 then
            Begin
              // ������ 5 ��������� ���� �� ����� ���� �� ���������
              for i := 1 to 10 do
              Begin
                for j := 1 to Length(Str1) do
                Begin
                  If (playerBank[player, i] = Str1[j]) then
                  Begin
                    // �������� �������� ����� �� ����� ����
                    Randm := Random(Length(totalBank)) + 1;
                    playerBank[player, i] := totalBank[Randm];
                    // �������� ����
                    Delete(Str1, j, 1);
                    Delete(totalBank, Randm, 1);
                    Break;
                  End
                End;
              End;
            End;
          End;
        end;

        //���� ������� ����������� ������ �����
        if (Choice = 2) then
        begin
          //�������� �����
          WriteLn('������� ������ � ������� (����� ������� ���� - ����� ��� ����� -���� ����� ����� ������ � ���� �������) ');
          ReadLn(Str2);
          Str2 := AnsiUpperCase(Str2);
          Help_Friend := False;

          // �������� ����� ������
          if Length(Str2) = 5 then
          begin
            // �������� ������������
            if (Str2[2] = '-') and (Str2[4] = '-') then
            begin
              // �������� ������������ �������
              i := 1;
              while (i <= Length(playerBank[player])) and
                (playerBank[player][i] <> Str2[3]) do
                Inc(i);

              j := 1;
              while (j <= Length(playerBank[StrToInt(Str2[1])])) and
                (playerBank[StrToInt(Str2[1])][j] <> Str2[5]) do
                Inc(j);

              if (i <= Length(playerBank[player])) and (j <= Length(playerBank[StrToInt(Str2[1])])) and
                  (StrToInt(Str2[1]) <> player) then
              begin
                Writeln('�� ������');
                Help_Friend := true;
                Next := true;
              end
              else
                WriteLn('������: ������������ ������ ���� ��� ������.');
                inc(Wrong);
            end
            else
            begin
              WriteLn('������: ������������ ����������� � ������.');
              inc(Wrong);
            end;
          end
          else
          begin
            WriteLn('������: ������������ ����� ������ ��� ������ �����.');
            inc(Wrong);
          end;

          i := 1;
          j := 1;

          If Help_friend then
          Begin
            // ����� ������ ����� ������� ����� �������� � �������� ������
            while playerBank[player][i] <> Str2[3] do
            Begin
              Inc(i);
            End;

            // ����� ������ ����� ������� ����� �������� � ���������� ������
            while playerBank[StrToInt(Str2[1])][j] <> Str2[5] do
            Begin
              Inc(j);
            End;

            // ������ ����� ������� � ������� �������� ����������
            Bufer := playerBank[player][i];
            playerBank[player][i] := playerBank[StrToInt(Str2[1])][j];
            playerBank[StrToInt(Str2[1])][j] := Bufer;
          End;

        end;

        //���� ����� ��������� ��� ������ � ������ ��� ������� ����
        if (Choice = 3) then
        begin
          Str3 := '';
          WriteLn('��������� ���.');
          Next := true;
          Skip[player] := true;
        end;

        //���� ����������� �� ���� ������������ � ������� ������� �����
        if (Choice = 0) then
        begin

          //�������� ����
          Write('��������� �����: ');
          ReadLn(Str0);
          // �������� ��������
          Str0 := Trim(Str0);
          Str0 := AnsiUpperCase(Str0);

          for i := 1 to Length(Str0) do
          begin
            // ��������� ������� ����� � ����� ������
            if Pos(Str0[i], playerBank[player]) > 0 then
              inc(Found);
          end;

          if (Found < length(Str0)) then
          begin
            WriteLn('����� �������� �����, ������� ��� � ����� ������');
            inc(Wrong);
          end
          else
          begin
            // ������� ������������������������
            for i := 1 to Length(Str0) do
              if (Ord(Str0[i]) >= 1072) and (Ord(Str0[i]) <= 1103) then
                Str0[i] := Chr(Ord(Str0[i]) - 32);

            // ��������� ��� ������� ��� ������
            Assign(Words, 'C:\WordList.txt', CP_UTF8);
            Reset(Words);
            Exist := False;

            // ������������� ��� ����� � �������
            while not Eof(Words) do
            begin
              ReadLn(Words, Word);
              // �������� ����� �� ������� � �������
              if Str0 = Word then
                Exist := true;
            end;

            // ���������� ��������
            if Exist then
            begin
              WriteLn('����� ���� � �������');
              WordInDictionary := true;
              Next := true;
            end
            else
            begin
              WriteLn('����� ��� � �������');
              // ���������� ����� � �������
              Vote := 1;
              for j := 1 to (Chislo_Igrokov - 1) do
              begin
                Repeat
                  WriteLn('���� �������� ������� ����� � �������, �� ������� 1.');
                  WriteLn('���� �� �������� ������� ����� � �������, �� ������� 0.');
                  ReadLn(Str_1);
                  Val(Str_1, i, Err);
                  if (Err <> 0) or (i < 0) then
                    WriteLn('������������ ������. ������� 1 ��� 0');
                Until (Err = 0) and ((i = 0) or (i = 1));

                if i = 1 then
                  Vote := Vote + 1;
              End;
              // �������� �������� �������
              if (Vote / Chislo_Igrokov) >= 0.5 then
              begin
                WriteLn('����������� ���������. ����� ����������� � �������.');
                Next := true;
                Append(Words);
                WordAddedByPlayers := true;
              end
              else
              begin
                WriteLn('����������� ���������. ����� �� ����������� � �������.');
                inc(Wrong);
              end;

            end;
            Close(Words);

            // ����� ����� = ����� ������
            point := Length(Str0);

            // ���� ����� ������
            If wordAddedByPlayers or wordInDictionary then
            Begin
              // ���� ���������� � ��� �� �����,� ������� ������������� ����������,�� ���������
              If Str0[1] = last_word[Length(last_word)] then
                point := point * 2;

              // ������� ���-�� ����� � ������
              mas_points[player - 1] := mas_points[player - 1] + point;
            End;

            //���� �� False, �� ����� ������� �� �����
            if (wordAddedByPlayers = False) and (wordInDictionary = False) then
              mas_points[player-1] := mas_points[player-1] - point;

          end;
        end;

      Until (Wrong = 5) or Next;

      //������� � ���������� ������
      Inc(player);

      //���� ��������� ����� ����, �� ���������� ���
      If wordAddedByPlayers or wordInDictionary then
        last_word := Str0
      Else
        last_word := '-';

    End;

    //����� ����� ���������� �����
    for i := 1 to Chislo_Igrokov do
    begin
      if Skip[i] = true then
        inc(CountSkip);
      Skip[i] := false;
    end;

    //���� ��� ��������
    if CountSkip = Chislo_Igrokov then
      Finish := true
    else
    begin
      CountSkip := 0;
      player := 1;
    end;

  until (Finish);
  // ����� �� ����� ����� ��� ������ ���������� ���

  // ����������� ������ � ��������������� ������� �������
  for i := 0 to Chislo_Igrokov-1 do
  begin
    for j := Chislo_Igrokov-1 downto i+1 do
    begin
      if mas_points[j-1] > mas_points[j] then
      begin
        // ����
        mas_points[j] := mas_points[j] + mas_points[j-1];
        mas_points[j-1] := mas_points[j] - mas_points[j-1];
        mas_points[j] := mas_points[j] - mas_points[j-1];
        // ����� �������
        mas_numbers[j] := mas_numbers[j] + mas_numbers[j-1];
        mas_numbers[j-1] := mas_numbers[j] - mas_numbers[j-1];
        mas_numbers[j] := mas_numbers[j] - mas_numbers[j-1];
      end;
    end;
  end;

  // ����� ������ �����������
  Writeln('���� ��������. ������ ����:');
  i := 1;
  Writeln(i, ') ����� ����� ',mas_numbers[Chislo_Igrokov-1],
      ', ������ ', mas_points[Chislo_Igrokov-1], ' ������');
  Dec(Chislo_Igrokov);

  while Chislo_Igrokov > 0 do
  begin
    if mas_points[Chislo_Igrokov] <> mas_points[Chislo_Igrokov - 1] then
      Inc(i);
    Writeln(i, ') ����� ����� ', mas_numbers[Chislo_Igrokov-1],
      ', ������ ', mas_points[Chislo_Igrokov-1], ' ������');
    Dec(Chislo_Igrokov);
  end;

  Readln;
end.
