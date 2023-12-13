program Module4;

uses
  SysUtils;

Var
  Count : integer;
  i : integer;
  Player, Chislo_Igrokov : integer;
  mas_points, mas_numbers : array of integer;
{
Count - ����� ��������� ����
i - ������������ ���������� + ����� ����� ����������
Player - ����� ��������������� ������
Chislo_Igrokov - ����� �������
mas_points - ������ ����� �������
mas_numbers - ������ ������� ������� ��� ����������� ��������
}

begin
  {������ �������������}
  SetLength (mas_numbers, Chislo_Igrokov);

  // ��������� ������� ������ ������� � ���������� ������� � �������� �������
  for i := 1 to Chislo_Igrokov do
  begin
    mas_points[i] := 0;
    mas_numbers[i] := i;
  end;
  {����� �������������}


  repeat
    //����� ������ �����
    Count := 0;

    {���� ���� ������ � ������ ������}




    // � ����� 3 ������
    // ������� �� ���������� ������ � �������
    if player = Chislo_Igrokov + 1 then
      player := 1;

  until (Count = Chislo_Igrokov);
  // ����� �� ����� ����� ��� ������ ���������� ���

  // ����������� ������ � ��������������� ������� �������
  for i := 1 to Chislo_Igrokov do
  begin
    for var j := Chislo_Igrokov downto i + 1 do
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
  Writeln(i, ') ����� ����� ',mas_numbers[Chislo_Igrokov],
      ', ������ ', mas_points[Chislo_Igrokov], ' ������');
  Dec(Chislo_Igrokov);

  while Chislo_Igrokov > 0 do
  begin
    if mas_points[Chislo_Igrokov] <> mas_points[Chislo_Igrokov - 1] then
      Inc(i);
    Writeln(i, ') ����� ����� ', mas_numbers[Chislo_Igrokov],
      ', ������ ', mas_points[Chislo_Igrokov], ' ������');
    Dec(Chislo_Igrokov);
  end;

  Readln;
end.
