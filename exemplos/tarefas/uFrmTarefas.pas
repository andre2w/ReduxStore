unit uFrmTarefas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.Grids, MidasLib,
  Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, uReduxStore,
  System.Generics.Collections;

type
  TAcoes = (INCLUIR = 0,EXCLUIR=1,CONCLUIR=2);
  TTarefa = record
    Tarefa : String;
    Concluida : Boolean;
  end;

  TFrmTarefas = class(TForm)
    Label1: TLabel;
    EdTarefa: TEdit;
    BtAdicionar: TBitBtn;
    GridTarefas: TDBGrid;
    DsTarefas: TDataSource;
    CdsTarefas: TClientDataSet;
    CdsTarefasId: TIntegerField;
    CdsTarefasTarefa: TStringField;
    CdsTarefasConcluida: TBooleanField;
    procedure FormCreate(Sender: TObject);
    procedure BtAdicionarClick(Sender: TObject);
    procedure GridTarefasDblClick(Sender: TObject);
  private
    ReduxStore : TReduxStore<TList<TTarefa>>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTarefas: TFrmTarefas;

implementation

{$R *.dfm}

function RealizarAcao(State : TList<TTarefa>; Action : Integer):TList<TTarefa>;
var
  Tarefa : TTarefa;
  IdTarefa:Integer;
begin
  case Action of
    Ord(TAcoes.INCLUIR): begin
      Tarefa.Concluida := False;
      Tarefa.Tarefa := FrmTarefas.EdTarefa.Text;
      State.Add(Tarefa);
      FrmTarefas.EdTarefa.Clear;
    end;

    Ord(TAcoes.CONCLUIR) : begin
      IdTarefa := FrmTarefas.CdsTarefasId.AsInteger;
      Tarefa := State.Items[IdTarefa-1];
      Tarefa.Concluida := True;
      State.Items[IdTarefa-1] := Tarefa;
    end;
  end;
  Result := State;
end;

procedure AtualizarGrid(State : TList<TTarefa>);
var
  I : Integer;
begin
  with FrmTarefas do
  begin
    if not CdsTarefas.Active then
      CdsTarefas.Open;
    CdsTarefas.EmptyDataSet;
    for I := 0 to State.Count -1 do
    begin
      CdsTarefas.DisableControls;
      CdsTarefas.Append;
      CdsTarefasId.AsInteger := I + 1;
      CdsTarefasTarefa.AsString := State.Items[i].Tarefa;
      CdsTarefasConcluida.AsBoolean := State.Items[i].Concluida;
      CdsTarefas.Post;
      CdsTarefas.EnableControls;
    end;
  end;
end;

procedure TFrmTarefas.BtAdicionarClick(Sender: TObject);
begin
  ReduxStore.DispatchAction(Ord(TAcoes.INCLUIR));
end;

procedure TFrmTarefas.FormCreate(Sender: TObject);
var
  Reducer : TReducer<TList<TTarefa>>;
  Listener : TListener<TList<TTarefa>>;
begin
  CdsTarefas.CreateDataSet;
  Reducer := RealizarAcao;
  Listener := AtualizarGrid;
  ReduxStore := TReduxStore<TList<TTarefa>>.Create(TList<TTarefa>.Create,Reducer);
  ReduxStore.AddListener(Listener);
end;

procedure TFrmTarefas.GridTarefasDblClick(Sender: TObject);
begin
  ReduxStore.DispatchAction(Ord(TAcoes.CONCLUIR));
end;

end.
