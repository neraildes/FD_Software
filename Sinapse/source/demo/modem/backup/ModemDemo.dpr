program ModemDemo;

uses
  Forms, Interfaces,
  Unit1 in 'Unit1.pas', laz_synapse {Form1};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
