program Module4;

uses
  SysUtils;

Var
  Count : integer;
  i : integer;
  Player, Chislo_Igrokov : integer;
  mas_points, mas_numbers : array of integer;
{
Count - число пропусков хода
i - итерационна€ переменна€ + номер места победител€
Player - номер обрабатываемого игрока
Chislo_Igrokov - число игроков
mas_points - массив очков игроков
mas_numbers - массив номеров игроков дл€ составлени€ рейтинга
}

begin
  {Ќачало инициализации}
  SetLength (mas_numbers, Chislo_Igrokov);

  // «ануление массива баллов игроков и заполнение массива с номерами игроков
  for i := 1 to Chislo_Igrokov do
  begin
    mas_points[i] := 0;
    mas_numbers[i] := i;
  end;
  {конец инициализации}


  repeat
    //„исло пустых строк
    Count := 0;

    {—юда весь второй и третий модуль}




    // ¬ конце 3 модул€
    // ѕереход от последнего игрока к первому
    if player = Chislo_Igrokov + 1 then
      player := 1;

  until (Count = Chislo_Igrokov);
  // ¬ыход из цикла когда все игроки пропустили ход

  // —ортировака баллов и соответствующих номеров игроков
  for i := 1 to Chislo_Igrokov do
  begin
    for var j := Chislo_Igrokov downto i + 1 do
    begin
      if mas_points[j-1] > mas_points[j] then
      begin
        // ќчки
        mas_points[j] := mas_points[j] + mas_points[j-1];
        mas_points[j-1] := mas_points[j] - mas_points[j-1];
        mas_points[j] := mas_points[j] - mas_points[j-1];
        // ћеста игроков
        mas_numbers[j] := mas_numbers[j] + mas_numbers[j-1];
        mas_numbers[j-1] := mas_numbers[j] - mas_numbers[j-1];
        mas_numbers[j] := mas_numbers[j] - mas_numbers[j-1];
      end;
    end;
  end;

  // ¬ывод списка победителей
  Writeln('»гра окончена. —писок мест:');
  i := 1;
  Writeln(i, ') «ан€л »грок ',mas_numbers[Chislo_Igrokov],
      ', набрав ', mas_points[Chislo_Igrokov], ' баллов');
  Dec(Chislo_Igrokov);

  while Chislo_Igrokov > 0 do
  begin
    if mas_points[Chislo_Igrokov] <> mas_points[Chislo_Igrokov - 1] then
      Inc(i);
    Writeln(i, ') «ан€л »грок ', mas_numbers[Chislo_Igrokov],
      ', набрав ', mas_points[Chislo_Igrokov], ' баллов');
    Dec(Chislo_Igrokov);
  end;

  Readln;
end.
