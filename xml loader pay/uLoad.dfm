object fLoad: TfLoad
  Left = 386
  Top = 160
  Width = 780
  Height = 498
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'XML loader'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object MemoLog: TMemo
    Left = 0
    Top = 0
    Width = 654
    Height = 464
    Align = alClient
    Lines.Strings = (
      #1048#1047#1052#1045#1053#1048' '#1042#1045#1056#1057#1048#1070' '#1042' '#1053#1040#1057#1058#1056#1054#1049#1050#1040#1061'!'
      #1086#1082#1088#1091#1075#1072' '#1079#1072#1073#1080#1088#1072#1102#1090' '#1083#1086#1072#1076#1077#1088' '#1080#1079' '#1073#1072#1079#1099
      'sm.xml_loader'
      ''
      #1089#1090#1080#1088#1072#1077#1096#1100' '#1089#1090#1072#1088#1091#1102' '#1079#1072#1087#1080#1089#1100
      
        #1079#1072#1075#1088#1091#1078#1072#1077#1096#1100' '#1085#1086#1074#1091#1102' - '#1089#1090#1072#1074#1080#1096#1100' '#1074#1077#1088#1089#1080#1102' '#1074#1099#1096#1077' ('#1082#1086#1090#1086#1088#1091#1102' '#1091#1082#1072#1079#1072#1083' '#1074' '#1085#1072#1089#1090#1088#1086#1081 +
        #1082#1072#1093')'
      '+ '#1076#1072#1090#1091)
    ScrollBars = ssVertical
    TabOrder = 0
    WordWrap = False
  end
  object Panel1: TPanel
    Left = 654
    Top = 0
    Width = 118
    Height = 464
    Align = alRight
    TabOrder = 1
    object Label1: TLabel
      Left = 1
      Top = 450
      Width = 116
      Height = 13
      Align = alBottom
      Caption = 'version 21.03.2018'
    end
    object btnLoad: TButton
      Left = 11
      Top = 8
      Width = 97
      Height = 25
      Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' xml'
      TabOrder = 0
      OnClick = btnLoadClick
    end
    object btnCancel: TButton
      Left = 11
      Top = 112
      Width = 97
      Height = 25
      Caption = #1086#1090#1084#1077#1085#1072
      Enabled = False
      TabOrder = 1
      OnClick = btnCancelClick
    end
    object btnCommit: TButton
      Left = 11
      Top = 40
      Width = 97
      Height = 25
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
      Enabled = False
      TabOrder = 2
      OnClick = btnCommitClick
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 328
    Top = 144
    DOMVendorDesc = 'MSXML'
  end
  object qGETFIOADR: TOracleDataSet
    SQL.Strings = (
      ''
      
        'select cl.NAME, sm.EXPANDADDR(cl.address_id) addr from SM.CLIENT' +
        'S cl where cl.id=:CL_ID')
    Optimize = False
    Variables.Data = {0300000001000000060000003A434C5F4944050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {
      0400000002000000040000004E414D4501000000000004000000414444520100
      00000000}
    RefreshOptions = [roAfterInsert]
    Session = osLetter
    Left = 472
    Top = 240
    object qGETFIOADRNAME: TStringField
      FieldName = 'NAME'
      Size = 200
    end
    object qGETFIOADRADDR: TStringField
      FieldName = 'ADDR'
      Size = 4000
    end
  end
  object qCheckCLOBL: TOracleDataSet
    SQL.Strings = (
      
        '  select count(1) CNT from sm.obligations o, sm.movesets ms wher' +
        'e ms.id=o.moveset_id and o.id=:O_ID and ms.client_id=:CL_ID')
    Optimize = False
    Variables.Data = {
      0300000002000000060000003A434C5F49440500000000000000000000000500
      00003A4F5F4944050000000000000000000000}
    QBEDefinition.QBEFieldDefs = {040000000100000003000000434E54010000000000}
    RefreshOptions = [roAfterInsert]
    Session = osLetter
    Left = 472
    Top = 304
    object qCheckCLOBLCNT: TFloatField
      FieldName = 'CNT'
    end
  end
  object dsGETFIOADR: TDataSource
    DataSet = qGETFIOADR
    Left = 512
    Top = 240
  end
  object dsCheckCLOBL: TDataSource
    DataSet = qCheckCLOBL
    Left = 512
    Top = 304
  end
  object qEditBD: TOracleDataSet
    SQL.Strings = (
      'select b.rowid,'
      '       b.kol,'
      '       b.guid_otch,'
      '       b.ls,'
      '       b.BS_PAY,'
      '       b.cname_pay,'
      '       b.purpose,'
      '       b.kbk_1,'
      '       b.kbk,'
      '       b.sum_pp,'
      '       b.sum_ost_po,'
      '       b.sum,'
      '       b.name_bic_rcp,'
      '       b.num_pp,'
      '       b.date_pp,'
      '       b.date_in_tofk,'
      '       b.guid  ,'
      '       b.cl_id  ,'
      '       b.nom_line'
      'from letter.bd b'
      'where 1=2')
    Optimize = False
    CommitOnPost = False
    Session = osLetter
    Left = 472
    Top = 144
  end
  object dsEditBD: TDataSource
    DataSet = qEditBD
    Left = 512
    Top = 144
  end
  object OracleLogon1: TOracleLogon
    Session = osLetter
    Options = [ldDatabase, ldDatabaseList, ldLogonHistory]
    HistoryRegSection = 'Software\Microsoft\Windows\CurrentVersion\Letters'
    Caption = #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103
    Left = 512
    Top = 192
  end
  object osLetter: TOracleSession
    BeforeLogOn = osLetterBeforeLogOn
    Left = 472
    Top = 192
  end
end
