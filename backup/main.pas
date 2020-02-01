unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, Laz_Kernel_Serial, Types, Inifiles;

type

  {Receita}
  TReceita = record
    Nome     : string[10];
    SetPoint : real;
    TempoON  : real;
    TempoOFF : real;
    Histerese: real;
  end;




  {Thread}
  TThead_USART = class(TThread)
  public
    procedure showstatus();
  protected
    procedure execute; override;
  end;




  { TForm1 }
  TForm1 = class(TForm)
    Btn_Buzzer: TButton;
    btn_Control_Active_write: TButton;
    btn_EscreverMemo: TButton;
    btn_fill: TButton;
    btn_fill_confere: TButton;
    btn_gravar_vp_int: TButton;
    btn_LerMemo: TButton;
    btn_ler_vp_int: TButton;
    btn_page_write: TButton;
    btn_resume: TButton;
    btn_suspend: TButton;
    Button1: TButton;
    Button2: TButton;
    btn_vp_string_read: TButton;
    btn_vp_strinng_write: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    IEE_Read: TButton;
    IEE_Write: TButton;
    chk_EEPROM_16Bits: TCheckBox;
    ControledePaginas: TPageControl;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit3: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit4: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    Edit49: TEdit;
    Edit5: TEdit;
    Edit50: TEdit;
    Edit51: TEdit;
    Edit52: TEdit;
    Edit53: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit57: TEdit;
    Edit58: TEdit;
    Edit59: TEdit;
    Edit6: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Edit62: TEdit;
    Edit63: TEdit;
    Edit64: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    Edit67: TEdit;
    Edit68: TEdit;
    Edit69: TEdit;
    Edit7: TEdit;
    Edit70: TEdit;
    Edit71: TEdit;
    IEE_String_add: TEdit;
    IEE_String: TEdit;
    edt_rec1_histerese: TEdit;
    edt_rec2_histerese: TEdit;
    edt_rec3_histerese: TEdit;
    edt_rec4_histerese: TEdit;
    edt_rec5_histerese: TEdit;
    edt_rec6_histerese: TEdit;
    edt_rec7_histerese: TEdit;
    edt_rec0_nome: TEdit;
    edt_rec1_nome: TEdit;
    edt_rec2_nome: TEdit;
    edt_rec3_nome: TEdit;
    edt_rec4_nome: TEdit;
    edt_rec5_nome: TEdit;
    edt_rec6_nome: TEdit;
    edt_rec7_nome: TEdit;
    edt_rec1_off: TEdit;
    edt_rec2_off: TEdit;
    edt_rec3_off: TEdit;
    edt_rec4_off: TEdit;
    edt_rec5_off: TEdit;
    edt_rec6_off: TEdit;
    edt_rec7_off: TEdit;
    edt_rec1_on: TEdit;
    edt_rec2_on: TEdit;
    edt_rec3_on: TEdit;
    edt_rec4_on: TEdit;
    edt_rec5_on: TEdit;
    edt_rec6_on: TEdit;
    edt_rec7_on: TEdit;
    edt_rec0_setpoint: TEdit;
    edt_rec0_on: TEdit;
    edt_rec0_off: TEdit;
    edt_rec0_histerese: TEdit;
    edt_nump: TEdit;
    edt_Analogic_Channel: TEdit;
    edt_Analogic_Destino: TEdit;
    edt_Analogic_Reply: TEdit;
    edt_rec1_setpoint: TEdit;
    edt_rec2_setpoint: TEdit;
    edt_rec3_setpoint: TEdit;
    edt_rec4_setpoint: TEdit;
    edt_rec5_setpoint: TEdit;
    edt_rec6_setpoint: TEdit;
    edt_rec7_setpoint: TEdit;
    edt_saidapadrao: TEdit;
    edt_condensador: TEdit;
    edt_vacuometro: TEdit;
    edt_tensao: TEdit;
    edt_vp_string_value: TEdit;
    edt_vp_string: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edt_buz_return: TEdit;
    edt_control_active: TEdit;
    edt_control_active_reply: TEdit;
    edt_eeprom_add: TEdit;
    edt_eeprom_chip: TEdit;
    edt_eeprom_placa: TEdit;
    edt_eeprom_reply: TEdit;
    edt_eeprom_value: TEdit;
    edt_fill: TEdit;
    edt_fill_chip: TEdit;
    edt_fill_destino: TEdit;
    edt_fill_reply: TEdit;
    edt_page: TEdit;
    edt_page_reply: TEdit;
    Edt_ss_time: TEdit;
    edt_vp_add_int: TEdit;
    edt_vp_value_int: TEdit;
    edt_vp_value_int_reply: TEdit;
    gpb_proculus: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    lbl_Tensao: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Lbl_Count: TLabel;
    ManutencaoCalibracao: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    PaginaPrincipal: TTabSheet;
    Panel1: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel12: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    Panel15: TPanel;
    Panel16: TPanel;
    Panel17: TPanel;
    Panel18: TPanel;
    Panel19: TPanel;
    Panel2: TPanel;
    Panel20: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Pn_COM: TPanel;
    rb_24C1025: TRadioButton;
    rb_EEPROM: TRadioButton;
    OnLineSystem: TTimer;
    LeitorDeTemperatura: TTimer;
    TabSheet1: TTabSheet;
    ToggleBox1: TToggleBox;
    ToggleBox10: TToggleBox;
    ToggleBox2: TToggleBox;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    ToggleBox5: TToggleBox;
    ToggleBox6: TToggleBox;
    ToggleBox7: TToggleBox;
    ToggleBox8: TToggleBox;
    ToggleBox9: TToggleBox;
    procedure Btn_BuzzerClick(Sender: TObject);
    procedure btn_Control_Active_writeClick(Sender: TObject);
    procedure btn_EscreverMemoClick(Sender: TObject);
    procedure btn_fillClick(Sender: TObject);
    procedure btn_fill_confereClick(Sender: TObject);
    procedure btn_gravar_vp_intClick(Sender: TObject);
    procedure btn_ler_vp_intClick(Sender: TObject);
    procedure btn_page_writeClick(Sender: TObject);
    procedure btn_resumeClick(Sender: TObject);
    procedure btn_suspendClick(Sender: TObject);
    procedure btn_LerMemoClick(Sender: TObject);
    procedure btn_vp_string_readClick(Sender: TObject);
    procedure btn_vp_strinng_writeClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure chk_EEPROM_16BitsChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure edt_vacuometroChange(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure gpb_proculusClick(Sender: TObject);
    procedure GroupBox1Click(Sender: TObject);
    procedure GroupBox8Click(Sender: TObject);
    procedure IEE_WriteClick(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure LeitorDeTemperaturaTimer(Sender: TObject);
    procedure ListaAdd(cmd:string);
    function  ListaUse():string;
    procedure ControledePaginasChange(Sender: TObject);
    procedure ManutencaoCalibracaoContextPopup(Sender: TObject;
      MousePos: TPoint; var Handled: Boolean);
    procedure PaginaPrincipalContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure Panel12Click(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure rb_24C1025Change(Sender: TObject);
    procedure rb_EEPROMChange(Sender: TObject);
    procedure OnLineSystemTimer(Sender: TObject);
    procedure TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure ToggleBox10Change(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure ToggleBox3Change(Sender: TObject);
    procedure ToggleBox4Change(Sender: TObject);
    procedure ToggleBox5Change(Sender: TObject);
    procedure ToggleBox6Change(Sender: TObject);
    procedure ToggleBox7Change(Sender: TObject);
    procedure ToggleBox8Change(Sender: TObject);
    procedure ToggleBox9Change(Sender: TObject);
    procedure GravarReceita();
    procedure RecuperarReceita();
    procedure ReceitaFromTEdit();
    procedure ReceitaToTEdit();
  private

  public

  end;

var
  Form1: TForm1;
  Aparelho : TSerial;
  ouvinte :  TThead_USART;
  contador: integer;
  buzzercnt: integer;
  CountCOM : integer;
  AddConfere : longint;
  Receita : array [0..7] of TReceita;


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
  CountCOM:=0;

  Aparelho:=TSerial.Create;

  try
    Aparelho.Connect('COM5');
    Aparelho.Config(115200,8,'N',0,false,false);
  finally
    //Aparelho.free;
  end;
  Aparelho.FilaFim:=0;
  RecuperarReceita();
end;

procedure TForm1.gpb_proculusClick(Sender: TObject);
begin

end;

procedure TForm1.GroupBox1Click(Sender: TObject);
begin

end;

procedure TForm1.GroupBox8Click(Sender: TObject);
begin

end;

procedure TForm1.IEE_WriteClick(Sender: TObject);
begin
  Aparelho.IEE_Write_Mae_String(strtoint(IEE_String_add.Text),
                                IEE_String.Text,
                                TEXTO,
                                edt_saidapadrao);
end;

procedure TForm1.Label10Click(Sender: TObject);
begin

end;

procedure TForm1.LeitorDeTemperaturaTimer(Sender: TObject);
begin
  if(LeitorDeTemperatura.Interval=100) then LeitorDeTemperatura.Interval:=8000;

  Aparelho.Read_Analogic_Channel(1,0,FLUTUANTE,'V',edt_tensao);
  Aparelho.Read_Analogic_Channel(1,1,FLUTUANTE,'mmHg',edt_vacuometro);
  Aparelho.Read_Analogic_Channel(2,0,FLUTUANTE,'°C',edt_condensador);

  Aparelho.Read_Analogic_Channel(3,0,FLUTUANTE,'°C',Edit2);
  Aparelho.Read_Analogic_Channel(3,1,FLUTUANTE,'°C',Edit10);
  Aparelho.Read_Analogic_Channel(4,0,FLUTUANTE,'°C',Edit17);
  Aparelho.Read_Analogic_Channel(4,1,FLUTUANTE,'°C',Edit24);
  Aparelho.Read_Analogic_Channel(5,0,FLUTUANTE,'°C',Edit31);
  Aparelho.Read_Analogic_Channel(5,1,FLUTUANTE,'°C',Edit38);
  Aparelho.Read_Analogic_Channel(6,0,FLUTUANTE,'°C',Edit45);
  Aparelho.Read_Analogic_Channel(6,1,FLUTUANTE,'°C',Edit52);
  Aparelho.Read_Analogic_Channel(7,0,FLUTUANTE,'°C',Edit59);
  Aparelho.Read_Analogic_Channel(7,1,FLUTUANTE,'°C',Edit66);
end;



procedure TForm1.btn_suspendClick(Sender: TObject);
begin
  ouvinte.Suspend;
end;



procedure TForm1.btn_LerMemoClick(Sender: TObject);
var
  temporario:string;
begin
  edt_eeprom_reply.text:='';
  if(rb_EEPROM.Checked) then
     begin
     if(chk_EEPROM_16Bits.Checked) then
         begin
          if(StrToInt(edt_eeprom_placa.text)=0)  then


             Aparelho.Ler_EEPROM_16bits_Interna_Mae(strtoint(edt_eeprom_add.Text),
                                                    HEXADECIMAL,
                                                    Form1.edt_eeprom_reply
                                                    )

          else
             Aparelho.Ler_EEPROM_16bits_Interna_Filha(strtoint(edt_eeprom_placa.text),
                                                      strtoint(edt_eeprom_add.Text),
                                                      HEXADECIMAL,
                                                      Form1.edt_eeprom_reply
                                                      );

         end
     else
         begin
           if(StrToInt(edt_eeprom_placa.text)=0)  then
              Aparelho.Ler_EEPROM_8bits_Interna_Mae(strtoint(edt_eeprom_add.Text),
                                                    HEXADECIMAL,
                                                    Form1.edt_eeprom_reply
                                                    )

           else
              Aparelho.Ler_EEPROM_8bits_Interna_Filha(strtoint(edt_eeprom_placa.text),
                                                      strtoint(edt_eeprom_add.Text),
                                                      HEXADECIMAL,
                                                      Form1.edt_eeprom_reply
                                                      );



         end
     end
  else
  begin
  if(chk_EEPROM_16Bits.Checked) then
      begin
       if(StrToInt(edt_eeprom_placa.text)=0)  then
          Aparelho.Ler_EEPROM_16bits_24C1025_Mae(strtoint(edt_eeprom_chip.Text),
                                                 strtoint(edt_eeprom_add.Text),
                                                 HEXADECIMAL,
                                                 Form1.edt_eeprom_reply
                                                 )

       else
          Aparelho.Ler_EEPROM_16bits_24C1025_Filha(strtoint(edt_eeprom_placa.text),
                                                   strtoint(edt_eeprom_chip.Text),
                                                   strtoint(edt_eeprom_add.Text),
                                                   HEXADECIMAL,
                                                   Form1.edt_eeprom_reply
                                                   )
      end
  else
      begin
        if(StrToInt(edt_eeprom_placa.text)=0)  then
           Aparelho.Ler_EEPROM_8bits_24C1025_Mae(strtoint(edt_eeprom_chip.Text),
                                                 strtoint(edt_eeprom_add.Text),
                                                 HEXADECIMAL,
                                                 Form1.edt_eeprom_reply
                                                 )
        else
           Aparelho.Ler_EEPROM_8bits_24C1025_Filha(strtoint(edt_eeprom_placa.text),
                                                   strtoint(edt_eeprom_chip.Text),
                                                   strtoint(edt_eeprom_add.Text),
                                                   HEXADECIMAL,
                                                   Form1.edt_eeprom_reply
                                                   )

      end
  end


end;

procedure TForm1.btn_vp_string_readClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Read_VP_String(strtoint(edt_vp_string.Text),
                                            TEXTO,
                                            Form1.edt_vp_string_value);
end;

procedure TForm1.btn_vp_strinng_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Write_VP_String(strtoint(edt_vp_string.Text),
                                             edt_vp_string_value.Text,
                                             TEXTO,
                                             Form1.edt_vp_value_int_reply
                                             );

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  valor:longint;
begin
  valor:=strtoint(edt_eeprom_add.Text);
  if(chk_EEPROM_16Bits.Checked) then
     valor:=valor+2
  else
     inc(valor);
  if(rb_EEPROM.Checked) then
     Form1.edt_eeprom_add.text:='$'+inttohex(valor,4)
  else
     Form1.edt_eeprom_add.text:='$'+inttohex(valor,8);
  btn_LerMemo.Click;


end;

procedure TForm1.Button2Click(Sender: TObject);
var
  valor:longint;
begin
  valor:=strtoint(edt_eeprom_add.Text);
  if(valor>2) then
     begin
        if(chk_EEPROM_16Bits.Checked) then
           valor:=valor-2
        else
           dec(valor);
        if(rb_EEPROM.Checked) then
           Form1.edt_eeprom_add.text:='$'+inttohex(valor,4)
        else
           Form1.edt_eeprom_add.text:='$'+inttohex(valor,8);
        btn_LerMemo.Click;
     end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin

  Aparelho.Read_Analogic_Channel(strtoint(edt_Analogic_Destino.Text),
                                          strtoint(edt_Analogic_Channel.Text),
                                          FLUTUANTE,
                                          '',
                                          edt_Analogic_Reply);




end;

procedure TForm1.Button4Click(Sender: TObject);
var
  numero:real;
begin
    //numero:=NumeroPuro(edt_nump.Text);
    //showmessage(floattostr(numero));
end;

procedure TForm1.Button5Click(Sender: TObject);
var
  i:integer;
  addeeprom:integer;
begin
  ReceitaFromTEdit();
  for i:=0 to 7 do
      begin
        addeeprom:=256+(i*16);
        Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom+0,trunc(Receita[i].SetPoint*10),FLUTUANTE,edt_saidapadrao);
        Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+4,trunc(Receita[i].Histerese),FLUTUANTE,edt_saidapadrao);
        Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+2,trunc(Receita[i].TempoON),FLUTUANTE,edt_saidapadrao);
        Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+3,trunc(Receita[i].TempoOFF),FLUTUANTE,edt_saidapadrao);
        Aparelho.Gravar_EEPROM_String_Mae(addeeprom+5,Receita[i].Nome,TEXTO,edt_saidapadrao);
      end;
  showmessage('Concluido');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin

