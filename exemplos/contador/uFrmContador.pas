unit uFrmContador;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uReduxStore,
  System.Generics.Collections;

type
  TActionType = (INCREMENT = 0,DECREMENT = 1);
  TFrmContador = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ReduxStore : TReduxStore<Integer>;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmContador: TFrmContador;

implementation

{$R *.dfm}


{ TFrmContador }

procedure TFrmContador.Button1Click(Sender: TObject);
begin
  ReduxStore.DispatchAction(Ord(TActionType.INCREMENT));
end;

procedure TFrmContador.Button2Click(Sender: TObject);
begin
  ReduxStore.DispatchAction(Ord(TActionType.DECREMENT));
end;

procedure TFrmContador.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(ReduxStore);
end;

procedure TFrmContador.FormCreate(Sender: TObject);
var
  Reducer : TReducer<Integer>;
  Listener : TListener<Integer>;
begin

  Reducer := function(State : Integer; Action : Integer):Integer
  var
    StateValue : Integer;
  begin
    StateValue := State;
    case Action of
      Ord(TActionType.INCREMENT) : StateValue := StateValue + 1;
      Ord(TActionType.DECREMENT) : StateValue := StateValue - 1;
    end;
    State := StateValue;
    Result := State;
  end;

  Listener := procedure(State : Integer)
  var
    StateValue : Integer;
  begin
    StateValue := State;
    FrmContador.Label1.Caption := IntToStr( State );

    FrmContador.Button2.Enabled := True;
    FrmContador.Button1.Enabled := True;

    if StateValue = 0 then
      FrmContador.Button2.Enabled := False
    else if StateValue = 10 then
      FrmContador.Button1.Enabled := False

  end;

  ReduxStore := TReduxStore<Integer>.Create(0,Reducer);
  ReduxStore.AddListener(Listener);
  Label1.Caption := IntToStr( ReduxStore.GetState );
  Button2.Enabled := False;


end;

end.
