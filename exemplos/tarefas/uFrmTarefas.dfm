object FrmTarefas: TFrmTarefas
  Left = 0
  Top = 0
  Caption = 'FrmTarefas'
  ClientHeight = 299
  ClientWidth = 405
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 37
    Height = 13
    Caption = 'Tarefas'
  end
  object EdTarefa: TEdit
    Left = 8
    Top = 27
    Width = 312
    Height = 21
    TabOrder = 0
  end
  object BtAdicionar: TBitBtn
    Left = 326
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Adicionar'
    TabOrder = 1
    OnClick = BtAdicionarClick
  end
  object GridTarefas: TDBGrid
    Left = 8
    Top = 56
    Width = 393
    Height = 235
    DataSource = DsTarefas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = GridTarefasDblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Width = 28
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Concluida'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Tarefa'
        Width = 263
        Visible = True
      end>
  end
  object DsTarefas: TDataSource
    DataSet = CdsTarefas
    Left = 224
    Top = 224
  end
  object CdsTarefas: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 224
    object CdsTarefasId: TIntegerField
      FieldName = 'Id'
    end
    object CdsTarefasTarefa: TStringField
      FieldName = 'Tarefa'
      Size = 200
    end
    object CdsTarefasConcluida: TBooleanField
      FieldName = 'Concluida'
    end
  end
end