end;

procedure TForm1.Button7Click(Sender: TObject);
begin

end;



procedure TForm1.chk_EEPROM_16BitsChange(Sender: TObject);
begin
   if(chk_EEPROM_16Bits.Checked) then
      Form1.edt_eeprom_value.text:='$0000'
   else
      Form1.edt_eeprom_value.text:='$00';
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

procedure TForm1.Edit9Change(Sender: TObject);
begin

end;

procedure TForm1.edt_vacuometroChange(Sender: TObject);
begin

end;



procedure TForm1.FormClick(Sender: TObject);
begin
  ouvinte.Suspend;
  sleep(50);
end;

procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   ouvinte.Suspend;
   GravarReceita();
end;

procedure TForm1.btn_resumeClick(Sender: TObject);
begin
  ouvinte.Resume;
end;


procedure TForm1.Btn_BuzzerClick(Sender: TObject);
var
  valor:integer;
begin
  Edt_buz_return.text:='';
  valor:=strtoint(Edt_ss_time.text);
  inc(valor);
  Edt_ss_time.text:=inttostr(valor);
  Aparelho.Buzzer(strtoint(Edt_ss_time.text),TEXTO,Form1.Edt_buz_return);
end;

procedure TForm1.btn_Control_Active_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Control_Active(strtoint(edt_control_active.Text),
                                   TEXTO,
                                   Form1.edt_control_active_reply
                                   );
