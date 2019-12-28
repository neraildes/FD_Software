unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  Laz_Kernel_Serial;

type

  {Thread}
  TThead_USART = class(TThread)
  public
  protected
    procedure execute; override;
  end;




  { TForm1 }
  TForm1 = class(TForm)
    btn_suspend: TButton;
    btn_resume: TButton;
    Button1: TButton;
    btn_LerMemo: TButton;
    btn_EscreverMemo: TButton;
    Btn_Buzzer: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edt_buz_return: TEdit;
    Memo3: TMemo;
    Memo4: TMemo;
    Edt_ss_time: TEdit;
    mb_dispositivo: TEdit;
    mb_Add: TEdit;
    mb_value: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl_clk: TLabel;
    lbl_cnt: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    rb_EEPROM: TRadioButton;
    rb_24C1025: TRadioButton;
    procedure Btn_BuzzerClick(Sender: TObject);
    procedure btn_resumeClick(Sender: TObject);
    procedure btn_suspendClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure btn_LerMemoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ListaAdd(cmd:string);
    function  ListaUse():string;
  private

  public

  end;

var
  Form1: TForm1;
  Aparelho : TSerial;
  ouvinte :  TThead_USART;
  contador: integer;
  buzzercnt: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin

  ouvinte := TThead_USART.Create(FALSE);
  ouvinte.FreeOnTerminate:=TRUE;
  ouvinte.Start;
  ouvinte.Priority:=tpTimeCritical;

  buzzercnt:=0;

  Aparelho:=TSerial.Create;

  try
    Aparelho.Connect('COM5');
    Aparelho.Config(115200,8,'N',0,false,false);
  finally
    //Aparelho.free;
  end;

end;



procedure TForm1.btn_suspendClick(Sender: TObject);
begin
  ouvinte.Suspend;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  mensagem:AnsiString;
begin
  mensagem:=Aparelho.Gravar_EEPROM_Interna(strtoint(edit1.Text),
                                           strtoint(edit2.Text),
                                           strtoint(edit3.Text));
  showmessage(Aparelho.HexToText(mensagem));
end;

procedure TForm1.btn_LerMemoClick(Sender: TObject);
var
  temporario:string;
begin
  temporario:='$AABB';
  if(rb_EEPROM.Checked)  then temporario:=temporario+'C0'+mb_dispositivo.Text+'0901';
  if(rb_24C1025.Checked) then temporario:=temporario+'C0'+mb_dispositivo.Text+'1201';
  Memo2.Lines.Add(temporario);
  //Lista.comando[Lista.Fim]:=Temporario;
  //inc(Lista.fim);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Showmessage(Aparelho.HexToText(Edt_buz_return.Text));
end;



procedure TForm1.FormClick(Sender: TObject);
begin
  ouvinte.Suspend;
  sleep(50);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin

end;

procedure TForm1.btn_resumeClick(Sender: TObject);
begin
  ouvinte.Resume;
end;


procedure TForm1.Btn_BuzzerClick(Sender: TObject);
begin
  Aparelho.Buzzer(Sender, strtoint(Edt_ss_time.text));
end;


procedure TThead_USART.execute;
var
  pnt : ^char;
  Buffer_IO : array[0..TXBUFFERSIZE] of char;
  cnt,i : integer;
  strtmp : string;
  texto : string;
  ListaDeComandos : array[0..20] of string;
  node : AnsiString;  //APagar apos ensaios


begin
  cnt:=0;
  sleep(10);
  while(TRUE) do
        begin

        pnt:=Buffer_IO;
        Aparelho.Purge;
        cnt:=Aparelho.RecvBuffer(pnt,5);
        strtmp:='';
        for i:=0 to 4 do
            strtmp:=strtmp+IntToHex(Word(Buffer_IO[i]),2);

        if (POS('CDCDCD', strtmp)>0) then
           begin
             node:=Aparelho.fila.comando[0];
             if (Aparelho.fila.ObjOrigem<>nil)  then
                  begin
                    Aparelho.kernelSerial(node, 15,3); //ENVIA EFETIVAMENTE OS COMANDOS
                    if(Aparelho.fila.ObjOrigem.InheritsFrom(TButton)) then
                       begin
                         if (TButton(Aparelho.fila.ObjOrigem).Name='Btn_Buzzer') then
                             TEdit(Aparelho.fila.ObjDestino).Text:=Aparelho.fila.result;

                            //Form1.Edt_buz_return.Text:=Aparelho.fila.result;




                       end;
                    Aparelho.fila.ObjOrigem:=nil;

                    inc(buzzercnt);
                  end;

             if(length(node)>0) then
                begin
                  //Aparelho.resultCOM:=Aparelho.kernelSerial(node, 15,3);
                  for i:=1 to 10 do Aparelho.fila.comando[i-1]:=Aparelho.fila.comando[i];
                  Aparelho.fila.fim:=Aparelho.fila.fim-1;
                end;

             Aparelho.Purge;

           end;
       end;
end;


procedure TForm1.ListaAdd(cmd:string);
begin
  //Lista.comando[Lista.fim]:=cmd;
  //inc(Lista.fim);
end;

function TForm1.ListaUse():string;
var
  saida:string;
begin
  {
  if (Lista.Fim>=0) then
      begin
      saida:=Lista.comando[Lista.Fim];
      dec(Lista.Fim)
      end;
  }
  result := saida;
end;

end.

