Program Modul3;

{ Этот кусок создан для помощи кодерам от Колечки
  Он подключает словарь, проверяет, есть ли введенное
  русское слово в словаре(с учетом регистров) и содержит
  кусок для ввода слова в словарь(слово будет записано в верхнем регистре)
  Надеюсь, будет полезно
  Важно!!!Вам нужно переместить файл WordList на диск C либо изменить в коде расположение файла
}
uses
  SysUtils;

Var
  // добавил для тестов,это должно быть в первом модуле
  bank: String = ('ЙЦУКЕНГШЩЗХХХХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ');

  // массив с очками
  mas_points: array of Integer;

  // пример банка букв для тестов
  bank_bukv: array [1 .. 2] of String = (
    'ЙЦУКЕНГШЩЗ',
    'ФЫВАПРОЛДЖ'
  );

  i, Err, Chislo_Igrokov, number_hodov, point, j, Randm, player, Count: Integer;
  Words: Text;
  Str, Word, Str1, last_word: String;
  Exist, Agree, Enter, _50_na_50, Help_friend: Boolean;
  Bufer: Char;

Begin

  WriteLn('Введите число игроков');
  ReadLn(Chislo_Igrokov);
  // 2й модуль  (добавил чтобы у меня прога компилировалась)

  // Ввод слова
  WriteLn('Введите СЛОВО');
  ReadLn(Str);

 

  // 3й модуль

  // Инициализация переменных для тестов (на практике они должны передаваться сюда из 2го модуля)
  Exist := False;
  Agree := False;
  _50_na_50 := False;
  Enter := False;
  Help_friend := True;
  // номер игрока
  player := 1;

  SetLength(mas_points, Chislo_Igrokov);

  // Если это первый ход,то предыдущего слова нет
  If number_hodov = 1 then
    last_word := '-';

  // Число очков = длине строки
  point := Length(Str);

  // Если слово верное
  If Agree or Exist then
  Begin
    // Если начинается с той же буквы,с которой заканчивается предыдущее,то удваиваем
    If Str[1] = last_word[Length(last_word)] then
      point := point * 2;

    // Заносим кол-во очков в массив
    mas_points[player] := mas_points[player] + point;
  End
  Else
  Begin
    mas_points[player] := mas_points[player] - point;
  End;

  // Если банк букв не пуст, то использование способностей возможно,если пуст, то пропуск хода
  if (Length(bank_bukv[player]) <> 0) and (Length(bank) <> 0) then
  Begin
    Randomize;
    If _50_na_50 then
    Begin
      // Замена 5 выбранных букв из банка букв на рандомные
      for i := 1 to 10 do
      Begin
        for j := 1 to Length(Str) do
        Begin
          If (bank_bukv[player, i] = Str[j]) then
          Begin
            // Рандомно выбираем букву из банка букв ( банк букв я создал для тестов, он должен составляться в первом модуле)
            Randm := Random(Length(bank)) + 1;
            bank_bukv[player, i] := bank[Randm];
            // Удаление букв
            Delete(Str, j, 1);
            Delete(bank, Randm, 1);
            Break;
          End
        End;
      End;


      // вывод чтобы проверить работает ли программа
      For i := 1 to 10 do
        Write(bank_bukv[player][i]);
    End;


    i := 1;
    j := 1;
    If Help_friend then
    Begin
      // Поиск номера буквы которую нужно поменять у текущего игрока
      while bank_bukv[player][i] <> Str[3] do
      Begin
        Inc(i);
      End;

      // Поиск номера буквы которую нужно поменять у текущего игрока
      while bank_bukv[StrToInt(Str[1])][j] <> Str[5] do
      Begin
        Inc(j);
      End;

      // Меняем буквы местами с помощью буферной переменной
      Bufer := bank_bukv[player][i];
      bank_bukv[player][i] := bank_bukv[StrToInt(Str[1])][j];
      bank_bukv[StrToInt(Str[1])][j] := Bufer;
    End;

    // вывод чтобы проверить работает ли программа
    For i := 1 to 10 do
    Begin
      Write(bank_bukv[player][i]);
    End;
    WriteLn;
    For i := 1 to 10 do
    Begin
      Write(bank_bukv[2][i]);
    End;

  End
  Else
    Enter := True;

  // Если игрок нажал Enter
  // Enter не считается за слово
  If Enter then
  Begin
    Inc(player);
    //Подсчёт кол-ва пропусков хода за раунд, но т.к. пока что 3й модуль не в цикле, то это не работает
    //Когда второй модуль добавит это к себе в цикл, то счётчик будет нормально работать
    Inc(Count);
    { Continue }
    // сейчас это не работает т.к. 3й модуль должен быть в цикле,который начинается во втором модуле
    // когда будет подключён второй модуль,уберите сиволы комментария у Continue
  End;

  If Agree or Exist then
    last_word := Str
  Else
    last_word := '-';


  ReadLn;

  End.
