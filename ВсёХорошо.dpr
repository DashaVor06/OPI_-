program ВсёХорошо;

uses
  System.SysUtils;

Var
  Words: Text;
  //words - наш словарь
  i, j, Choice : integer;
  //i,j - итерационные переменные
  {choice - принимает значения от 0 до 3 в звывисимости от использования способностей
  0 - введена строка и никакая способность не используется
  1 - 50 на 50
  2 - помощь друга
  3 - пропуск хода}

  player, Chislo_Igrokov, wrong : integer;
  //Player - номер обрабатываемого игрока
  //Chislo_Igrokov - число игроков
  //Wrong - количество неверных вводов

  mas_points, mas_numbers : array of integer;
  //mas_points - массив очков игроков
  //mas_numbers - массив номеров игроков для составления рейтинга

  Skip : array of boolean;
  //Skip - массив пропусков хода каждого игрока за раунд
  CountSkip : integer;
  //CountSkip - число всех пропусков за раунд
  Finish, Next : boolean;
  //Finish - если все пропустили ход тогда переходим к составлению рейтинга
  //Next - слово игроком было введено верно

  wordInDictionary, wordAddedByPlayers, _50_na_50, Help_friend: Boolean;
  //wordInDictionary - наличие слова в словаре
  //wordAddedByPlayers - слово было принято игроками
  //_50_na_50 - верен ли ввод строки для данной способности
  //Help_friend - верен ли ввод строки для данной способности

  Str,  last_word: String;
  //Str - спрока для проверки Choise
  //last_word - - запоминает предыдущее введённое слово
  Str1, Str2, Str3, Str0: string;
  //Str1 - строка для ввода 5 букв для 50 на 50
  //Str2 - строка для ввода номер-буква-буква для Помощь друга
  //Str3 - строка для пропуска хода?
  //Str0 - строка для нормального слова при choice = 0
  Word, Str_1: String;
  //Word - слово из словаря
  //Str_1 - строка для ввода голосования
  exist: boolean;
  //exist - слово есть в словаре

  Bufer: Char;
  //Bufer - буферная переменная для обмена букв в Помощь друга
  Err, point, Randm, Found, vote: Integer;
  //Err - номер не числовой переменной с строке (для Val)
  //point - число добавляемых или снимаемых баллов за слово
  //Randm - номер рандомной буквы из банка букв
  //Found - сколько букв сопало с личным банком
  //vote - число голосов в голосовании за введение слова в словарь

  totalBank: String = ('ЙЦУКЕНГШЩЗХХХХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ');
  //totalBank - общий банк букв
  playerBank: array [1 .. 3] of String = ('ЙЦУКЕНГШЩЗ','ФЫВАПРОЛДЖ','ЯЧСМИТЬБЮЭ');
  //playerBank - массив личных банков игроков