end;

procedure TForm1.btn_EscreverMemoClick(Sender: TObject);
begin
  //edt_eeprom_reply.text:='';
  if(rb_EEPROM.Checked) then  //Memória interna do Microcontrolador
     begin
     if(chk_EEPROM_16Bits.Checked) then  //Dados com 16 bits
         begin
          if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
             Aparelho.Gravar_EEPROM_16bits_Interna_Mae(strtoint(edt_eeprom_add.Text),
                                                       strtoint(edt_eeprom_value.Text),
                                                       TEXTO,
                                                       Form1.edt_eeprom_reply
                                                       )

          else                                         //Atuação na placa filha
             Aparelho.Gravar_EEPROM_16bits_Interna_Filha(strtoint(edt_eeprom_placa.text),
                                                         strtoint(edt_eeprom_add.Text),
                                                         strtoint(edt_eeprom_value.Text),
                                                         TEXTO,
                                                         Form1.edt_eeprom_reply
                                                         );
         end
     else     //Dados com 8 bits de tamanho
         begin
           if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
              Aparelho.Gravar_EEPROM_8bits_Interna_Mae(strtoint(edt_eeprom_add.Text),
                                                       strtoint(edt_eeprom_value.Text),
                                                       TEXTO,
                                                       Form1.edt_eeprom_reply)
           else                                          //Atuacao na placa filha
              Aparelho.Gravar_EEPROM_8bits_Interna_Filha(strtoint(edt_eeprom_placa.text),
                                                         strtoint(edt_eeprom_add.Text),
                                                         strtoint(edt_eeprom_value.Text),
                                                         TEXTO,
                                                         Form1.edt_eeprom_reply
                                                         );


         end
     end
  else      //Memoria Externa do Microcontrolador (24C1025)
     begin
       if(chk_EEPROM_16Bits.Checked) then  //Dados com 16 bits
           begin
            if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
              Aparelho.Gravar_EEPROM_16bits_24C1025_Mae(strtoint(edt_eeprom_chip.Text),
                                                        strtoint(edt_eeprom_add.Text),
                                                        strtoint(edt_eeprom_value.Text),
                                                        TEXTO,
                                                        Form1.edt_eeprom_reply
                                                        )
            else
                Aparelho.Gravar_EEPROM_16bits_24C1025_Filha(strtoint(edt_eeprom_placa.text),
                                                            strtoint(edt_eeprom_chip.Text),
                                                            strtoint(edt_eeprom_add.Text),
                                                            strtoint(edt_eeprom_value.Text),
                                                            TEXTO,
                                                            Form1.edt_eeprom_reply
                                                            )
            end
       else
          begin
            if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
               Aparelho.Gravar_EEPROM_8bits_24C1025_Mae(strtoint(edt_eeprom_chip.Text),
                                                        strtoint(edt_eeprom_add.Text),
                                                        strtoint(edt_eeprom_value.Text),
                                                        TEXTO,
                                                        Form1.edt_eeprom_reply
                                                        )

           else
               Aparelho.Gravar_EEPROM_8bits_24C1025_Filha(strtoint(edt_eeprom_placa.text),
                                                          strtoint(edt_eeprom_chip.Text),
                                                          strtoint(edt_eeprom_add.Text),
                                                          strtoint(edt_eeprom_value.Text),
                                                          TEXTO,
                                                          Form1.edt_eeprom_reply
                                                          )

          end;
     end;
