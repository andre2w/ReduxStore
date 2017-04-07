unit uReduxStore;

interface

uses System.Generics.Collections, System.SysUtils, System.Variants,
     System.Classes;

type
  TReducer = reference to function(State : Variant; Action : Integer):Variant;
  TListener = reference to procedure(State : Variant);

  TReduxStore = class(TObject)
  private
    FState : Variant;
    FReducer : TReducer;
    FListeners : TList<TListener>;
  public
    constructor Create(InitialState : Variant; Reducer : TReducer); reintroduce; overload;
    procedure DispatchAction(Action : Integer);
    procedure AddListener(Listener:TListener);
    function GetState: Variant;
  end;

implementation

{ TReduxStore }
procedure TReduxStore.AddListener(Listener: TListener);
begin
  FListeners.Add(Listener);
end;

constructor TReduxStore.Create(InitialState : Variant; Reducer : TReducer);
begin
  FState := InitialState;
  FReducer := Reducer;
  FListeners := TList<TListener>.Create;
end;

procedure TReduxStore.DispatchAction(Action: Integer);
var
  Listener : TListener;
begin
  FState := FReducer(FState,Action);
  for Listener in FListeners do
    Listener(FState);

end;

function TReduxStore.GetState: Variant;
begin
  Result := FState;
end;


end.