//Ура, начало программы
begin
  {Начало инициализации}
  Writeln ('Введите число игроков: ');
  readln(Chislo_Igrokov);

  SetLength (mas_numbers, Chislo_Igrokov);
  SetLength(mas_points, Chislo_Igrokov);
  SetLength(Skip, Chislo_Igrokov);

  {Зануление массива баллов игроков и массива скипов +
  заполнение массива с номерами игроков }
  for i := 0 to Chislo_Igrokov-1 do
  begin
    mas_points[i] := 0;
    mas_numbers[i] := i;
  end;

  // Инициализация переменных
  player := 1;
  Finish := false;
  CountSkip := 0;
  last_word := '-';

  wordInDictionary := False;
  wordAddedByPlayers := False;
  _50_na_50 := False;
  Found := 0;
  {конец инициализации}

  {Цикл А1. Повтор пока все не пропустят ход на раунде}
  repeat

    {Цикл А1.1. Проходится по каждому игроку в раунде}
    while player <= Chislo_Igrokov do
    Begin

      WriteLn('Игрок номер ', player);
      Repeat
        Write('Введенное слово/способность: ');
        ReadLn(Str);
        Val(Str, Choice, Err);
        if (Err <> 0) or (Choice > 3) and (Choice < 0) then
          WriteLn('Некорректные данные. Повторите ввод');
      Until (Err = 0) and (Choice >= 0) or (Choice < 4);

      Wrong := 0;

      {Цикл А1.1.1. Повтор ввода слова не больше числа игроков}
      Repeat
        Next := false;

        //Если выбрана способность 50 на 50
        if (Choice = 1) then
        begin

          //Проверка Саши
          WriteLn('Введите буквы (5), которые хотите заменить');
          ReadLn(Str1);
          Str1 := AnsiUpperCase(Str1);

          if Length(Str1) = 5 then
          begin
            for i := 1 to Length(Str1) do
            begin
              // Проверяем наличие буквы в банке игрока
              if Pos(Str1[i], playerBank[player]) > 0 then
                inc(Found);
            end;

            if(Found = 5) then
            begin
              Writeln('Всё хорошо');
              _50_na_50 := true;
              Next := true;
            end
            else
            begin
              WriteLn('Некорректная набор букв.');
              inc(Wrong);
            end;

          end
          else
          begin
            WriteLn('Некорректный длина строки.');
            inc(Wrong);
          end;

          // Если банк букв не пуст, то использование способностей возможно,если пуст, то пропуск хода
          if (Length(playerBank[player]) >= 5) and (Length(totalBank) >= 5 ) then
          Begin
            Randomize;
            If _50_na_50 then
            Begin
              // Замена 5 выбранных букв из банка букв на рандомные
              for i := 1 to 10 do
              Begin
                for j := 1 to Length(Str1) do
                Begin
                  If (playerBank[player, i] = Str1[j]) then
                  Begin
                    // Рандомно выбираем букву из банка букв
                    Randm := Random(Length(totalBank)) + 1;
                    playerBank[player, i] := totalBank[Randm];
                    // Удаление букв
                    Delete(Str1, j, 1);
                    Delete(totalBank, Randm, 1);
                    Break;
                  End
                End;
              End;
            End;
          End;
        end;

        //Если выбрана способность Помощь друга
        if (Choice = 2) then
        begin
          //Проверка Сашии
          WriteLn('Введите строку в формате (Номер игрока– Тире - Буква его банка -Тире– Буква банка игрока с этим номером) ');
          ReadLn(Str2);
          Str2 := AnsiUpperCase(Str2);
          Help_Friend := False;

          // Проверка длины строки
          if Length(Str2) = 5 then
          begin
            // Проверка разделителей
            if (Str2[2] = '-') and (Str2[4] = '-') then
            begin
              // Проверка корректности номеров
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
                Writeln('Всё хорошо');
                Help_Friend := true;
                Next := true;
              end
              else
                WriteLn('Ошибка: Некорректные номера букв для замены.');
                inc(Wrong);
            end
            else
            begin
              WriteLn('Ошибка: Некорректные разделители в строке.');
              inc(Wrong);
            end;
          end
          else
          begin
            WriteLn('Ошибка: Некорректная длина строки для замены буквы.');
            inc(Wrong);
          end;

          i := 1;
          j := 1;

          If Help_friend then
          Begin
            // Поиск номера буквы которую нужно поменять у текущего игрока
            while playerBank[player][i] <> Str2[3] do
            Begin
              Inc(i);
            End;

            // Поиск номера буквы которую нужно поменять у выбранного игрока
            while playerBank[StrToInt(Str2[1])][j] <> Str2[5] do
            Begin
              Inc(j);
            End;

            // Меняем буквы местами с помощью буферной переменной
            Bufer := playerBank[player][i];
            playerBank[player][i] := playerBank[StrToInt(Str2[1])][j];
            playerBank[StrToInt(Str2[1])][j] := Bufer;
          End;

        end;

        //Если игрок пропустил ход ставим в масиве ему пропуск хода
        if (Choice = 3) then
        begin
          Str3 := '';
          WriteLn('Следующий ход.');
          Next := true;
          Skip[player] := true;
        end;

        //Если способности не были использованы и введено обычное слово
        if (Choice = 0) then
        begin

          //Проверка Саши
          Write('Введенное слово: ');
          ReadLn(Str0);
          // Удаление пробелов
          Str0 := Trim(Str0);
          Str0 := AnsiUpperCase(Str0);

          for i := 1 to Length(Str0) do
          begin
            // Проверяем наличие буквы в банке игрока
            if Pos(Str0[i], playerBank[player]) > 0 then
              inc(Found);
          end;

          if (Found < length(Str0)) then
          begin
            WriteLn('Слово содержит буквы, которых нет в банке игрока');
            inc(Wrong);
          end
          else
          begin
            // Убираем регистрочувствительность
            for i := 1 to Length(Str0) do
              if (Ord(Str0[i]) >= 1072) and (Ord(Str0[i]) <= 1103) then
                Str0[i] := Chr(Ord(Str0[i]) - 32);

            // Открываем наш словарь для чтения
            Assign(Words, 'C:\WordList.txt', CP_UTF8);
            Reset(Words);
            Exist := False;

            // Просматриваем все слова в словаре
            while not Eof(Words) do
            begin
              ReadLn(Words, Word);
              // Проверка слова на наличие в словаре
              if Str0 = Word then
                Exist := true;
            end;

            // Дальнейшие действия
            if Exist then
            begin
              WriteLn('Слово есть в словаре');
              WordInDictionary := true;
              Next := true;
            end
            else
            begin
              WriteLn('Слова нет в словаре');
              // Добавление слова в словарь
              Vote := 1;
              for j := 1 to (Chislo_Igrokov - 1) do
              begin
                Repeat
                  WriteLn('Если согласны занести слово в словарь, то введите 1.');
                  WriteLn('Если не согласны занести слово в словарь, то введите 0.');
                  ReadLn(Str_1);
                  Val(Str_1, i, Err);
                  if (Err <> 0) or (i < 0) then
                    WriteLn('Некорректный формат. Введите 1 или 0');
                Until (Err = 0) and ((i = 0) or (i = 1));

                if i = 1 then
                  Vote := Vote + 1;
              End;
              // Согласие половины игроков
              if (Vote / Chislo_Igrokov) >= 0.5 then
              begin
                WriteLn('Голосование завершено. Слово добавляется в словарь.');
                Next := true;
                Append(Words);
                WordAddedByPlayers := true;
              end
              else
              begin
                WriteLn('Голосование завершено. Слово не добавляется в словарь.');
                inc(Wrong);
              end;

            end;
            Close(Words);

            // Число очков = длине строки
            point := Length(Str0);

            // Если слово верное
            If wordAddedByPlayers or wordInDictionary then
            Begin
              // Если начинается с той же буквы,с которой заканчивается предыдущее,то удваиваем
              If Str0[1] = last_word[Length(last_word)] then
                point := point * 2;

              // Заносим кол-во очков в массив
              mas_points[player - 1] := mas_points[player - 1] + point;
            End;

            //Если всё False, то слово введено не верно
            if (wordAddedByPlayers = False) and (wordInDictionary = False) then
              mas_points[player-1] := mas_points[player-1] - point;

          end;
        end;

      Until (Wrong = 5) or Next;

      //Переход к следующему игроку
      Inc(player);

      //Если последнее слово есть, то запоминаем его
      If wordAddedByPlayers or wordInDictionary then
        last_word := Str0
      Else
        last_word := '-';

    End;

    //Подсёт числа скипнувших людей
    for i := 1 to Chislo_Igrokov do
    begin
      if Skip[i] = true then
        inc(CountSkip);
      Skip[i] := false;
    end;

    //Если все скипнули
    if CountSkip = Chislo_Igrokov then
      Finish := true
    else
    begin
      CountSkip := 0;
      player := 1;
    end;

  until (Finish);
  // Выход из цикла когда все игроки пропустили ход

  // Сортировака баллов и соответствующих номеров игроков
  for i := 0 to Chislo_Igrokov-1 do
  begin
    for j := Chislo_Igrokov-1 downto i+1 do
    begin
      if mas_points[j-1] > mas_points[j] then
      begin
        // Очки
        mas_points[j] := mas_points[j] + mas_points[j-1];
        mas_points[j-1] := mas_points[j] - mas_points[j-1];
        mas_points[j] := mas_points[j] - mas_points[j-1];
        // Места игроков
        mas_numbers[j] := mas_numbers[j] + mas_numbers[j-1];
        mas_numbers[j-1] := mas_numbers[j] - mas_numbers[j-1];
        mas_numbers[j] := mas_numbers[j] - mas_numbers[j-1];
      end;
    end;
  end;

  // Вывод списка победителей
  Writeln('Игра окончена. Список мест:');
  i := 1;
  Writeln(i, ') Занял Игрок ',mas_numbers[Chislo_Igrokov-1],
      ', набрав ', mas_points[Chislo_Igrokov-1], ' баллов');
  Dec(Chislo_Igrokov);

  while Chislo_Igrokov > 0 do
  begin
    if mas_points[Chislo_Igrokov] <> mas_points[Chislo_Igrokov - 1] then
      Inc(i);
    Writeln(i, ') Занял Игрок ', mas_numbers[Chislo_Igrokov-1],
      ', набрав ', mas_points[Chislo_Igrokov-1], ' баллов');
    Dec(Chislo_Igrokov);
  end;

  Readln;
end.
