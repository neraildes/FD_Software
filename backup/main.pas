unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Laz_Kernel_Serial;

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
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
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
    Panel2: TPanel;
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
    Timer1: TTimer;
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
    procedure chk_EEPROM_16BitsChange(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure gpb_proculusClick(Sender: TObject);
    procedure Label10Click(Sender: TObject);
    procedure ListaAdd(cmd:string);
    function  ListaUse():string;
    procedure ControledePaginasChange(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure RadioButton1Change(Sender: TObject);
    procedure rb_24C1025Change(Sender: TObject);
    procedure rb_EEPROMChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
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
end;

procedure TForm1.gpb_proculusClick(Sender: TObject);
begin

end;

procedure TForm1.Label10Click(Sender: TObject);
begin

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
             Aparelho.Ler_EEPROM_16bits_Interna_Mae(Sender,
                                              strtoint(edt_eeprom_add.Text))

          else
             Aparelho.Ler_EEPROM_16bits_Interna_Filha(Sender,
                                                strtoint(edt_eeprom_placa.text),
                                                strtoint(edt_eeprom_add.Text));


         end
     else
         begin
           if(StrToInt(edt_eeprom_placa.text)=0)  then
              Aparelho.Ler_EEPROM_8bits_Interna_Mae(Sender,
                                              strtoint(edt_eeprom_add.Text))

           else
              Aparelho.Ler_EEPROM_8bits_Interna_Filha(Sender,
                                                strtoint(edt_eeprom_placa.text),
                                                strtoint(edt_eeprom_add.Text));

         end
     end
  else
  begin
  if(chk_EEPROM_16Bits.Checked) then
      begin
       if(StrToInt(edt_eeprom_placa.text)=0)  then
          Aparelho.Ler_EEPROM_16bits_24C1025_Mae(Sender,
                                           strtoint(edt_eeprom_chip.Text),
                                           strtoint(edt_eeprom_add.Text))

       else
          Aparelho.Ler_EEPROM_16bits_24C1025_Filha(Sender,
                                             strtoint(edt_eeprom_placa.text),
                                             strtoint(edt_eeprom_chip.Text),
                                             strtoint(edt_eeprom_add.Text));


      end
  else
      begin
        if(StrToInt(edt_eeprom_placa.text)=0)  then
           Aparelho.Ler_EEPROM_8bits_24C1025_Mae(Sender,
                                           strtoint(edt_eeprom_chip.Text),
                                           strtoint(edt_eeprom_add.Text))

        else
           Aparelho.Ler_EEPROM_8bits_24C1025_Filha(Sender,
                                             strtoint(edt_eeprom_placa.text),
                                             strtoint(edt_eeprom_chip.Text),
                                             strtoint(edt_eeprom_add.Text));

      end
  end


end;

procedure TForm1.btn_vp_string_readClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Read_VP_String(Sender, strtoint(edt_vp_string.Text));
end;

procedure TForm1.btn_vp_strinng_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Write_VP_String(Sender,
                                    strtoint(edt_vp_string.Text),
                                    strtoint(edt_vp_string_value.Text)
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
var
  valor:integer;
begin
  Edt_buz_return.text:='';
  valor:=strtoint(Edt_ss_time.text);
  inc(valor);
  Edt_ss_time.text:=inttostr(valor);
  Aparelho.Buzzer(Sender, strtoint(Edt_ss_time.text));
end;

procedure TForm1.btn_Control_Active_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Control_Active(Sender,strtoint(edt_control_active.Text));
end;

procedure TForm1.btn_EscreverMemoClick(Sender: TObject);
begin
  edt_eeprom_reply.text:='';
  if(rb_EEPROM.Checked) then  //Memória interna do Microcontrolador
     begin
     if(chk_EEPROM_16Bits.Checked) then  //Dados com 16 bits
         begin
          if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
             Aparelho.Gravar_EEPROM_16bits_Interna_Mae(Sender,
                                              strtoint(edt_eeprom_add.Text),
                                              strtoint(edt_eeprom_value.Text))
          else                                         //Atuação na placa filha
             Aparelho.Gravar_EEPROM_16bits_Interna_Filha(Sender,
                                                strtoint(edt_eeprom_placa.text),
                                                strtoint(edt_eeprom_add.Text),
                                                strtoint(edt_eeprom_value.Text));

         end
     else     //Dados com 8 bits de tamanho
         begin
           if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
              Aparelho.Gravar_EEPROM_8bits_Interna_Mae(Sender,
                                              strtoint(edt_eeprom_add.Text),
                                              strtoint(edt_eeprom_value.Text))
           else                                          //Atuacao na placa filha
              Aparelho.Gravar_EEPROM_8bits_Interna_Filha(Sender,
                                                strtoint(edt_eeprom_placa.text),
                                                strtoint(edt_eeprom_add.Text),
                                                strtoint(edt_eeprom_value.Text));
         end
     end
  else      //Memoria Externa do Microcontrolador (24C1025)
     begin
       if(chk_EEPROM_16Bits.Checked) then  //Dados com 16 bits
           begin
            if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
               Aparelho.Gravar_EEPROM_16bits_24C1025_Mae(Sender,
                                                strtoint(edt_eeprom_chip.Text),
                                                strtoint(edt_eeprom_add.Text),
                                                strtoint(edt_eeprom_value.Text))
            else
              Aparelho.Gravar_EEPROM_16bits_24C1025_Filha(Sender,
                                                 strtoint(edt_eeprom_placa.text),
                                                 strtoint(edt_eeprom_chip.Text),
                                                 strtoint(edt_eeprom_add.Text),
                                                 strtoint(edt_eeprom_value.Text))
            end
       else
          begin
            if(StrToInt(edt_eeprom_placa.text)=0)  then   //Atuacao na placa mãe
               Aparelho.Gravar_EEPROM_8bits_24C1025_Mae(Sender,
                                               strtoint(edt_eeprom_chip.Text),
                                               strtoint(edt_eeprom_add.Text),
                                               strtoint(edt_eeprom_value.Text))
            else
               Aparelho.Gravar_EEPROM_8bits_24C1025_Filha(Sender,
                                                 strtoint(edt_eeprom_placa.text),
                                                 strtoint(edt_eeprom_chip.Text),
                                                 strtoint(edt_eeprom_add.Text),
                                                 strtoint(edt_eeprom_value.Text))

          end;
     end;
end;

procedure TForm1.btn_fillClick(Sender: TObject);
begin
  Aparelho.EEPROM_24C1025_Fill_All(Sender,
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
        Aparelho.Ler_EEPROM_16bits_24C1025_Mae(Sender,0, AddConfere);
        AddConfere:=AddConfere+2;
      end;
end;

procedure TForm1.btn_gravar_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Write_VP_Int(Sender,
                                 strtoint(edt_vp_add_int.Text),
                                 strtoint(edt_vp_value_int.Text)
                                 );
end;

procedure TForm1.btn_ler_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Read_VP_Int(Sender,strtoint(edt_vp_add_int.Text));
end;

procedure TForm1.btn_page_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Set_Page(Sender,strtoint(edt_page.Text));
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
  HardReply:string;


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
        Form1.Memo1.Lines.Add(strtmp);
        if (POS('CDCDCD', strtmp)>0) then
            begin
             CountCOM:=5;
             if(Aparelho.FilaFim>0) then
                begin
                 Form1.Memo1.Lines.Add('<<<<<<<<<<<<ENTROU');
                 node:=Aparelho.fila[0].comando;

                 if (Aparelho.fila[0].ObjOrigem<>nil)  then
                      begin
                        Aparelho.kernelSerial(node); //ENVIA EFETIVAMENTE OS COMANDOS
                        if (Aparelho.fila[0].ObjOrigem.InheritsFrom(TButton)) then
                            begin
                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='Btn_Buzzer') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_EscreverMemo') then
                                 begin
                                 HardReply:=copy((Aparelho.HexToText(Aparelho.fila[0].result)),1,2);
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=HardReply;
                                 if(HardReply='NR') then
                                    begin
                                      Form1.Timer1.Enabled:=FALSE;
                                      showmessage('A T E N Ç Ã O'+#13+'O Hardware Destino (Placa) não respondeu!');
                                      Form1.Timer1.Enabled:=TRUE;
                                    end;
                                 end;

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_LerMemo') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.fila[0].result;

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_fill') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_fill_confere') then
                                 begin
                                   Form1.Memo3.Lines.Add(Copy(Aparelho.fila[0].comando,15,8)+' - '+
                                                              Aparelho.fila[0].result);
                                 end;

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_gravar_vp_int') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_ler_vp_int') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Inttostr(Aparelho.HexToInt(Aparelho.fila[0].result));////StrtoInt('$23');

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_page_write') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_Control_Active_write') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);

                             if (TButton(Aparelho.fila[0].ObjOrigem).Name='btn_vp_string_read') then
                                 TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);


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

procedure TForm1.ControledePaginasChange(Sender: TObject);
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

procedure TForm1.Timer1Timer(Sender: TObject);
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

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin

end;



end.

