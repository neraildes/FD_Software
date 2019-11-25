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
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lbl_clk: TLabel;
    lbl_cnt: TLabel;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure btn_resumeClick(Sender: TObject);
    procedure btn_suspendClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  Aparelho : TSerial;
  ouvinte :  TThead_USART;


  contador: integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  ouvinte := TThead_USART.Create(FALSE);
  ouvinte.FreeOnTerminate:=TRUE;
  ouvinte.Start;
  ouvinte.Priority:=tpTimeCritical;


  Aparelho:=TSerial.Create;

  try
    Aparelho.Connect('COM3');
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


procedure TThead_USART.execute;
var
  pnt : ^char;
  Buffer_IO : array[0..TXBUFFERSIZE] of char;
  cnt,i : integer;
  strtmp : string;
  texto : string;


begin
  cnt:=0;
  sleep(10);
  while(TRUE) do
        begin

        //Form1.Memo1.Lines.Add('Entrou Thread '+ Form1.lbl_cnt.Caption);
        pnt:=Buffer_IO;
        Aparelho.Purge;
        cnt:=Aparelho.RecvBuffer(pnt,5);
        strtmp:='';
        for i:=0 to 4 do
            strtmp:=strtmp+IntToHex(Word(Buffer_IO[i]),2);

        form1.Memo1.Lines.Add(strtmp);

        if (POS('CDCDCD', strtmp)>0) then
           begin
             //Form1.Memo1.Lines.Add('- - - - - - - - - - - - - - - - - - - - - - - - - -');
             //Form1.Memo1.Lines.Add('----THREAD----');
             Form1.Memo1.Lines.Add('Pacote Rec : '+strtmp+' '+Form1.lbl_cnt.caption);
             //if (Form1.lbl_clk.caption='|') then Form1.lbl_clk.caption:='-' else Form1.lbl_clk.caption:='|';
             //ouvinte.MBPerguntando:=TRUE;


             Aparelho.Purge;
             texto:=Aparelho.Gravar_EEPROM_Interna($00,$0102,$03);
             Form1.Memo2.Lines.add(Aparelho.HextoText(texto));

             Aparelho.Purge;

           end;
         //cnt:=strtoint(Form1.lbl_cnt.Caption);
         //inc(cnt);
         //Form1.lbl_cnt.Caption:=inttostr(cnt);
         //sleep(1);

       end;
end;





end.

