object frmCriptografia: TfrmCriptografia
  Left = 0
  Top = 0
  Caption = 'Criptografia'
  ClientHeight = 149
  ClientWidth = 224
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtCriptografia: TEdit
    Left = 52
    Top = 33
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edtDesCriptografia: TEdit
    Left = 52
    Top = 60
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object btnExecutar: TBitBtn
    Left = 52
    Top = 87
    Width = 121
    Height = 31
    Caption = 'Executar'
    TabOrder = 2
    OnClick = btnExecutarClick
  end
end
