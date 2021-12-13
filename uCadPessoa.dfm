object frmCadpessoa: TfrmCadpessoa
  Left = 393
  Top = 119
  Width = 780
  Height = 606
  Caption = 'Cadastro'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 764
    Height = 260
    Align = alTop
    TabOrder = 0
    object Label2: TLabel
      Left = 41
      Top = 20
      Width = 20
      Height = 13
      Caption = 'CPF'
    end
    object Label3: TLabel
      Left = 40
      Top = 64
      Width = 56
      Height = 13
      Caption = 'TELEFONE'
    end
    object Label1: TLabel
      Left = 42
      Top = 112
      Width = 21
      Height = 13
      Caption = 'CEP'
    end
    object edtcpf: TMaskEdit
      Left = 40
      Top = 35
      Width = 97
      Height = 21
      TabOrder = 0
      OnExit = edtcpfExit
    end
    object edttelefone: TMaskEdit
      Left = 43
      Top = 80
      Width = 88
      Height = 21
      EditMask = '(99)99999-9999;1;_'
      MaxLength = 14
      TabOrder = 2
      Text = '(  )     -    '
      OnClick = edttelefoneClick
      OnEnter = edttelefoneClick
      OnExit = edttelefoneExit
    end
    object edtemail: TLabeledEdit
      Left = 157
      Top = 79
      Width = 414
      Height = 21
      CharCase = ecLowerCase
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'EMAIL'
      TabOrder = 3
      OnExit = edtemailExit
    end
    object edtnome: TLabeledEdit
      Left = 158
      Top = 33
      Width = 414
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 32
      EditLabel.Height = 13
      EditLabel.Caption = 'NOME'
      TabOrder = 1
    end
    object edtcep: TMaskEdit
      Left = 40
      Top = 128
      Width = 97
      Height = 21
      TabOrder = 4
      OnExit = edtcepExit
    end
    object edtlogradouro: TLabeledEdit
      Left = 157
      Top = 128
      Width = 342
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 77
      EditLabel.Height = 13
      EditLabel.Caption = 'LOGRADOURO'
      TabOrder = 5
    end
    object edtcomplemento: TLabeledEdit
      Left = 40
      Top = 168
      Width = 221
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 83
      EditLabel.Height = 13
      EditLabel.Caption = 'COMPLEMENTO'
      TabOrder = 7
    end
    object edtnumero: TLabeledEdit
      Left = 514
      Top = 126
      Width = 61
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 48
      EditLabel.Height = 13
      EditLabel.Caption = 'N'#218'MERO'
      TabOrder = 6
    end
    object edtbairro: TLabeledEdit
      Left = 272
      Top = 168
      Width = 225
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'BAIRRO'
      TabOrder = 8
    end
    object edtuf: TLabeledEdit
      Left = 516
      Top = 166
      Width = 58
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 14
      EditLabel.Height = 13
      EditLabel.Caption = 'UF'
      TabOrder = 9
    end
    object edtcidade: TLabeledEdit
      Left = 41
      Top = 208
      Width = 224
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'CIDADE'
      TabOrder = 10
    end
    object edtpais: TLabeledEdit
      Left = 275
      Top = 208
      Width = 222
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 24
      EditLabel.Height = 13
      EditLabel.Caption = 'PA'#205'S'
      TabOrder = 11
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 260
    Width = 764
    Height = 256
    Align = alTop
    Caption = 'Panel2'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 762
      Height = 254
      Align = alClient
      DataSource = DSCadastro
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'cpf'
          Title.Caption = 'CPF'
          Width = 80
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nome'
          Title.Caption = 'NOME'
          Width = 171
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'email'
          Title.Caption = 'EMAIL'
          Width = 138
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'telefone'
          Title.Caption = 'TELEFONE'
          Width = 83
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'logradouro'
          Title.Caption = 'LOGRADOURO'
          Width = 198
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'numero'
          Title.Caption = 'N'#218'MERO'
          Width = 57
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 519
    Width = 764
    Height = 48
    Align = alBottom
    TabOrder = 2
    object btnSalvar: TBitBtn
      Left = 450
      Top = 14
      Width = 97
      Height = 25
      Caption = 'Salvar'
      TabOrder = 0
      OnClick = btnSalvarClick
      Kind = bkOK
    end
    object btnExcluir: TBitBtn
      Left = 554
      Top = 14
      Width = 97
      Height = 25
      Caption = 'Excluir'
      TabOrder = 1
      OnClick = btnExcluirClick
      Kind = bkAbort
    end
    object BitBtn1: TBitBtn
      Left = 660
      Top = 12
      Width = 97
      Height = 25
      Caption = '&Enviar'
      TabOrder = 2
      OnClick = BitBtn1Click
      Kind = bkAll
    end
  end
  object DSCadastro: TDataSource
    DataSet = CDSCadastro
    Left = 720
    Top = 20
  end
  object CDSCadastro: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'cpf'
        DataType = ftString
        Size = 14
      end
      item
        Name = 'nome'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'email'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'cep'
        DataType = ftString
        Size = 8
      end
      item
        Name = 'logradouro'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'numero'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'complemento'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'bairro'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'uf'
        DataType = ftString
        Size = 2
      end
      item
        Name = 'cidade'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'pais'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'telefone'
        DataType = ftString
        Size = 20
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 688
    Top = 20
    Data = {
      5A0100009619E0BD01000000180000000C0000000000030000005A0103637066
      0100490000000100055749445448020002000E00046E6F6D6501004900000001
      0005574944544802000200640005656D61696C01004900000001000557494454
      480200020064000363657001004900000001000557494454480200020008000A
      6C6F677261646F75726F0100490000000100055749445448020002006400066E
      756D65726F0100490000000100055749445448020002000A000B636F6D706C65
      6D656E746F0100490000000100055749445448020002003C000662616972726F
      0100490000000100055749445448020002003C00027566010049000000010005
      5749445448020002000200066369646164650100490000000100055749445448
      02000200640004706169730100490000000100055749445448020002003C0008
      74656C65666F6E6501004900000001000557494454480200020014000000}
    object CDSCadastrocpf: TStringField
      DisplayWidth = 17
      FieldName = 'cpf'
      Size = 14
    end
    object CDSCadastronome: TStringField
      DisplayWidth = 10
      FieldName = 'nome'
      Size = 100
    end
    object CDSCadastroemail: TStringField
      DisplayWidth = 18
      FieldName = 'email'
      Size = 100
    end
    object CDSCadastrocep: TStringField
      DisplayWidth = 10
      FieldName = 'cep'
      Size = 8
    end
    object CDSCadastrologradouro: TStringField
      DisplayWidth = 13
      FieldName = 'logradouro'
      Size = 100
    end
    object CDSCadastronumero: TStringField
      DisplayWidth = 12
      FieldName = 'numero'
      Size = 10
    end
    object CDSCadastrocomplemento: TStringField
      DisplayWidth = 16
      FieldName = 'complemento'
      Size = 60
    end
    object CDSCadastrobairro: TStringField
      DisplayWidth = 10
      FieldName = 'bairro'
      Size = 60
    end
    object CDSCadastrouf: TStringField
      DisplayWidth = 3
      FieldName = 'uf'
      Size = 2
    end
    object CDSCadastrocidade: TStringField
      DisplayWidth = 21
      FieldName = 'cidade'
      Size = 100
    end
    object CDSCadastropais: TStringField
      DisplayWidth = 20
      FieldName = 'pais'
      Size = 60
    end
    object CDSCadastrotelefone: TStringField
      FieldName = 'telefone'
    end
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 624
    Top = 32
  end
end
