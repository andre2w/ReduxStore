unit uReduxStore;

interface

uses System.Generics.Collections, System.SysUtils, System.Variants,
     System.Classes;

type
  TReducer<S> = reference to function(State : S; Action : Integer):S;
  TListener<S> = reference to procedure(State : S);

  TReduxStore<T> = class(TObject)
  private
    FState : T;
    FReducer : TReducer<T>;
    FListeners : TList<TListener<T>>;
  public
    constructor Create(InitialState : T; Reducer : TReducer<T>); reintroduce; overload;
    procedure DispatchAction(Action : Integer);
    procedure AddListener(Listener:TListener<T>);
    function GetState: T;
  end;

implementation

{ TReduxStore }
procedure TReduxStore<T>.AddListener(Listener: TListener<T>);
begin
  FListeners.Add(Listener);
end;

constructor TReduxStore<T>.Create(InitialState : T; Reducer : TReducer<T>);
begin
  FState := InitialState;
  FReducer := Reducer;
  FListeners := TList<TListener<T>>.Create;
end;

procedure TReduxStore<T>.DispatchAction(Action: Integer);
var
  Listener : TListener<T>;
begin
  FState := FReducer(FState,Action);
  for Listener in FListeners do
    Listener(FState);

end;

function TReduxStore<T>.GetState: T;
begin
  Result := FState;
end;


end.
