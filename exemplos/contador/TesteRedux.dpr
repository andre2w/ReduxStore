program TesteRedux;

uses
  Vcl.Forms,
  uFrmContador in 'uFrmContador.pas' {FrmContador},
  uReduxStore in '..\..\lib\uReduxStore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmContador, FrmContador);
  Application.Run;
end.