end;

procedure TForm1.btn_fillClick(Sender: TObject);
begin
  Aparelho.EEPROM_24C1025_Fill_All(TEXTO,
                                   strtoint(edt_fill_destino.Text),
                                   strtoint(edt_fill_chip.text),
                                   strtoint(edt_fill.text)
                                   );
end;

procedure TForm1.btn_fill_confereClick(Sender: TObject);
begin
  AddConfere:=0;
  while (AddConfere<=128) do
      begin
        //Aparelho.Ler_EEPROM_16bits_24C1025_Mae(TEXTO,0, AddConfere);
        AddConfere:=AddConfere+2;
      end;
end;

procedure TForm1.btn_gravar_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Write_VP_Int(strtoint(edt_vp_add_int.Text),
                                 strtoint(edt_vp_value_int.Text),
                                 TEXTO,
                                 Form1.edt_vp_value_int_reply
                                 );
end;

procedure TForm1.btn_ler_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Read_VP_Int(strtoint(edt_vp_add_int.Text),FLUTUANTE,Form1.edt_vp_value_int_reply);
end;

procedure TForm1.btn_page_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Goto_Page(strtoint(edt_page.Text),TEXTO,Form1.edt_page_reply);
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
  //texto : string;
  ListaDeComandos : array[0..20] of string;
  node : AnsiString;  //APagar apos ensaios
  jjj : TObject;
  HardReply:string;
  numreal : real;
  SaidaString : String;


