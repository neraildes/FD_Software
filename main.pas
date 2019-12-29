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
    procedure showstatus();
  protected
    procedure execute; override;
  end;




  { TForm1 }
  TForm1 = class(TForm)
    btn_suspend: TButton;
    btn_resume: TButton;
    btn_LerMemo: TButton;
    btn_EscreverMemo: TButton;
    Btn_Buzzer: TButton;
    Button2: TButton;
    Edt_buz_return: TEdit;
    Lbl_Count: TLabel;
    Memo3: TMemo;
    Memo4: TMemo;
    Edt_ss_time: TEdit;
    mb_dispositivo: TEdit;
    mb_Add: TEdit;
    mb_value: TEdit;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Memo1: TMemo;
    Memo2: TMemo;
    rb_EEPROM: TRadioButton;
    rb_24C1025: TRadioButton;
    procedure Btn_BuzzerClick(Sender: TObject);
    procedure btn_resumeClick(Sender: TObject);
    procedure btn_suspendClick(Sender: TObject);
    procedure btn_LerMemoClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
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
  Aparelho.FilaFim:=0;
end;



procedure TForm1.btn_suspendClick(Sender: TObject);
begin
  ouvinte.Suspend;
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

procedure TForm1.Edit1Change(Sender: TObject);
begin

end;

procedure TForm1.Edit2Change(Sender: TObject);
begin

end;

procedure TForm1.Edit3Change(Sender: TObject);
begin

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


procedure TThead_USART.showstatus;
begin
Form1.Memo1.Lines.Clear;
form1.Memo3.Lines.add('0-'+Aparelho.fila[0].comando);
form1.Memo3.Lines.add('1-'+Aparelho.fila[1].comando);
form1.Memo3.Lines.add('2-'+Aparelho.fila[2].comando);
form1.Memo3.Lines.add('3-'+Aparelho.fila[3].comando);
form1.Memo3.Lines.add('4-'+Aparelho.fila[4].comando);
Form1.lbl_count.Caption:=inttostr(Aparelho.FilaFim)
//strtoint(Form1.lbl_count.Caption)
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
  jjj : TObject;

begin
  cnt:=0;
  sleep(10);
  while(TRUE) do
        begin
        //synchronize(@showstatus);
        Form1.lbl_count.Caption:=inttostr(Aparelho.FilaFim);
        pnt:=Buffer_IO;
        Aparelho.Purge;
        cnt:=Aparelho.RecvBuffer(pnt,5);
        strtmp:='';
        for i:=0 to 4 do
            strtmp:=strtmp+IntToHex(Word(Buffer_IO[i]),2);

        if ((POS('CDCDCD', strtmp)>0) and (Aparelho.FilaFim>0)) then
            begin
             node:=Aparelho.fila[Aparelho.FilaFim-1].comando;

             if (Aparelho.fila[Aparelho.FilaFim-1].ObjOrigem<>nil)  then
                  begin
                    Aparelho.kernelSerial(node); //ENVIA EFETIVAMENTE OS COMANDOS
                    if (Aparelho.fila[Aparelho.FilaFim-1].ObjOrigem.InheritsFrom(TButton)) then
                        begin
                         if (TButton(Aparelho.fila[Aparelho.FilaFim-1].ObjOrigem).Name='Btn_Buzzer') then
                             TEdit(Aparelho.fila[Aparelho.FilaFim-1].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[Aparelho.FilaFim-1].result);
                         end;
                  end;

             if(Aparelho.FilaFim>0) then
                begin
                  for i:=1 to Aparelho.FilaFim do
                      begin
                      Aparelho.fila[i-1].comando:=Aparelho.fila[i].comando;
                      Aparelho.fila[i-1].result:=Aparelho.fila[i].result;
                      Aparelho.fila[i-1].TotalReturn:=Aparelho.fila[i].TotalReturn;
                      Aparelho.fila[i-1].RXpayload:=Aparelho.fila[i].RXpayload;
                      Aparelho.fila[i-1].ObjOrigem:=Aparelho.fila[i].ObjOrigem;
                      Aparelho.fila[i-1].ObjDestino:=Aparelho.fila[i].ObjDestino;
                      end;
                end;
             if(Aparelho.FilaFim>0) then  dec(Aparelho.FilaFim);
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

