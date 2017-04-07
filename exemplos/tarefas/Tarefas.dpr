program Tarefas;

uses
  Vcl.Forms,
  uFrmTarefas in 'uFrmTarefas.pas' {FrmTarefas},
  uReduxStore in '..\..\lib\uReduxStore.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmTarefas, FrmTarefas);
  Application.Run;
end.