begin
  cnt:=0;
  sleep(10);
  while(TRUE) do
        begin
        //synchronize(@showstatus);
        Form1.lbl_count.Caption:=inttostr(Aparelho.FilaFim);
        pnt:=Buffer_IO;
        try
        Aparelho.Purge;
        finally
        end;
        cnt:=Aparelho.RecvBuffer(pnt,5);
        strtmp:='';
        for i:=0 to 4 do
            strtmp:=strtmp+IntToHex(Word(Buffer_IO[i]),2);
        Form1.Memo1.Lines.Add(strtmp);
        if (POS('CDCDCD', strtmp)>0) then
            begin
             CountCOM:=5;
             if(Aparelho.FilaFim>0) then
                begin

                 node:=Aparelho.fila[0].comando;

                 if (Aparelho.fila[0].ObjDestino<>nil)  then
                      begin
                        //TEdit(Aparelho.fila[0].ObjDestino).Text:='*';
                        Aparelho.kernelSerial(node); //ENVIA EFETIVAMENTE OS COMANDOS
                        case Aparelho.fila[0].resTypeData of
                              FLUTUANTE :
                                  begin
                                  numreal:=Aparelho.HexToInt(Aparelho.fila[0].result);
                                  if(numreal>32768) then
                                  numreal:=numreal-65536;
                                  numreal:=numreal/10.0;
                                  SaidaString:=formatfloat('00.0',numreal);
                                  if(StrToFloat(SaidaString)=-0.1) then
                                     begin
                                       TEdit(Aparelho.fila[0].ObjDestino).Text:='Sem Placa';
                                       TEdit(Aparelho.fila[0].ObjDestino).Color:=clRed;
                                       TEdit(Aparelho.fila[0].ObjDestino).Font.Color:=clWhite;
                                     end
                                  else
                                     if(StrToFloat(SaidaString)<-70.0) then
                                        begin
                                          TEdit(Aparelho.fila[0].ObjDestino).Text:='Sem Sensor';
                                          TEdit(Aparelho.fila[0].ObjDestino).Color:=clYellow;
                                          TEdit(Aparelho.fila[0].ObjDestino).Font.Color:=clBlack;
                                        end
                                        else
                                        begin
                                          TEdit(Aparelho.fila[0].ObjDestino).Text:=SaidaString+Aparelho.fila[0].resUnidade;
                                          TEdit(Aparelho.fila[0].ObjDestino).Color:=clWhite;
                                          TEdit(Aparelho.fila[0].ObjDestino).Font.Color:=clBlack;
                                        end;

                                  //Form1.MascararSaida(Aparelho.fila[0].ObjDestino);
                                  end;
                              TEXTO :
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);
                                  end;
                              HEXADECIMAL:
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:='$'+Aparelho.fila[0].result;
                                  end;

                         end
                      end;

                 if(Aparelho.FilaFim>0) then
                    begin
                      for i:=1 to Aparelho.FilaFim do
                          begin
                          Aparelho.fila[i-1].comando:=Aparelho.fila[i].comando;
                          Aparelho.fila[i-1].result:=Aparelho.fila[i].result;
                          Aparelho.fila[i-1].TotalReturn:=Aparelho.fila[i].TotalReturn;
                          Aparelho.fila[i-1].RXpayload:=Aparelho.fila[i].RXpayload;
                          Aparelho.fila[i-1].ObjDestino:=Aparelho.fila[i].ObjDestino;
                          Aparelho.fila[i-1].resTypeData:=Aparelho.fila[i].resTypeData;
                          Aparelho.fila[i-1].resUnidade:=Aparelho.fila[i].resUnidade;
                          end;
                    end;
                 if(Aparelho.FilaFim>0) then  dec(Aparelho.FilaFim);
                 Aparelho.Purge;
             end;//Aparelho.FilaFim>0
         end; //POS
     end;//while (TRUE)
end;//PROCEDURE



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

procedure TForm1.ControledePaginasChange(Sender: TObject);
begin

end;

procedure TForm1.ManutencaoCalibracaoContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
begin

end;

procedure TForm1.PaginaPrincipalContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.Panel12Click(Sender: TObject);
begin

end;

procedure TForm1.Panel1Click(Sender: TObject);
begin

end;

procedure TForm1.RadioButton1Change(Sender: TObject);
begin

end;

procedure TForm1.rb_24C1025Change(Sender: TObject);
begin
  edt_eeprom_add.text:='$00000000';
end;

procedure TForm1.rb_EEPROMChange(Sender: TObject);
begin
  edt_eeprom_add.text:='$0000';
end;

procedure TForm1.OnLineSystemTimer(Sender: TObject);
begin

  if(CountCOM>0) then
     begin
       //showmessage('Entrou timer');
       dec(CountCOM);
       Pn_COM.Color:=clLime;
       Pn_COM.Caption:='ONLINE';
       Pn_COM.Font.Color:=clBlack;
     end
  else
     begin
       Pn_COM.Color:=clBlack;
       Pn_COM.Caption:='OFFLINE';
       Pn_COM.Font.Color:=clLime;
     end;
end;

procedure TForm1.TabSheet1ContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
begin

end;

