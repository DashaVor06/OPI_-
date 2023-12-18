object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Erudit'
  ClientHeight = 90
  ClientWidth = 473
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 21
    Width = 307
    Height = 39
    Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1080#1075#1088#1086#1082#1086#1074':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LNoP: TLabel
    Left = 337
    Top = 21
    Width = 17
    Height = 39
    Caption = '2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object up: TButton
    Left = 360
    Top = 23
    Width = 17
    Height = 17
    Caption = #9650
    TabOrder = 0
    OnClick = upClick
  end
  object down: TButton
    Left = 360
    Top = 40
    Width = 17
    Height = 17
    Caption = #9660
    TabOrder = 1
    OnClick = downClick
  end
  object ok: TButton
    Left = 383
    Top = 23
    Width = 41
    Height = 35
    Caption = #10004
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = okClick
  end
end