procedure TForm1.ToggleBox10Change(Sender: TObject);
begin
  if(ToggleBox10.Checked=True) then
     begin
       ToggleBox10.Caption:='OK';
       Panel10.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(349,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox10.Caption:='X';
       Panel10.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(349,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
  if(ToggleBox1.Checked=True) then
     begin
       ToggleBox1.Caption:='OK';
       Panel1.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(241,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox1.Caption:='X';
       Panel1.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(241,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox2Change(Sender: TObject);
begin
  if(ToggleBox2.Checked=True) then
     begin
       ToggleBox2.Caption:='OK';
       Panel2.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(253,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox2.Caption:='X';
       Panel2.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(253,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox3Change(Sender: TObject);
begin
  if(ToggleBox3.Checked=True) then
     begin
       ToggleBox3.Caption:='OK';
       Panel3.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(265,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox3.Caption:='X';
       Panel3.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(265,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox4Change(Sender: TObject);
begin
  if(ToggleBox4.Checked=True) then
     begin
       ToggleBox4.Caption:='OK';
       Panel4.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(277,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox4.Caption:='X';
       Panel4.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(277,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox5Change(Sender: TObject);
begin
  if(ToggleBox5.Checked=True) then
     begin
       ToggleBox5.Caption:='OK';
       Panel5.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(289,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox5.Caption:='X';
       Panel5.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(289,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox6Change(Sender: TObject);
begin
  if(ToggleBox6.Checked=True) then
     begin
       ToggleBox6.Caption:='OK';
       Panel6.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(301,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox6.Caption:='X';
       Panel6.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(301,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox7Change(Sender: TObject);
begin
  if(ToggleBox7.Checked=True) then
     begin
       ToggleBox7.Caption:='OK';
       Panel7.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(313,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox7.Caption:='X';
       Panel7.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(313,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox8Change(Sender: TObject);
begin
  if(ToggleBox8.Checked=True) then
     begin
       ToggleBox8.Caption:='OK';
       Panel8.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(325,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox8.Caption:='X';
       Panel8.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(325,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ToggleBox9Change(Sender: TObject);
begin
  if(ToggleBox9.Checked=True) then
     begin
       ToggleBox9.Caption:='OK';
       Panel9.Color:=clLime;
       Aparelho.PROCULUS_Write_VP_Int(337,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       ToggleBox9.Caption:='X';
       Panel9.Color:=clRed;
       Aparelho.PROCULUS_Write_VP_Int(337,0,TEXTO,edt_saidapadrao);
     end;
end;

procedure TForm1.ReceitaFromTEdit();
begin
  Receita[0].Nome     :=           edt_rec0_nome.Text;
  Receita[0].SetPoint :=StrToFloat(edt_rec0_setpoint.Text);
  Receita[0].TempoON  :=StrToFloat(edt_rec0_on.Text);
  Receita[0].TempoOFF :=StrToFloat(edt_rec0_off.Text);
  Receita[0].Histerese:=StrToFloat(edt_rec0_histerese.Text);

  Receita[1].Nome     :=           edt_rec1_nome.Text;
  Receita[1].SetPoint :=StrToFloat(edt_rec1_setpoint.Text);
  Receita[1].TempoON  :=StrToFloat(edt_rec1_on.Text);
  Receita[1].TempoOFF :=StrToFloat(edt_rec1_off.Text);
  Receita[1].Histerese:=StrToFloat(edt_rec1_histerese.Text);

  Receita[2].Nome     :=           edt_rec2_nome.Text;
  Receita[2].SetPoint :=StrToFloat(edt_rec2_setpoint.Text);
  Receita[2].TempoON  :=StrToFloat(edt_rec2_on.Text);
  Receita[2].TempoOFF :=StrToFloat(edt_rec2_off.Text);
  Receita[2].Histerese:=StrToFloat(edt_rec2_histerese.Text);

  Receita[3].Nome     :=           edt_rec3_nome.Text;
  Receita[3].SetPoint :=StrToFloat(edt_rec3_setpoint.Text);
  Receita[3].TempoON  :=StrToFloat(edt_rec3_on.Text);
  Receita[3].TempoOFF :=StrToFloat(edt_rec3_off.Text);
  Receita[3].Histerese:=StrToFloat(edt_rec3_histerese.Text);

  Receita[4].Nome     :=           edt_rec4_nome.Text;
  Receita[4].SetPoint :=StrToFloat(edt_rec4_setpoint.Text);
  Receita[4].TempoON  :=StrToFloat(edt_rec4_on.Text);
  Receita[4].TempoOFF :=StrToFloat(edt_rec4_off.Text);
  Receita[4].Histerese:=StrToFloat(edt_rec4_histerese.Text);

  Receita[5].Nome     :=           edt_rec5_nome.Text;
  Receita[5].SetPoint :=StrToFloat(edt_rec5_setpoint.Text);
  Receita[5].TempoON  :=StrToFloat(edt_rec5_on.Text);
  Receita[5].TempoOFF :=StrToFloat(edt_rec5_off.Text);
  Receita[5].Histerese:=StrToFloat(edt_rec5_histerese.Text);

  Receita[6].Nome     :=           edt_rec6_nome.Text;
  Receita[6].SetPoint :=StrToFloat(edt_rec6_setpoint.Text);
  Receita[6].TempoON  :=StrToFloat(edt_rec6_on.Text);
  Receita[6].TempoOFF :=StrToFloat(edt_rec6_off.Text);
  Receita[6].Histerese:=StrToFloat(edt_rec6_histerese.Text);

  Receita[7].Nome     :=           edt_rec7_nome.Text;
  Receita[7].SetPoint :=StrToFloat(edt_rec7_setpoint.Text);
  Receita[7].TempoON  :=StrToFloat(edt_rec7_on.Text);
  Receita[7].TempoOFF :=StrToFloat(edt_rec7_off.Text);
  Receita[7].Histerese:=StrToFloat(edt_rec7_histerese.Text);


end;

procedure TForm1.ReceitaToTEdit();
begin
  edt_rec0_nome.text     :=Receita[0].Nome;
  edt_rec0_setpoint.text :=floattostr(Receita[0].SetPoint);
  edt_rec0_on.Text       :=floattostr(Receita[0].TempoON);
  edt_rec0_off.Text      :=floattostr(Receita[0].TempoOFF);
  edt_rec0_histerese.Text:=floattostr(Receita[0].Histerese);

  edt_rec1_nome.text     :=Receita[1].Nome;
  edt_rec1_setpoint.text :=floattostr(Receita[1].SetPoint);
  edt_rec1_on.Text       :=floattostr(Receita[1].TempoON);
  edt_rec1_off.Text      :=floattostr(Receita[1].TempoOFF);
  edt_rec1_histerese.Text:=floattostr(Receita[1].Histerese);

  edt_rec2_nome.text     :=Receita[2].Nome;
  edt_rec2_setpoint.text :=floattostr(Receita[2].SetPoint);
  edt_rec2_on.Text       :=floattostr(Receita[2].TempoON);
  edt_rec2_off.Text      :=floattostr(Receita[2].TempoOFF);
  edt_rec2_histerese.Text:=floattostr(Receita[2].Histerese);

  edt_rec3_nome.text     :=Receita[3].Nome;
  edt_rec3_setpoint.text :=floattostr(Receita[3].SetPoint);
  edt_rec3_on.Text       :=floattostr(Receita[3].TempoON);
  edt_rec3_off.Text      :=floattostr(Receita[3].TempoOFF);
  edt_rec3_histerese.Text:=floattostr(Receita[3].Histerese);

  edt_rec4_nome.text     :=Receita[4].Nome;
  edt_rec4_setpoint.text :=floattostr(Receita[4].SetPoint);
  edt_rec4_on.Text       :=floattostr(Receita[4].TempoON);
  edt_rec4_off.Text      :=floattostr(Receita[4].TempoOFF);
  edt_rec4_histerese.Text:=floattostr(Receita[4].Histerese);

  edt_rec5_nome.text     :=Receita[5].Nome;
  edt_rec5_setpoint.text :=floattostr(Receita[5].SetPoint);
  edt_rec5_on.Text       :=floattostr(Receita[5].TempoON);
  edt_rec5_off.Text      :=floattostr(Receita[5].TempoOFF);
  edt_rec5_histerese.Text:=floattostr(Receita[5].Histerese);

  edt_rec6_nome.text     :=Receita[6].Nome;
  edt_rec6_setpoint.text :=floattostr(Receita[6].SetPoint);
  edt_rec6_on.Text       :=floattostr(Receita[6].TempoON);
  edt_rec6_off.Text      :=floattostr(Receita[6].TempoOFF);
  edt_rec6_histerese.Text:=floattostr(Receita[6].Histerese);

  edt_rec7_nome.text     :=Receita[7].Nome;
  edt_rec7_setpoint.text :=floattostr(Receita[7].SetPoint);
  edt_rec7_on.Text       :=floattostr(Receita[7].TempoON);
  edt_rec7_off.Text      :=floattostr(Receita[7].TempoOFF);
  edt_rec7_histerese.Text:=floattostr(Receita[7].Histerese);

end;

procedure TForm1.GravarReceita();
var
  ArqINI : TIniFile;
begin
  ArqINI:= TIniFile.Create(ExtractFilePath(ParamSTR(0))+'Receita.ini');
  try
    ReceitaFromTEdit();

    ArqINI.WriteString('Receita0','Nome',     Receita[0].Nome);
    ArqINI.WriteFloat ('Receita0','SetPoint', Receita[0].SetPoint);
    ArqINI.WriteFloat ('Receita0','TempoON',  Receita[0].TempoON);
    ArqINI.WriteFloat ('Receita0','TempoOFF', Receita[0].TempoOFF);
    ArqINI.WriteFloat ('Receita0','Histerese',Receita[0].Histerese);

    ArqINI.WriteString('Receita1','Nome',     Receita[1].Nome);
    ArqINI.WriteFloat ('Receita1','SetPoint', Receita[1].SetPoint);
    ArqINI.WriteFloat ('Receita1','TempoON',  Receita[1].TempoON);
    ArqINI.WriteFloat ('Receita1','TempoOFF', Receita[1].TempoOFF);
    ArqINI.WriteFloat ('Receita1','Histerese',Receita[1].Histerese);

    ArqINI.WriteString('Receita2','Nome',     Receita[2].Nome);
    ArqINI.WriteFloat ('Receita2','SetPoint', Receita[2].SetPoint);
    ArqINI.WriteFloat ('Receita2','TempoON',  Receita[2].TempoON);
    ArqINI.WriteFloat ('Receita2','TempoOFF', Receita[2].TempoOFF);
    ArqINI.WriteFloat ('Receita2','Histerese',Receita[2].Histerese);

    ArqINI.WriteString('Receita3','Nome',     Receita[3].Nome);
    ArqINI.WriteFloat ('Receita3','SetPoint', Receita[3].SetPoint);
    ArqINI.WriteFloat ('Receita3','TempoON',  Receita[3].TempoON);
    ArqINI.WriteFloat ('Receita3','TempoOFF', Receita[3].TempoOFF);
    ArqINI.WriteFloat ('Receita3','Histerese',Receita[3].Histerese);

    ArqINI.WriteString('Receita4','Nome',     Receita[4].Nome);
    ArqINI.WriteFloat ('Receita4','SetPoint', Receita[4].SetPoint);
    ArqINI.WriteFloat ('Receita4','TempoON',  Receita[4].TempoON);
    ArqINI.WriteFloat ('Receita4','TempoOFF', Receita[4].TempoOFF);
    ArqINI.WriteFloat ('Receita4','Histerese',Receita[4].Histerese);

    ArqINI.WriteString('Receita5','Nome',     Receita[5].Nome);
    ArqINI.WriteFloat ('Receita5','SetPoint', Receita[5].SetPoint);
    ArqINI.WriteFloat ('Receita5','TempoON',  Receita[5].TempoON);
    ArqINI.WriteFloat ('Receita5','TempoOFF', Receita[5].TempoOFF);
    ArqINI.WriteFloat ('Receita5','Histerese',Receita[5].Histerese);

    ArqINI.WriteString('Receita6','Nome',     Receita[6].Nome);
    ArqINI.WriteFloat ('Receita6','SetPoint', Receita[6].SetPoint);
    ArqINI.WriteFloat ('Receita6','TempoON',  Receita[6].TempoON);
    ArqINI.WriteFloat ('Receita6','TempoOFF', Receita[6].TempoOFF);
    ArqINI.WriteFloat ('Receita6','Histerese',Receita[6].Histerese);

    ArqINI.WriteString('Receita7','Nome',     Receita[7].Nome);
    ArqINI.WriteFloat ('Receita7','SetPoint', Receita[7].SetPoint);
    ArqINI.WriteFloat ('Receita7','TempoON',  Receita[7].TempoON);
    ArqINI.WriteFloat ('Receita7','TempoOFF', Receita[7].TempoOFF);
    ArqINI.WriteFloat ('Receita7','Histerese',Receita[7].Histerese);
  finally
    FreeAndNil(ArqINI);
  end;

end;


procedure TForm1.RecuperarReceita();
var
  ArqINI : TIniFile;
begin
  ArqINI:= TIniFile.Create(ExtractFilePath(ParamSTR(0))+'Receita.ini');
  try
  Receita[0].Nome     := ArqINI.ReadString('Receita0','Nome',    '<none>');
  Receita[0].SetPoint := ArqINI.ReadFloat ('Receita0','SetPoint', 0.0);
  Receita[0].TempoON  := ArqINI.ReadFloat ('Receita0','TempoON',  0.0);
  Receita[0].TempoOFF := ArqINI.ReadFloat ('Receita0','TempoOFF', 0.0);
  Receita[0].Histerese:= ArqINI.ReadFloat ('Receita0','Histerese',0.0);

  Receita[1].Nome     := ArqINI.ReadString('Receita1','Nome',    '<none>');
  Receita[1].SetPoint := ArqINI.ReadFloat ('Receita1','SetPoint', 0.0);
  Receita[1].TempoON  := ArqINI.ReadFloat ('Receita1','TempoON',  0.0);
  Receita[1].TempoOFF := ArqINI.ReadFloat ('Receita1','TempoOFF', 0.0);
  Receita[1].Histerese:= ArqINI.ReadFloat ('Receita1','Histerese',0.0);

  Receita[2].Nome     := ArqINI.ReadString('Receita2','Nome',    '<none>');
  Receita[2].SetPoint := ArqINI.ReadFloat ('Receita2','SetPoint', 0.0);
  Receita[2].TempoON  := ArqINI.ReadFloat ('Receita2','TempoON',  0.0);
  Receita[2].TempoOFF := ArqINI.ReadFloat ('Receita2','TempoOFF', 0.0);
  Receita[2].Histerese:= ArqINI.ReadFloat ('Receita2','Histerese',0.0);

  Receita[3].Nome     := ArqINI.ReadString('Receita3','Nome',    '<none>');
  Receita[3].SetPoint := ArqINI.ReadFloat ('Receita3','SetPoint', 0.0);
  Receita[3].TempoON  := ArqINI.ReadFloat ('Receita3','TempoON',  0.0);
  Receita[3].TempoOFF := ArqINI.ReadFloat ('Receita3','TempoOFF', 0.0);
  Receita[3].Histerese:= ArqINI.ReadFloat ('Receita3','Histerese',0.0);

  Receita[4].Nome     := ArqINI.ReadString('Receita4','Nome',    '<none>');
  Receita[4].SetPoint := ArqINI.ReadFloat ('Receita4','SetPoint', 0.0);
  Receita[4].TempoON  := ArqINI.ReadFloat ('Receita4','TempoON',  0.0);
  Receita[4].TempoOFF := ArqINI.ReadFloat ('Receita4','TempoOFF', 0.0);
  Receita[4].Histerese:= ArqINI.ReadFloat ('Receita4','Histerese',0.0);

  Receita[5].Nome     := ArqINI.ReadString('Receita5','Nome',    '<none>');
  Receita[5].SetPoint := ArqINI.ReadFloat ('Receita5','SetPoint', 0.0);
  Receita[5].TempoON  := ArqINI.ReadFloat ('Receita5','TempoON',  0.0);
  Receita[5].TempoOFF := ArqINI.ReadFloat ('Receita5','TempoOFF', 0.0);
  Receita[5].Histerese:= ArqINI.ReadFloat ('Receita5','Histerese',0.0);

  Receita[6].Nome     := ArqINI.ReadString('Receita6','Nome',    '<none>');
  Receita[6].SetPoint := ArqINI.ReadFloat ('Receita6','SetPoint', 0.0);
  Receita[6].TempoON  := ArqINI.ReadFloat ('Receita6','TempoON',  0.0);
  Receita[6].TempoOFF := ArqINI.ReadFloat ('Receita6','TempoOFF', 0.0);
  Receita[6].Histerese:= ArqINI.ReadFloat ('Receita6','Histerese',0.0);

  Receita[7].Nome     := ArqINI.ReadString('Receita7','Nome',    '<none>');
  Receita[7].SetPoint := ArqINI.ReadFloat ('Receita7','SetPoint', 0.0);
  Receita[7].TempoON  := ArqINI.ReadFloat ('Receita7','TempoON',  0.0);
  Receita[7].TempoOFF := ArqINI.ReadFloat ('Receita7','TempoOFF', 0.0);
  Receita[7].Histerese:= ArqINI.ReadFloat ('Receita7','Histerese',0.0);

  ReceitaToTEdit();

  finally
    FreeAndNil(ArqINI);
  end;
end;

end.

