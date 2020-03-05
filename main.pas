unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls, Grids, Menus, Buttons, Laz_Kernel_Serial, Types, Inifiles, LCLType,
  TAGraph, TASeries, TASources, TADrawUtils, TACustomSeries, Windows;

const
  DESCONECTAR = 0;
  CONECTAR    = 1;

type

  {Receita}
  TReceita = record
    Nome     : string[30];
    SetPoint : real;
    TempoON  : real;
    TempoOFF : real;
    Histerese: real;
  end;

  {TEMPO}
  TTempo = record
   data  : string[10];
   hora  : string[10];
  end;

  {FAT8}
   TfAT8 = record
     process_number : integer;
     inicio : TTempo;
     fim    : TTempo;
     amostra: byte;
     add_start : cardinal;
     add_end   : cardinal;
     minutes   : integer;
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
    bib_DataLog: TBitBtn;
    bib_Condensador: TBitBtn;
    bib_Vacuo: TBitBtn;
    bib_Aquecimento: TBitBtn;
    Btn_Buzzer: TButton;
    btn_Control_Active_write: TButton;
    btn_EscreverMemo: TButton;
    btn_fill: TButton;
    btn_fill_confere: TButton;
    btn_gravar_vp_int: TButton;
    btn_LerMemo: TButton;
    btn_ler_vp_int: TButton;
    btn_page_write: TButton;
    btn_EE_Read_Buffer: TButton;
    btn_resume: TButton;
    btn_suspend: TButton;
    btn_Ler_RTC: TButton;
    Button1: TButton;
    Button10: TButton;
    btn_Config_Ler: TButton;
    btn_Config_Gravar: TButton;
    btn_baixar_dados_grafico: TButton;
    btn_Ler24C32Bits: TButton;
    btn_Write_Buffer: TButton;
    Button11: TButton;
    Button6: TButton;
    Button7: TButton;
    cbb_programa: TComboBox;
    chk_EEPROM_32Bits: TCheckBox;
    edt_saida32bytes: TEdit;
    edt_ADD_EEE_Buffer_Size: TEdit;
    edt_Chip_String: TEdit;
    edt_placa_String: TEdit;
    edt_Chip_Buffer: TEdit;
    edt_ADD_Buffer: TEdit;
    edt_EEE_R_STR: TEdit;
    edt_fill: TEdit;
    edt_fill_chip: TEdit;
    edt_fill_destino: TEdit;
    edt_fill_reply: TEdit;
    edt_placa_Buffer: TEdit;
    edt_24C_32B_add: TEdit;
    edt_24c_32bits: TEdit;
    edt_IO_Buffer: TEdit;
    edt_saidaprg: TEdit;
    edt_saida_24STRING: TEdit;
    EEE_241025_STRING: TGroupBox;
    gpb_24C1025_32Bits: TGroupBox;
    gpb_eeprom_buffer: TGroupBox;
    Gravar_EEE_24C: TButton;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Button2: TButton;
    btn_vp_string_read: TButton;
    btn_vp_strinng_write: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    btn_pagina1: TButton;
    btn_pagina2: TButton;
    Button8: TButton;
    Button9: TButton;
    cbb0: TComboBox;
    cbb3: TComboBox;
    cbb4: TComboBox;
    cbb5: TComboBox;
    cbb6: TComboBox;
    cbb7: TComboBox;
    cbb8: TComboBox;
    cbb9: TComboBox;
    cbb1: TComboBox;
    cbb2: TComboBox;
    cbb_COMPORT: TComboBox;
    Chart1: TChart;
    Chart2: TChart;
    cls_temperatura_NTC_03: TLineSeries;
    cls_temperatura_NTC_04: TLineSeries;
    cls_temperatura_NTC_05: TLineSeries;
    cls_temperatura_NTC_06: TLineSeries;
    cls_temperatura_NTC_07: TLineSeries;
    cls_temperatura_NTC_08: TLineSeries;
    cls_temperatura_NTC_09: TLineSeries;
    cls_temperatura_NTC_10: TLineSeries;
    cls_temperatura_NTC_02: TLineSeries;
    Chart3: TChart;
    cls_tensao: TLineSeries;
    cls_temperatura_NTC_01: TLineSeries;
    chl_condensador: TLineSeries;
    cht_vacuo: TChart;
    chl_vacuo: TLineSeries;
    ckb_time_pc: TCheckBox;
    edit_saidafat8: TEdit;
    edt_tmp_data: TEdit;
    edt_tmp_hora: TEdit;
    edt_time_process: TEdit;
    edt_DisplaySize: TEdit;
    edt_time_process_reply: TEdit;
    edt_Vacuo_Alarme: TEdit;
    edt_Aquecimento_Seg_Condensador: TEdit;
    edt_Aquecimento_Seg_Vacuo: TEdit;
    edt_Condensador_Libera_Vacuo: TEdit;
    edt_buffer: TEdit;
    btn_time_process_read: TButton;
    GroupBox10: TGroupBox;
    GroupBox11: TGroupBox;
    GroupBox12: TGroupBox;
    GroupBox13: TGroupBox;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    gpb_relogio: TGroupBox;
    GroupBox17: TGroupBox;
    GroupBox9: TGroupBox;
    btn_EE_Read_String: TButton;
    btn_Write_String: TButton;
    chk_EEPROM_16Bits: TCheckBox;
    Folha_de_Abas: TPageControl;
    Edit1: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit2: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit3: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit4: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    Edit49: TEdit;
    Edit5: TEdit;
    Edit51: TEdit;
    Edit52: TEdit;
    Edit53: TEdit;
    Edit54: TEdit;
    Edit55: TEdit;
    Edit56: TEdit;
    Edit58: TEdit;
    Edit59: TEdit;
    Edit6: TEdit;
    Edit60: TEdit;
    Edit61: TEdit;
    Edit62: TEdit;
    Edit63: TEdit;
    Edit65: TEdit;
    Edit66: TEdit;
    Edit67: TEdit;
    Edit68: TEdit;
    Edit69: TEdit;
    Edit7: TEdit;
    Edit70: TEdit;
    edt_ADD_String: TEdit;
    edt_IO_String: TEdit;
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
    Edit9: TEdit;
    Edt_buz_return: TEdit;
    edt_control_active: TEdit;
    edt_control_active_reply: TEdit;
    edt_eeprom_add: TEdit;
    edt_eeprom_chip: TEdit;
    edt_eeprom_placa: TEdit;
    edt_eeprom_reply: TEdit;
    edt_eeprom_value: TEdit;
    edt_page: TEdit;
    edt_page_reply: TEdit;
    Edt_ss_time: TEdit;
    edt_vp_add_int: TEdit;
    edt_vp_value_int: TEdit;
    edt_vp_value_int_reply: TEdit;
    gpb_proculus: TGroupBox;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
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
    lbl_executando_processo: TLabel;
    lbl_condensador: TLabel;
    lbl_vacuometro: TLabel;
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
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    lbl_Tensao: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Lbl_Count: TLabel;
    lcs_pt100_condensador: TListChartSource;
    lcs_Plataforma_NTC_01: TListChartSource;
    lcs_vacuometro: TListChartSource;
    lcs_tensao: TListChartSource;
    lcs_Plataforma_NTC_02: TListChartSource;
    lcs_Plataforma_NTC_03: TListChartSource;
    lcs_Plataforma_NTC_04: TListChartSource;
    lcs_Plataforma_NTC_05: TListChartSource;
    lcs_Plataforma_NTC_06: TListChartSource;
    lcs_Plataforma_NTC_07: TListChartSource;
    lcs_Plataforma_NTC_08: TListChartSource;
    lcs_Plataforma_NTC_09: TListChartSource;
    lcs_Plataforma_NTC_10: TListChartSource;
    Ler_EEE_24C: TButton;
    MainMenu1: TMainMenu;
    Mem_Grafico: TMemo;
    Panel21: TPanel;
    GraficoMEMO: TTabSheet;
    PopupMenu1: TPopupMenu;
    pgb_Graphic_Load: TProgressBar;
    pgb_load_data_graphic: TProgressBar;
    rdb_Buffer_24C1025: TRadioButton;
    rdb_String_24C1025: TRadioButton;
    rdb_Buffer_EEPROM: TRadioButton;
    rdb_String_EEPROM: TRadioButton;
    TabSheet1: TTabSheet;
    tbs_manutencao: TTabSheet;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    Memo4: TMemo;
    MenuItem1: TMenuItem;
    Menu_Upload: TMenuItem;
    Menu_Format: TMenuItem;
    tbs_pagina_principal: TTabSheet;
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
    Pn_COM_Check: TPanel;
    rb_24C1025: TRadioButton;
    rb_EEPROM: TRadioButton;
    tbs_grafico: TTabSheet;
    tmr_vacuo: TTimer;
    tmr_online: TTimer;
    tmr_temperaturas: TTimer;
    tbs_receitas: TTabSheet;
    tbs_parametros: TTabSheet;
    tmr_condensador: TTimer;
    ToggleBox1: TToggleBox;
    ToggleBox10: TToggleBox;
    tgb_Serial: TToggleBox;
    ToggleBox2: TToggleBox;
    ToggleBox3: TToggleBox;
    ToggleBox4: TToggleBox;
    ToggleBox5: TToggleBox;
    ToggleBox6: TToggleBox;
    ToggleBox7: TToggleBox;
    ToggleBox8: TToggleBox;
    ToggleBox9: TToggleBox;
    procedure bib_AquecimentoClick(Sender: TObject);
    procedure bib_CondensadorClick(Sender: TObject);
    procedure bib_DataLogClick(Sender: TObject);
    procedure bib_VacuoClick(Sender: TObject);
    procedure Btn_BuzzerClick(Sender: TObject);
    procedure btn_Config_GravarClick(Sender: TObject);
    procedure btn_Config_LerClick(Sender: TObject);
    procedure btn_Control_Active_writeClick(Sender: TObject);
    procedure btn_EscreverMemoClick(Sender: TObject);
    procedure btn_fillClick(Sender: TObject);
    procedure btn_gravar_vp_intClick(Sender: TObject);
    procedure btn_Ler24C32BitsClick(Sender: TObject);
    procedure btn_Ler_RTCClick(Sender: TObject);
    procedure btn_ler_vp_intClick(Sender: TObject);
    procedure btn_page_writeClick(Sender: TObject);
    procedure btn_pagina1Click(Sender: TObject);
    procedure btn_pagina2Click(Sender: TObject);
    procedure btn_EE_Read_BufferClick(Sender: TObject);
    procedure btn_resumeClick(Sender: TObject);
    procedure btn_suspendClick(Sender: TObject);
    procedure btn_LerMemoClick(Sender: TObject);
    procedure btn_time_process_readClick(Sender: TObject);
    procedure btn_vp_string_readClick(Sender: TObject);
    procedure btn_vp_strinng_writeClick(Sender: TObject);
    procedure btn_Write_BufferClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure btn_baixar_dados_graficoClick(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure cbb_programaChange(Sender: TObject);
    procedure edt_IO_StringChange(Sender: TObject);
    procedure Ler_EEE_24CClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure cbb3Change(Sender: TObject);
    procedure cbb4Change(Sender: TObject);
    procedure cbb5Change(Sender: TObject);
    procedure cbb6Change(Sender: TObject);
    procedure cbb7Change(Sender: TObject);
    procedure cbb8Change(Sender: TObject);
    procedure cbb9Change(Sender: TObject);
    procedure chk_EEPROM_16BitsChange(Sender: TObject);
    procedure cbb0Change(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure cbb2Change(Sender: TObject);
    procedure Folha_de_AbasChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_EE_Read_StringClick(Sender: TObject);
    procedure btn_Write_StringClick(Sender: TObject);
    procedure tmr_condensadorTimer(Sender: TObject);
    procedure tmr_temperaturasTimer(Sender: TObject);
    procedure ListaAdd(cmd:string);
    function  ListaUse():string;
    procedure Menu_UploadClick(Sender: TObject);
    procedure Menu_FormatClick(Sender: TObject);
    procedure rb_24C1025Change(Sender: TObject);
    procedure rb_EEPROMChange(Sender: TObject);
    procedure tmr_onlineTimer(Sender: TObject);
    procedure tgb_SerialChange(Sender: TObject);
    procedure tmr_vacuoTimer(Sender: TObject);
    procedure ToggleBox10Change(Sender: TObject);
    procedure ToggleBox1Change(Sender: TObject);
    procedure ToggleBox2Change(Sender: TObject);
    procedure ToggleBox3Change(Sender: TObject);
    procedure ToggleBox4Change(Sender: TObject);
    procedure ToggleBox5Change(Sender: TObject);
    procedure ToggleBox6Change(Sender: TObject);
    procedure ToggleBox7Change(Sender: TObject);
    procedure ToggleBox8Change(Sender: TObject);
    procedure For_Record_Receita_From_TEdit();
    procedure For_TEdit_From_Record_Receita();
    procedure PreencheComboBox();
    procedure EnviaReceitaParaPrograma(Mandador:Integer;index:integer);
    procedure ToggleBox9Change(Sender: TObject);
    procedure ToggleStatus(toggle:TObject; panel:TObject; mandador : integer);
    procedure Puxar_dados_de_programacao_do_Hardware();
    procedure Aguarda_Atualizacao_do_TEdit(objeto : TObject);
    procedure ConectarSerial(chave:integer);
    procedure Transferir_Lista_de_Receitas();
    procedure RecuperarReceita();
    procedure Recuperar_Config();
    procedure GravarReceita();
    procedure Gravar_Config();
    procedure AtualizaBotoes();
  private

  public

  end;

var
  Form1: TForm1;
  Aparelho : TSerial;
  ouvinte :  TThead_USART;
  CountCOM : integer;  //Indica se o sistema está online
  Receita : array [0..8] of TReceita;
  Fat8 : TFat8;



implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  CountCOM:=0;
  Folha_de_Abas.PageIndex:=1;

  //ConectarSerial(CONECTAR);
  //Aparelho.FilaFim:=0;
  //RecuperarReceita();
  //PreencheComboBox();
end;

procedure TForm1.AtualizaBotoes();
begin

//------------------------------------------------------------------------------
edt_buffer.text:='';
Aparelho.PROCULUS_Read_VP_Int(2,UINTEGER,edt_buffer);
Aguarda_Atualizacao_do_TEdit(edt_buffer);
if(strtoint(edt_buffer.text)=1) then bib_DataLog.Click;
//------------------------------------------------------------------------------
edt_buffer.text:='';
Aparelho.PROCULUS_Read_VP_Int(3,UINTEGER,edt_buffer);
Aguarda_Atualizacao_do_TEdit(edt_buffer);
if(strtoint(edt_buffer.text)=1) then bib_Condensador.Click;

//------------------------------------------------------------------------------
edt_buffer.text:='';
Aparelho.PROCULUS_Read_VP_Int(4,UINTEGER,edt_buffer);
Aguarda_Atualizacao_do_TEdit(edt_buffer);
if(strtoint(edt_buffer.text)=1) then bib_Vacuo.Click;
//------------------------------------------------------------------------------
edt_buffer.text:='';
Aparelho.PROCULUS_Read_VP_Int(5,UINTEGER,edt_buffer);
Aguarda_Atualizacao_do_TEdit(edt_buffer);
if(strtoint(edt_buffer.text)=1) then bib_Aquecimento.Click;
//------------------------------------------------------------------------------

end;




procedure TForm1.btn_EE_Read_StringClick(Sender: TObject);
begin
  if(rdb_String_24C1025.Checked=TRUE) then
      begin
      if(strtoint(edt_placa_String.text)>0) then
        Aparelho.Ler_EEPROM_24C1025_String_Filha(strtoint(edt_placa_String.text),
                                                 strtoint(edt_Chip_String.text),
                                                 strtoint(edt_ADD_String.Text),
                                                 TEXTO,
                                                 edt_IO_String)
        else
        Aparelho.Ler_EEPROM_24C1025_String_Mae(strtoint(edt_Chip_String.text),
                                                 strtoint(edt_ADD_String.Text),
                                                 TEXTO,
                                                 edt_IO_String);

        end;

  if(rdb_String_EEPROM.Checked=TRUE) then
     begin
       showmessage('Não Implementado');
     end;
end;

procedure TForm1.btn_Write_StringClick(Sender: TObject);
begin
  if(rdb_String_24C1025.Checked=TRUE) then
      begin
      if(strtoint(edt_placa_String.text)>0) then
      Aparelho.Gravar_24C1025_String_Filha(strtoint(edt_placa_String.text)
                                          ,strtoint(edt_Chip_String.text)
                                          ,strtoint(edt_ADD_String.text)
                                          ,edt_IO_String.text
                                          ,TEXTO
                                          ,edt_IO_String)
      else
      Aparelho.Gravar_24C1025_String_Mae( strtoint(edt_Chip_String.text)
                                         ,strtoint(edt_ADD_String.text)
                                         ,edt_IO_String.text
                                         ,TEXTO
                                         ,edt_IO_String);

      end;

  if(rdb_String_EEPROM.Checked=TRUE) then
     begin
       showmessage('Não Implementado');
     end;
end;

procedure TForm1.tmr_condensadorTimer(Sender: TObject);
begin
  tmr_condensador.Enabled:=FALSE;
end;

procedure TForm1.tmr_temperaturasTimer(Sender: TObject);
var
  condensador:real;
  Acondensador:real;
begin
  if(tmr_temperaturas.Interval<1000) then
     begin
      tmr_temperaturas.Interval:=10000;
      Recuperar_Config();
      RecuperarReceita();
      PreencheComboBox();
      AtualizaBotoes();
     end;

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

  Aparelho.Time_Process_Read(HORA,edt_time_process);

  edt_saidapadrao.text:='';
  Aparelho.PROCULUS_Read_VP_Int(176,UINTEGER,edt_saidaPadrao);
  Aguarda_Atualizacao_do_TEdit(edt_saidapadrao);
  if(edt_saidapadrao.text='1') then
     edt_condensador.color:=ClLime
  else if(edt_saidapadrao.text='0') then
     begin
     edt_condensador.color:=ClRed;
     //showmessage(edt_saidapadrao.text);
     end;
  {
  if(edt_Condensador_Libera_Vacuo.text<>'0') then
  lbl_condensador.caption:='CONDENSADOR ('+edt_Condensador_Libera_Vacuo.text+'°C)';
  }

  edt_saidapadrao.text:='';
  Aparelho.PROCULUS_Read_VP_Int(177,UINTEGER,edt_saidaPadrao);
  Aguarda_Atualizacao_do_TEdit(edt_saidapadrao);
  if(edt_saidapadrao.text='1') then
     edt_vacuometro.color:=ClLime
  else if(edt_saidapadrao.text='0') then
     edt_vacuometro.color:=ClRed;
  {
  if(edt_Vacuo_Alarme.text<>'0')then
  lbl_vacuometro.caption:='VACUÔMETRO ('+edt_Vacuo_Alarme.text+'mmHg)';
  }





  {
  edt_saidapadrao.text:='';
  Aparelho.Read_Analogic_Channel(2,0,FLUTUANTE,'',edt_saidapadrao);
  Aguarda_Atualizacao_do_TEdit(edt_saidapadrao);
  condensador:=strtofloat(edt_saidapadrao.text);

  edt_saidapadrao.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae($01,FLUTUANTE,edt_saidapadrao);
  Aguarda_Atualizacao_do_TEdit(edt_saidapadrao);
  Acondensador:=strtofloat(edt_saidapadrao.text);

  if(condensador<Acondensador) then
     edt_condensador.Color:=clLime
  else
     edt_condensador.Color:=clRed;
  }
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

procedure TForm1.btn_time_process_readClick(Sender: TObject);
begin
  Aparelho.Time_Process_Read(HORA,edt_time_process_reply);
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

procedure TForm1.btn_Write_BufferClick(Sender: TObject);
begin
   showmessage('Não Implementado');
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
    Aparelho.Format_Program(TEXTO,edt_saidapadrao);

    Edit4.text:='0';
    Edit3.text:='0';
    Edit5.text:='0';
    Edit7.text:='0';
    cbb0.Caption:=' ';
    ToggleBox1.Checked:=FALSE;

    Edit12.text:='0';
    Edit11.text:='0';
    Edit13.text:='0';
    Edit14.text:='0';
    cbb1.Caption:=' ';
    ToggleBox2.Checked:=FALSE;

    Edit19.text:='0';
    Edit18.text:='0';
    Edit20.text:='0';
    Edit21.text:='0';
    cbb2.Caption:=' ';
    ToggleBox3.Checked:=FALSE;

    Edit26.text:='0';
    Edit25.text:='0';
    Edit27.text:='0';
    Edit28.text:='0';
    cbb3.Caption:=' ';
    ToggleBox4.Checked:=FALSE;

    Edit33.text:='0';
    Edit32.text:='0';
    Edit34.text:='0';
    Edit35.text:='0';
    cbb4.Caption:=' ';
    ToggleBox5.Checked:=FALSE;

    Edit40.text:='0';
    Edit39.text:='0';
    Edit41.text:='0';
    Edit42.text:='0';
    cbb5.Caption:=' ';
    ToggleBox6.Checked:=FALSE;

    Edit47.text:='0';
    Edit46.text:='0';
    Edit48.text:='0';
    Edit49.text:='0';
    cbb6.Caption:=' ';
    ToggleBox7.Checked:=FALSE;

    Edit54.text:='0';
    Edit53.text:='0';
    Edit55.text:='0';
    Edit56.text:='0';
    cbb7.Caption:=' ';
    ToggleBox8.Checked:=FALSE;

    Edit61.text:='0';
    Edit60.text:='0';
    Edit62.text:='0';
    Edit63.text:='0';
    cbb8.Caption:=' ';
    ToggleBox9.Checked:=FALSE;

    Edit68.text:='0';
    Edit67.text:='0';
    Edit69.text:='0';
    Edit70.text:='0';
    cbb9.Caption:=' ';
    ToggleBox10.Checked:=FALSE;
end;

procedure TForm1.btn_baixar_dados_graficoClick(Sender: TObject);
var
  addeeprom : cardinal;
  index : integer;
  linha : string;
  horafim : string;
  linha32bytes:string;
begin
  tmr_temperaturas.Enabled:=FALSE;
  Mem_Grafico.Lines.Clear;
  cbb_programa.Items.Clear;

  Mem_Grafico.Lines.Add('Baixando dados dos Gráficos...');
  for index:=0 to 11 do
      begin
      Mem_Grafico.Lines.Add('Grafico número '+inttostr(index+1));
      pgb_Graphic_Load.Position:=index+1;
      addeeprom := (index*54)+$10;

      //edt_saida32bytes.text:='';
      Aparelho.Ler_EEPROM_24C1025_Buffer_Mae(0,addeeprom,32,HEXADECIMAL,edt_saida32bytes);
      Aguarda_Atualizacao_do_TEdit(edt_saida32bytes);
      linha32bytes:=edt_saida32bytes.text;

      fat8.process_number:=StrToInt(Aparelho.HextoNum(copy(linha32bytes,1,4)));
      fat8.inicio.data:=Aparelho.HextoNum(copy(linha32bytes,25,16));
      fat8.inicio.hora:=Aparelho.HextoNum(copy(linha32bytes,5,16));



      if(fat8.process_number>0) then
         begin
          //edt_saida32bytes.text:='';
          Aparelho.Ler_EEPROM_24C1025_Buffer_Mae(0,addeeprom+22,32,HEXADECIMAL,edt_saida32bytes);
          Aguarda_Atualizacao_do_TEdit(edt_saida32bytes);
          linha32bytes:=edt_saida32bytes.text;

          fat8.fim.data:=Aparelho.HextoNum(copy(linha32bytes,21,16));
          fat8.fim.hora:=Aparelho.HextoNum(copy(linha32bytes,1,16));


          //------------------------------------------------------------------------
          //edit_saidafat8.text:='';
          Aparelho.Ler_EEPROM_8bits_24C1025_Mae(0,addeeprom+42,UINTEGER,edit_saidafat8);
          Aguarda_Atualizacao_do_TEdit(edit_saidafat8);
          fat8.amostra:=strtoint(edit_saidafat8.text);
          //------------------------------------------------------------------------
          //edit_saidafat8.text:='';
          Aparelho.Ler_EEPROM_16bits_24C1025_Mae(0,addeeprom+51,UINTEGER,edit_saidafat8);
          Aguarda_Atualizacao_do_TEdit(edit_saidafat8);
          fat8.minutes:=strtoint(edit_saidafat8.text);
          //------------------------------------------------------------------------
          //edit_saidafat8.text:='';
          Aparelho.Ler_EEPROM_32bits_24C1025_Mae(0,addeeprom+43,UINTEGER,edit_saidafat8);
          Aguarda_Atualizacao_do_TEdit(edit_saidafat8);
          fat8.add_start:=strtoint(edit_saidafat8.text);
          //........................................................................
          //edit_saidafat8.text:='';
          Aparelho.Ler_EEPROM_32bits_24C1025_Mae(0,addeeprom+47,UINTEGER,edit_saidafat8);
          Aguarda_Atualizacao_do_TEdit(edit_saidafat8);
          fat8.add_end:=strtoint(edit_saidafat8.text);
          //------------------------------------------------------------------------



          {
          showmessage(inttostr(fat8.process_number)+#13+
                      'Data Inicio = '+fat8.inicio.data+#13+
                      'Hora Inicio = '+fat8.inicio.hora+#13+
                      'Data Fim    = '+fat8.fim.data+#13+
                      'Hora Fim    = '+fat8.fim.hora+#13+
                      'Amostra     = '+inttostr(fat8.amostra)+#13+
                      'Minutos     = '+inttostr(fat8.minutes)+#13+
                      'End. Inicial= '+inttostr(fat8.add_start)+#13+
                      'End. Final  = '+inttostr(fat8.add_end)
                      );
          }

           linha:= formatfloat('0000',fat8.process_number)+' - Iniciado em '+
                   fat8.inicio.data+' - '+
                   fat8.inicio.hora+' - encerrado em '+
                   fat8.fim.data+' - '+
                   fat8.fim.hora;
           cbb_programa.Items.Add(Linha);

           GraficoData[index].processo:=fat8.process_number;
           GraficoData[index].dataInicio:=fat8.inicio.data;
           GraficoData[index].horaInicio:=fat8.inicio.hora;
           GraficoData[index].dataFim:=fat8.fim.data;
           GraficoData[index].horaFim:=fat8.fim.hora;
           GraficoData[index].intervalo:=fat8.amostra;
           GraficoData[index].minutos:=fat8.minutes;
           GraficoData[index].addInicio:=fat8.add_start;
           GraficoData[index].addFim:=fat8.add_end;


        end;
     end;
     tmr_temperaturas.Enabled:=TRUE;
 end;

procedure TForm1.Button11Click(Sender: TObject);
begin
  edit_saidafat8.text:=Aparelho.HexToNum(edt_saida32bytes.text);
end;





procedure TForm1.cbb_programaChange(Sender: TObject);
var
  Addeeprom, Addeepromfim :integer;
  Linha : array [0..16] of string;
  LinhaPura : string;
  i: integer;
  placa, canal, a :integer;
  jjj:integer;
begin
 showmessage
 (
 'Endereco Inicial = '+inttostr(GraficoData[cbb_programa.ItemIndex].addInicio)+#13+
 'Endereco Final   = '+inttostr(GraficoData[cbb_programa.ItemIndex].addFim)
 );
 tmr_temperaturas.Enabled:=FALSE;
 Mem_Grafico.Lines.Clear;
 Addeeprom:=GraficoData[cbb_programa.ItemIndex].addInicio ;


 pgb_load_data_graphic.Min:=GraficoData[cbb_programa.ItemIndex].addInicio;
 pgb_load_data_graphic.Max:=GraficoData[cbb_programa.ItemIndex].addFim;
 while(addeeprom<=GraficoData[cbb_programa.ItemIndex].addFim) do
 begin


  //showmessage(linhapura);
  addeeprom:=GraficoData[cbb_programa.ItemIndex].addInicio;
  addeepromfim:=GraficoData[cbb_programa.ItemIndex].addFim;


  addeeprom:=addeeprom;// to addeepromfim  do inc(i,2)
  while(addeeprom<addeepromfim) do
                 begin
                   for i:=0 to 16 do Linha[i]:='';
                   for placa:=1 to 7 do
                       begin
                         for canal:=0 to 1 do
                             begin

                               edt_saida32bytes.text:='';
                               Aparelho.Ler_EEPROM_24C1025_Buffer_Filha(placa,canal,addeeprom,32,HEXADECIMAL,edt_saida32bytes);
                               Aguarda_Atualizacao_do_TEdit(edt_saida32bytes);
                               Linhapura:=edt_saida32bytes.text;
                               //Mem_Grafico.Lines.Add(Linhapura);


                               a:=addeeprom;
                               i:=0;

                               while(i<16)do
                                  begin
                                    Linha[i]:=Linha[i]+' ; '+Aparelho.HextoInfo(Copy(LinhaPura,(i*4)+1,4));
                                    inc(i);
                                    if i+addeeprom>GraficoData[cbb_programa.ItemIndex].addFim then break;
                                  end;

                             end;
                       end;

                       for jjj:=0 to 15 do
                           begin
                             Mem_Grafico.Lines.Add(Linha[jjj]);
                           end;

                    inc(addeeprom,16);
                 end;





  {
  for placa :=1 to  7 do
      begin
        for canal=0 to 1 do
            begin
              edt_saida32bytes.text:='';
              Aparelho.Ler_EEPROM_24C1025_Buffer_Filha(placa,canal,addeeprom,32,HEXADECIMAL,edt_saida32bytes);
              Aguarda_Atualizacao_do_TEdit(edt_saida32bytes);
              Linhapura:=edt_saida32bytes.text;

              i:=1;
              while(i<=16)do
                 begin
                   Linha[i]:=Copy(LinhaPura,(i*4)+1,4);
                   showmessage(LinhaPura+#13+Linha[i]);
                   inc(i);
                 end;


            end;
      end;

  }




  exit;










   //Mem_Grafico.Lines.Add(Linha);
   inc(addeeprom,2);
 end;
  tmr_temperaturas.Enabled:=TRUE;
end;

procedure TForm1.edt_IO_StringChange(Sender: TObject);
begin
  if(length(edt_IO_String.text)>32) then  edt_IO_String.text:=copy(edt_IO_String.text,1,32);
  keybd_event(vk_end, 0, 0, 0);
end;

procedure TForm1.Ler_EEE_24CClick(Sender: TObject);
begin
  edit_saidafat8.text:='';
  Aparelho.Ler_EEPROM_24C1025_String_Mae(0,strtoint(edt_EEE_R_STR.text),TEXTO,edt_saida_24STRING);
  Aguarda_Atualizacao_do_TEdit(edt_saida_24STRING);
  Memo1.Lines.Add(edt_saida_24STRING.text);
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
begin
  For_Record_Receita_From_TEdit();
  Transferir_Lista_de_Receitas();
  showmessage('Concluido!'+#13+'Aguarde Atualizacao!');
end;


procedure TForm1.Transferir_Lista_de_Receitas();
var
  index :integer;
  addeeprom:integer;
begin
for index:=0 to 7 do
    begin
    addeeprom:=256+(index*16);
    Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom+0,trunc(Receita[index].SetPoint*10),FLUTUANTE,edt_saidapadrao);
    Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+4,trunc(Receita[index].Histerese),FLUTUANTE,edt_saidapadrao);
    Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+2,trunc(Receita[index].TempoON),FLUTUANTE,edt_saidapadrao);
    Aparelho.Gravar_EEPROM_8bits_Interna_Mae (addeeprom+3,trunc(Receita[index].TempoOFF),FLUTUANTE,edt_saidapadrao);
    if(Receita[index].Nome='') then Receita[index].Nome:=' ';
    Aparelho.Gravar_EEPROM_String_Mae(addeeprom+5,Receita[index].Nome,TEXTO,edt_saidapadrao);
    end;
end;


procedure TForm1.PreencheComboBox();
var
  i:integer ;
  index:integer;
  addeeprom:integer;
begin
For_Record_Receita_From_TEdit();
cbb0.Items.Clear;
cbb1.Items.Clear;
cbb2.Items.Clear;
cbb3.Items.Clear;
cbb4.Items.Clear;
cbb5.Items.Clear;
cbb6.Items.Clear;
cbb7.Items.Clear;
cbb8.Items.Clear;
cbb9.Items.Clear;
  for i:=0 to 7 do
      begin
        if(Receita[i].nome<>'') then
           begin
            cbb0.Items.Add(Receita[i].Nome);
            cbb1.Items.Add(Receita[i].Nome);
            cbb2.Items.Add(Receita[i].Nome);
            cbb3.Items.Add(Receita[i].Nome);
            cbb4.Items.Add(Receita[i].Nome);
            cbb5.Items.Add(Receita[i].Nome);
            cbb6.Items.Add(Receita[i].Nome);
            cbb7.Items.Add(Receita[i].Nome);
            cbb8.Items.Add(Receita[i].Nome);
            cbb9.Items.Add(Receita[i].Nome);
           end;
      end;

  //Deixar uma opção vazia
  cbb0.Items.Add(' ');
  cbb1.Items.Add(' ');
  cbb2.Items.Add(' ');
  cbb3.Items.Add(' ');
  cbb4.Items.Add(' ');
  cbb5.Items.Add(' ');
  cbb6.Items.Add(' ');
  cbb7.Items.Add(' ');
  cbb8.Items.Add(' ');
  cbb9.Items.Add(' ');



end;









procedure TForm1.Button6Click(Sender: TObject);
begin
  Aparelho.Show_Programacao(0,HEXADECIMAL,edt_saidaprg);
end;

procedure TForm1.Button7Click(Sender: TObject);
begin
  Aparelho.Format_Program(TEXTO,edt_saidapadrao);
end;

procedure TForm1.ConectarSerial(chave:integer);
begin
try

   if(chave=CONECTAR) then
      begin
      ouvinte := TThead_USART.Create(FALSE);
      ouvinte.FreeOnTerminate:=TRUE;
      ouvinte.Start;
      ouvinte.Priority:=tpTimeCritical;
      Aparelho:=TSerial.Create;
      Aparelho.Connect(cbb_COMPORT.Caption);
      Aparelho.Config(115200,8,'N',0,false,false);
      end;

   if(chave=DESCONECTAR) then
      begin
       ouvinte.Terminate;
       FreeAndNil(Aparelho);
      end;
except
  Aparelho.free;
  //showmessage('Erro no modulo de comunicacao');
end;

 {
  if(Aparelho=nil) then
     begin

        Aparelho.FilaFim:=0;
        Aparelho.Purge;
     end
  else
     begin
        ouvinte.Suspend;
        Aparelho.FilaFim:=0;
        Aparelho.Free;
     end;

}
end;






procedure TForm1.Button8Click(Sender: TObject);
begin
  Puxar_dados_de_programacao_do_Hardware();
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
  Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
end;

procedure TForm1.cbb3Change(Sender: TObject);
begin
  edit26.Text:=floattostr(Receita[cbb3.ItemIndex].SetPoint);
  edit25.Text:=floattostr(Receita[cbb3.ItemIndex].TempoON);
  edit27.Text:=floattostr(Receita[cbb3.ItemIndex].TempoOFF);
  edit28.Text:=floattostr(Receita[cbb3.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(3,cbb3.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb3.Caption=' ') then
     begin
     ToggleBox4.Checked:=FALSE;
     edit26.text:='0';
     edit25.text:='0';
     edit27.text:='0';
     edit28.text:='0';
     end
  else
     ToggleBox4.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb4Change(Sender: TObject);
begin
  edit33.Text:=floattostr(Receita[cbb4.ItemIndex].SetPoint);
  edit32.Text:=floattostr(Receita[cbb4.ItemIndex].TempoON);
  edit34.Text:=floattostr(Receita[cbb4.ItemIndex].TempoOFF);
  edit35.Text:=floattostr(Receita[cbb4.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(4,cbb4.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb4.Caption=' ') then
     begin
     ToggleBox5.Checked:=FALSE;
     edit33.text:='0';
     edit32.text:='0';
     edit34.text:='0';
     edit35.text:='0';
     end
  else
     ToggleBox5.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb5Change(Sender: TObject);
begin
  edit40.Text:=floattostr(Receita[cbb5.ItemIndex].SetPoint);
  edit39.Text:=floattostr(Receita[cbb5.ItemIndex].TempoON);
  edit41.Text:=floattostr(Receita[cbb5.ItemIndex].TempoOFF);
  edit42.Text:=floattostr(Receita[cbb5.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(5,cbb5.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb5.Caption=' ') then
     begin
     ToggleBox6.Checked:=FALSE;
     edit40.text:='0';
     edit39.text:='0';
     edit41.text:='0';
     edit42.text:='0';
     end
  else
     ToggleBox6.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb6Change(Sender: TObject);
begin
  edit47.Text:=floattostr(Receita[cbb6.ItemIndex].SetPoint);
  edit46.Text:=floattostr(Receita[cbb6.ItemIndex].TempoON);
  edit48.Text:=floattostr(Receita[cbb6.ItemIndex].TempoOFF);
  edit49.Text:=floattostr(Receita[cbb6.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(6,cbb6.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb6.Caption=' ') then
     begin
     ToggleBox7.Checked:=FALSE;
     edit47.text:='0';
     edit46.text:='0';
     edit48.text:='0';
     edit49.text:='0';
     end
  else
     ToggleBox7.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb7Change(Sender: TObject);
begin
  edit54.Text:=floattostr(Receita[cbb7.ItemIndex].SetPoint);
  edit53.Text:=floattostr(Receita[cbb7.ItemIndex].TempoON);
  edit55.Text:=floattostr(Receita[cbb7.ItemIndex].TempoOFF);
  edit56.Text:=floattostr(Receita[cbb7.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(7,cbb7.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb7.Caption=' ') then
     begin
     ToggleBox8.Checked:=FALSE;
     edit54.text:='0';
     edit53.text:='0';
     edit55.text:='0';
     edit56.text:='0';
     end
  else
     ToggleBox8.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb8Change(Sender: TObject);
begin
  edit61.Text:=floattostr(Receita[cbb8.ItemIndex].SetPoint);
  edit60.Text:=floattostr(Receita[cbb8.ItemIndex].TempoON);
  edit62.Text:=floattostr(Receita[cbb8.ItemIndex].TempoOFF);
  edit63.Text:=floattostr(Receita[cbb8.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(8,cbb8.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb8.Caption=' ') then
     begin
     ToggleBox9.Checked:=FALSE;
     edit61.text:='0';
     edit60.text:='0';
     edit62.text:='0';
     edit63.text:='0';
     end
  else
     ToggleBox9.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb9Change(Sender: TObject);
begin
  edit68.Text:=floattostr(Receita[cbb9.ItemIndex].SetPoint);
  edit67.Text:=floattostr(Receita[cbb9.ItemIndex].TempoON);
  edit69.Text:=floattostr(Receita[cbb9.ItemIndex].TempoOFF);
  edit70.Text:=floattostr(Receita[cbb9.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(9,cbb9.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb9.Caption=' ') then
     begin
     ToggleBox10.Checked:=FALSE;
     edit68.text:='0';
     edit67.text:='0';
     edit69.text:='0';
     edit70.text:='0';
     end
  else
     ToggleBox10.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;



procedure TForm1.chk_EEPROM_16BitsChange(Sender: TObject);
begin
   if(chk_EEPROM_16Bits.Checked) then
      Form1.edt_eeprom_value.text:='$0000'
   else
      Form1.edt_eeprom_value.text:='$00';
end;

procedure TForm1.cbb0Change(Sender: TObject);
begin
  edit4.Text:=floattostr(Receita[cbb0.ItemIndex].SetPoint);
  edit3.Text:=floattostr(Receita[cbb0.ItemIndex].TempoON);
  edit5.Text:=floattostr(Receita[cbb0.ItemIndex].TempoOFF);
  edit7.Text:=floattostr(Receita[cbb0.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(0,cbb0.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb0.Caption=' ') then
     begin
     ToggleBox1.Checked:=FALSE;
     edit4.text:='0';
     edit3.text:='0';
     edit5.text:='0';
     edit7.text:='0';
     end
  else
     ToggleBox1.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb1Change(Sender: TObject);
begin
  edit12.Text:=floattostr(Receita[cbb1.ItemIndex].SetPoint);
  edit11.Text:=floattostr(Receita[cbb1.ItemIndex].TempoON);
  edit13.Text:=floattostr(Receita[cbb1.ItemIndex].TempoOFF);
  edit14.Text:=floattostr(Receita[cbb1.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(1,cbb1.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb1.Caption=' ') then
     begin
     ToggleBox2.Checked:=FALSE;
     edit12.text:='0';
     edit11.text:='0';
     edit13.text:='0';
     edit14.text:='0';
     end
  else
     ToggleBox2.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.cbb2Change(Sender: TObject);
begin
  edit19.Text:=floattostr(Receita[cbb2.ItemIndex].SetPoint);
  edit18.Text:=floattostr(Receita[cbb2.ItemIndex].TempoON);
  edit20.Text:=floattostr(Receita[cbb2.ItemIndex].TempoOFF);
  edit21.Text:=floattostr(Receita[cbb2.ItemIndex].Histerese);
  EnviaReceitaParaPrograma(2,cbb2.ItemIndex);
  //Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
  if(cbb2.Caption=' ') then
     begin
     ToggleBox3.Checked:=FALSE;
     edit19.text:='0';
     edit18.text:='0';
     edit20.text:='0';
     edit21.text:='0';
     end
  else
     ToggleBox3.Checked:=TRUE;
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.Folha_de_AbasChange(Sender: TObject);
begin
  //Showmessage('Clicou na Aba '+inttostr(Folha_de_Abas.PageIndex));
  if(Folha_de_Abas.PageIndex=1) then
     begin
     PreencheComboBox();
     Aparelho.PROCULUS_Goto_Page(15,TEXTO,Form1.edt_saidapadrao);
     end;
end;

procedure TForm1.EnviaReceitaParaPrograma(Mandador:Integer;index:integer);
var
  addeeprom:integer;
begin
   addeeprom:=52+(Mandador*18);
   //addeeprom+0 = Plataforma que começa por 0
   Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom+1,trunc(Receita[index].SetPoint*10),TEXTO,edt_saidapadrao);
   Aparelho.Gravar_EEPROM_8bits_Interna_Mae(addeeprom+3,trunc(Receita[index].TempoON),TEXTO,edt_saidapadrao);
   Aparelho.Gravar_EEPROM_8bits_Interna_Mae(addeeprom+4,trunc(Receita[index].TempoOFF),TEXTO,edt_saidapadrao);
   Aparelho.Gravar_EEPROM_8bits_Interna_Mae(addeeprom+5,trunc(Receita[index].Histerese),TEXTO,edt_saidapadrao);
   Aparelho.Gravar_EEPROM_String_Mae(addeeprom+6,Receita[index].Nome,TEXTO,edt_saidapadrao);
   if(Receita[index].Nome<>' ') then
      Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom+16,1,TEXTO,edt_saidapadrao)
   else
      Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom+16,0,TEXTO,edt_saidapadrao);
   Aparelho.Show_Programacao(Mandador,HEXADECIMAL,edt_saidaprg);
end;

procedure TForm1.ToggleBox9Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel9, 9);
Aparelho.Show_Programacao(8,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;




procedure TForm1.Puxar_dados_de_programacao_do_Hardware();
var
  i : integer;
  addeeprom:integer;
  status : integer;
begin
  //============================================================================
  addeeprom:=52+(0*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit4);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit3);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit5);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit7);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb0.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  Application.ProcessMessages;
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox1.checked:=TRUE else ToggleBox1.checked:=FALSE;




  //============================================================================
  addeeprom:=52+(1*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit12);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit11);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit13);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit14);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb1.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox2.checked:=TRUE else ToggleBox2.checked:=FALSE;


  //============================================================================
  addeeprom:=52+(2*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit19);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit18);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit20);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit21);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb2.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox3.checked:=TRUE else ToggleBox3.checked:=FALSE;







  //============================================================================
  addeeprom:=52+(3*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit26);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit25);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit27);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit28);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb3.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox4.checked:=TRUE else ToggleBox4.checked:=FALSE;







  //============================================================================
  addeeprom:=52+(4*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit33);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit32);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit34);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit35);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb4.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox5.checked:=TRUE else ToggleBox5.checked:=FALSE;





  //============================================================================
  addeeprom:=52+(5*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit40);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit39);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit41);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit42);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb5.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox6.checked:=TRUE else ToggleBox6.checked:=FALSE;





  //============================================================================
  addeeprom:=52+(6*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit47);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit46);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit48);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit49);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb6.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox7.checked:=TRUE else ToggleBox7.checked:=FALSE;





  //============================================================================
  addeeprom:=52+(7*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit54);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit53);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit55);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit56);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb7.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox8.checked:=TRUE else ToggleBox8.checked:=FALSE;





  //============================================================================
  addeeprom:=52+(8*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit61);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit60);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit62);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit63);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb8.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox9.checked:=TRUE else ToggleBox9.checked:=FALSE;




  //============================================================================
  addeeprom:=52+(9*18);
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+1,FLUTUANTE,Edit68);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+3,UINTEGER,Edit67);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+4,UINTEGER,Edit69);
  Aparelho.Ler_EEPROM_8bits_Interna_Mae(addeeprom+5,UINTEGER,Edit70);
  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_String_Mae(addeeprom+6,TEXTO,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  cbb9.Caption:=edt_buffer.text;
  //- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

  edt_buffer.text:='';
  Aparelho.Ler_EEPROM_16bits_Interna_Mae(addeeprom+16,UINTEGER,edt_buffer);
  Aguarda_Atualizacao_do_TEdit(edt_buffer);
  edt_buffer.text:=Trim(edt_buffer.text);
  status:=strtoint(edt_buffer.text);
  if(status=1) then ToggleBox10.checked:=TRUE else ToggleBox10.checked:=FALSE;



end;









procedure TForm1.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
   Gravar_Config();
   GravarReceita();
   if(ouvinte<>nil) then
      begin
      //ouvinte.WaitFor;
      ouvinte.Terminate;
      end;
   if(Aparelho<>nil) then
      begin
       Aparelho.Free;
       Aparelho:=nil;
      end;
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

procedure TForm1.bib_DataLogClick(Sender: TObject);
begin
   Aparelho.PROCULUS_Goto_Page(29,TEXTO,Form1.edt_saidapadrao);
   if(bib_DataLog.ShowHint=FALSE) then
      begin
      Aparelho.PROCULUS_Write_VP_Int(2,1,TEXTO,edt_saidapadrao); //LIGA BOTAO DATALOG
      bib_DataLog.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\DataLog_ON.bmp');
      bib_DataLog.ShowHint:=TRUE
      end
   else
      begin
      Aparelho.PROCULUS_Write_VP_Int(2,0,TEXTO,edt_saidapadrao); //DESLIGA BOTAO DATALOG
      bib_DataLog.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\DataLog_OFF.bmp');
      bib_DataLog.ShowHint:=FALSE;
      end;
end;

procedure TForm1.bib_VacuoClick(Sender: TObject);
begin
   Aparelho.PROCULUS_Goto_Page(15,TEXTO,Form1.edt_saidapadrao);
   if(bib_Vacuo.ShowHint=FALSE) then
      begin
      Aparelho.PROCULUS_Write_VP_Int(4,1,TEXTO,edt_saidapadrao); //LIGA BOTAO VACUO
      bib_Vacuo.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Vacuo_ON.bmp');
      bib_Vacuo.ShowHint:=TRUE;
      lbl_executando_processo.caption:='Executando Processo...';
      end
   else
      begin
      //Aparelho.PROCULUS_Control_Active(66,TEXTO,edt_saidapadrao);
      Aparelho.PROCULUS_Write_VP_Int(4,0,TEXTO,edt_saidapadrao); //DESLIGA BOTAO VACUO
      bib_Vacuo.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Vacuo_OFF.bmp');
      bib_Vacuo.ShowHint:=FALSE;
      tmr_temperaturas.Enabled:=FALSE;
      tmr_vacuo.Enabled:=TRUE;
      end;
end;

procedure TForm1.bib_CondensadorClick(Sender: TObject);
begin
     Aparelho.PROCULUS_Goto_Page(15,TEXTO,Form1.edt_saidapadrao);
     if(bib_Condensador.ShowHint=FALSE) then
      begin
         if(tmr_condensador.Enabled=FALSE) then
            begin
            Aparelho.PROCULUS_Write_VP_Int(3,1,TEXTO,edt_saidapadrao); //LIGA BOTAO CONDENSADOR
            bib_Condensador.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Condensador_ON.bmp');
            bib_Condensador.ShowHint:=TRUE
            end
        else
           begin
           showmessage('Aguarde 30 segundos antes de religar o condensador');
           end;
      end
   else
      begin
      tmr_condensador.Enabled:=TRUE;
      Aparelho.PROCULUS_Write_VP_Int(3,0,TEXTO,edt_saidapadrao); //DESLIGA BOTAO CONDENSADOR
      bib_Condensador.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Condensador_OFF.bmp');
      bib_Condensador.ShowHint:=FALSE;
      end;
end;

procedure TForm1.bib_AquecimentoClick(Sender: TObject);
begin
     Aparelho.PROCULUS_Goto_Page(15,TEXTO,Form1.edt_saidapadrao);
     if(bib_Aquecimento.ShowHint=FALSE) then
        begin
        Aparelho.PROCULUS_Write_VP_Int(5,1,TEXTO,edt_saidapadrao); //LIGA BOTAO AQUECIMENTO
        bib_Aquecimento.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Aquecimento_ON.bmp');
        bib_Aquecimento.ShowHint:=TRUE
        end
     else
        begin
        Aparelho.PROCULUS_Write_VP_Int(5,0,TEXTO,edt_saidapadrao); //DESLIGA BOTAO AQUECIMENTO
        bib_Aquecimento.Glyph.LoadFromFile(ExtractFilePath(ParamSTR(0))+'imagens\Aquecimento_OFF.bmp');
        bib_Aquecimento.ShowHint:=FALSE;
        end;
end;



procedure TForm1.btn_Config_GravarClick(Sender: TObject);
var
  variavel:integer;
  datahora:string;
begin
//Aparelho.PROCULUS_Goto_Page(23,TEXTO,Form1.edt_saidapadrao);



variavel:=trunc(strtofloat(edt_Condensador_Libera_Vacuo.text)*10);
if(variavel<0) then variavel:=($FFFF+variavel)+1;
Aparelho.Gravar_EEPROM_16bits_Interna_Mae($01,
                                          variavel,
                                          FLUTUANTE,edt_saidapadrao);
Aparelho.PROCULUS_Write_VP_Int(210,
                               trunc(strtofloat(edt_Condensador_Libera_Vacuo.text)*10),
                               FLUTUANTE,
                               edt_saidapadrao);

//------------------------------------------------------------------------------
Aparelho.Gravar_EEPROM_16bits_Interna_Mae($03,
                                          trunc(strtofloat(edt_Vacuo_Alarme.text)*10),
                                          FLUTUANTE,edt_saidapadrao);
Aparelho.PROCULUS_Write_VP_Int(211,
                               trunc(strtofloat(edt_Vacuo_Alarme.text)*10),
                               FLUTUANTE,
                               edt_saidapadrao);

//------------------------------------------------------------------------------
variavel:=trunc(strtofloat(edt_Aquecimento_Seg_Condensador.text)*10);
if(variavel<0) then variavel:=($FFFF+variavel)+1;
Aparelho.Gravar_EEPROM_16bits_Interna_Mae($05,
                                          variavel,
                                          TEXTO,edt_saidapadrao);

Aparelho.PROCULUS_Write_VP_Int(212,
                               trunc(strtofloat(edt_Aquecimento_Seg_Condensador.text)*10),
                               TEXTO,
                               edt_saidapadrao
                               );
//------------------------------------------------------------------------------
Aparelho.Gravar_EEPROM_16bits_Interna_Mae($07,
                                          trunc(strtofloat(edt_Aquecimento_Seg_Vacuo.text)*10),
                                          TEXTO,edt_saidapadrao);

Aparelho.PROCULUS_Write_VP_Int(213,
                               trunc(strtofloat(edt_Aquecimento_Seg_Vacuo.text)*10),
                               TEXTO,
                               edt_saidapadrao
                               );
//------------------------------------------------------------------------------
Aparelho.Gravar_EEPROM_16bits_Interna_Mae($FA,
                                          trunc(strtofloat(edt_DisplaySize.text)*10),
                                          TEXTO,edt_saidapadrao);

Aparelho.PROCULUS_Write_VP_Int(214,
                               trunc(strtofloat(edt_DisplaySize.text)*10),
                               TEXTO,
                               edt_saidapadrao
                               );

if(ckb_time_pc.Checked=TRUE) then
   begin
   datahora:=FormatDateTime('dd/mm/yyhh/nn/ss',now,[]);
   edt_tmp_data.Text:=FormatDateTime('dd/mm/yy',now,[]);
   edt_tmp_hora.Text:=FormatDateTime('hh:nn:ss',now,[]);
   end
else
   datahora:=edt_tmp_data.text+edt_tmp_hora.text;

Aparelho.Time_RTC_Write(datahora,TEXTO,edt_saidapadrao);



end;

procedure TForm1.btn_Config_LerClick(Sender: TObject);
begin
   //Aparelho.PROCULUS_Goto_Page(23,TEXTO,Form1.edt_saidapadrao);
   Aparelho.Ler_EEPROM_16bits_Interna_Mae($01,FLUTUANTE,edt_Condensador_Libera_Vacuo);
   Aparelho.Ler_EEPROM_16bits_Interna_Mae($03,FLUTUANTE,edt_Vacuo_Alarme);
   Aparelho.Ler_EEPROM_16bits_Interna_Mae($05,FLUTUANTE,edt_Aquecimento_Seg_Condensador);
   Aparelho.Ler_EEPROM_16bits_Interna_Mae($07,FLUTUANTE,edt_Aquecimento_Seg_Vacuo);
   Aparelho.Ler_EEPROM_16bits_Interna_Mae($FA,FLUTUANTE,edt_DisplaySize);
   Aparelho.Time_RTC_Read(0,TEXTO,edt_tmp_data);
   Aparelho.Time_RTC_Read(1,TEXTO,edt_tmp_hora);

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

procedure TForm1.btn_gravar_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Write_VP_Int(strtoint(edt_vp_add_int.Text),
                                 strtoint(edt_vp_value_int.Text),
                                 TEXTO,
                                 Form1.edt_vp_value_int_reply
                                 );
end;

procedure TForm1.btn_Ler24C32BitsClick(Sender: TObject);
begin
  Aparelho.Ler_EEPROM_32bits_24C1025_Mae(0
                                         ,strtoint(edt_24C_32B_add.text)
                                         ,HEXADECIMAL
                                         ,edt_24c_32bits);
end;

procedure TForm1.btn_Ler_RTCClick(Sender: TObject);
begin
  Aparelho.Time_RTC_Read(0,TEXTO,edt_time_process_reply);
end;

procedure TForm1.btn_ler_vp_intClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Read_VP_Int(strtoint(edt_vp_add_int.Text),FLUTUANTE,Form1.edt_vp_value_int_reply);
end;

procedure TForm1.btn_page_writeClick(Sender: TObject);
begin
  Aparelho.PROCULUS_Goto_Page(strtoint(edt_page.Text),TEXTO,Form1.edt_page_reply);
end;

procedure TForm1.btn_pagina1Click(Sender: TObject);
begin
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.btn_pagina2Click(Sender: TObject);
begin
  Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.btn_EE_Read_BufferClick(Sender: TObject);
begin
  if(rdb_Buffer_24C1025.Checked=TRUE) then
      begin
      if(strtoint(edt_placa_Buffer.text)>0) then
      Aparelho.Ler_EEPROM_24C1025_Buffer_Filha(strtoint(edt_placa_Buffer.text),
                                               strtoint(edt_Chip_Buffer.text),
                                               strtoint(edt_ADD_Buffer.text),
                                               strtoint(edt_ADD_EEE_Buffer_Size.text),
                                               HEXADECIMAL,edt_IO_Buffer)
      else
      Aparelho.Ler_EEPROM_24C1025_Buffer_Mae(strtoint(edt_Chip_Buffer.text),
                                             strtoint(edt_ADD_Buffer.text),
                                             strtoint(edt_ADD_EEE_Buffer_Size.text),
                                             HEXADECIMAL,edt_IO_Buffer)
      end;

  if(rdb_Buffer_EEPROM.Checked=TRUE) then
     begin
       showmessage('Não Implementado');
     end;
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
  node : AnsiString;  //APagar apos ensaios
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

        //Form1.Memo1.Lines.Add(strtmp);

        if (POS('CDCDCD', strtmp)>0)then
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
                                  numreal:=65536-numreal;
                                  numreal:=numreal/10.0;
                                  SaidaString:=formatfloat('#0.0',numreal);

                                  if(POS('Edit',TEdit(Aparelho.fila[0].ObjDestino).Name)=0) then
                                      begin
                                      TEdit(Aparelho.fila[0].ObjDestino).Text:=SaidaString+Aparelho.fila[0].resUnidade;
                                      end
                                  else
                                      begin
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
                                        end;
                                   end;
                              TEXTO :
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToText(Aparelho.fila[0].result);
                                  end;
                              NUMERAL :
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:=Aparelho.HexToNum(Aparelho.fila[0].result);
                                  end;
                              HEXADECIMAL:
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:={'$'+}Aparelho.fila[0].result;
                                  end;
                              UINTEGER:
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:=InttoStr(StrtoInt('$'+Aparelho.fila[0].result));
                                  end;
                              HORA:
                                  begin
                                  TEdit(Aparelho.fila[0].ObjDestino).Text:= formatfloat('00',StrtoInt('$'+copy(Aparelho.fila[0].result,1,2)))+':'+
                                                                            formatfloat('00',StrtoInt('$'+copy(Aparelho.fila[0].result,3,2))) ;
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

procedure TForm1.Menu_UploadClick(Sender: TObject);
begin
  Aparelho.Upload_Program(TEXTO,edt_saidapadrao);
end;

procedure TForm1.Menu_FormatClick(Sender: TObject);
begin
  Aparelho.Format_Program(TEXTO,edt_saidapadrao);

  Edit4.text:='0';
  Edit3.text:='0';
  Edit5.text:='0';
  Edit7.text:='0';
  cbb0.Caption:=' ';
  ToggleBox1.Checked:=FALSE;

  Edit12.text:='0';
  Edit11.text:='0';
  Edit13.text:='0';
  Edit14.text:='0';
  cbb1.Caption:=' ';
  ToggleBox2.Checked:=FALSE;

  Edit19.text:='0';
  Edit18.text:='0';
  Edit20.text:='0';
  Edit21.text:='0';
  cbb2.Caption:=' ';
  ToggleBox3.Checked:=FALSE;

  Edit26.text:='0';
  Edit25.text:='0';
  Edit27.text:='0';
  Edit28.text:='0';
  cbb3.Caption:=' ';
  ToggleBox4.Checked:=FALSE;

  Edit33.text:='0';
  Edit32.text:='0';
  Edit34.text:='0';
  Edit35.text:='0';
  cbb4.Caption:=' ';
  ToggleBox5.Checked:=FALSE;

  Edit40.text:='0';
  Edit39.text:='0';
  Edit41.text:='0';
  Edit42.text:='0';
  cbb5.Caption:=' ';
  ToggleBox6.Checked:=FALSE;

  Edit47.text:='0';
  Edit46.text:='0';
  Edit48.text:='0';
  Edit49.text:='0';
  cbb5.Caption:=' ';
  ToggleBox7.Checked:=FALSE;

  Edit54.text:='0';
  Edit53.text:='0';
  Edit55.text:='0';
  Edit56.text:='0';
  cbb7.Caption:=' ';
  ToggleBox8.Checked:=FALSE;

  Edit61.text:='0';
  Edit60.text:='0';
  Edit62.text:='0';
  Edit63.text:='0';
  cbb8.Caption:=' ';
  ToggleBox9.Checked:=FALSE;

  Edit68.text:='0';
  Edit67.text:='0';
  Edit69.text:='0';
  Edit70.text:='0';
  cbb9.Caption:=' ';
  ToggleBox10.Checked:=FALSE;



end;

procedure TForm1.rb_24C1025Change(Sender: TObject);
begin
  edt_eeprom_add.text:='$00000000';
end;

procedure TForm1.rb_EEPROMChange(Sender: TObject);
begin
  edt_eeprom_add.text:='$0000';
end;

procedure TForm1.tmr_onlineTimer(Sender: TObject);
begin

  if(CountCOM>0) then
     begin
       dec(CountCOM);
       Pn_COM.Color:=clLime;
       Pn_COM.Caption:='ONLINE';
       Pn_COM.Font.Color:=clBlack;

       Pn_COM_Check.Color:=clLime;
       Pn_COM_Check.Caption:='ONLINE';
       Pn_COM_Check.Font.Color:=clBlack;
     end
  else
     begin
       Pn_COM.Color:=clBlack;
       Pn_COM.Caption:='OFFLINE';
       Pn_COM.Font.Color:=clLime;

       Pn_COM_Check.Color:=clBlack;
       Pn_COM_Check.Caption:='OFFLINE';
       Pn_COM_Check.Font.Color:=clLime;
     end;
end;

procedure TForm1.ToggleBox1Change(Sender: TObject);
begin
  ToggleStatus(Sender, Panel1, 1);
  Aparelho.Show_Programacao(0,HEXADECIMAL,edt_saidaprg);
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox2Change(Sender: TObject);
begin
  ToggleStatus(Sender, Panel2, 2);
  Aparelho.Show_Programacao(1,HEXADECIMAL,edt_saidaprg);
  Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox3Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel3, 3);
Aparelho.Show_Programacao(2,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox4Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel4, 4);
Aparelho.Show_Programacao(3,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox5Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel5, 5);
Aparelho.Show_Programacao(4,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(19,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox6Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel6, 6);
Aparelho.Show_Programacao(5,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox7Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel7, 7);
Aparelho.Show_Programacao(6,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleBox8Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel8, 8);
Aparelho.Show_Programacao(7,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.tgb_SerialChange(Sender: TObject);
begin
    if(Aparelho=nil) then
     begin
     tgb_Serial.Caption:='Desconectar';
     ConectarSerial(CONECTAR);
     cbb_COMPORT.Enabled:=FALSE;
     end
  else
     begin
     tgb_Serial.Caption:='Conectar';
     ConectarSerial(DESCONECTAR);
     cbb_COMPORT.Enabled:=TRUE;
     end;
end;

procedure TForm1.tmr_vacuoTimer(Sender: TObject);
begin
    tmr_vacuo.Enabled:=FALSE;
    if (MessageDlg('Pergunta','Deseja encerrar o processo?',mtInformation, [mbYes, mbNo],0)=mrYes) then
       begin
         Aparelho.PROCULUS_Control_Active(10,TEXTO,edt_saidapadrao);  //PRESSIONADO SIM
         Aparelho.PROCULUS_Write_VP_Int(6,240,TEXTO,edt_saidapadrao);
         lbl_executando_processo.caption:='';
         Application.ProcessMessages;
       end
    else
       begin
         Aparelho.PROCULUS_Control_Active(20,TEXTO,edt_saidapadrao);  //PRESSIONADO NAO
         Aparelho.PROCULUS_Write_VP_Int(6,241,TEXTO,edt_saidapadrao);
         Application.ProcessMessages;
       end;

    tmr_temperaturas.Enabled:=TRUE;

end;

procedure TForm1.ToggleBox10Change(Sender: TObject);
begin
ToggleStatus(Sender, Panel10,10);
Aparelho.Show_Programacao(9,HEXADECIMAL,edt_saidaprg);
Aparelho.PROCULUS_Goto_Page(21,TEXTO,Form1.edt_saidapadrao);
end;

procedure TForm1.ToggleStatus(toggle:TObject; panel:TObject; mandador:integer);
var
   addeeprom:integer;
begin
   addeeprom:=52+(Mandador*18)-2;

  if TTogglebox(toggle).Checked then
     begin
       TTogglebox(toggle).Caption:='OK';
       TPanel(panel).Color:=clLime;
       Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom,1,TEXTO,edt_saidapadrao);
     end
  else
     begin
       TTogglebox(toggle).Caption:='X';
       TPanel(panel).Color:=clRed;
       Aparelho.Gravar_EEPROM_16bits_Interna_Mae(addeeprom,0,TEXTO,edt_saidapadrao);
     end;
end;


procedure TForm1.For_Record_Receita_From_TEdit();
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

  Receita[8].Nome     :=' ';
  Receita[8].SetPoint :=0;
  Receita[8].TempoON  :=0;
  Receita[8].TempoOFF :=0;
  Receita[8].Histerese:=0;


end;

procedure TForm1.For_TEdit_From_Record_Receita();
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


procedure TForm1.Gravar_Config();
var
  ArqINIConfig : TIniFile;
begin
  ArqINIConfig:= TIniFile.Create(ExtractFilePath(ParamSTR(0))+'Config.ini');
  try
    ArqINIConfig.WriteString('Geral','COMPORT',cbb_COMPORT.Caption);
    ArqINIConfig.WriteBool('Geral','Estado',tgb_Serial.Checked);
  finally
    FreeAndNil(ArqINIConfig);
  end;
end;




procedure TForm1.GravarReceita();
var
  ArqINI : TIniFile;
begin
  ArqINI:= TIniFile.Create(ExtractFilePath(ParamSTR(0))+'Receita.ini');
  try
    For_Record_Receita_From_TEdit();

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



procedure TForm1.Recuperar_Config();
var
  ArqINIConfig : TIniFile;
begin
  ArqINIConfig:= TIniFile.Create(ExtractFilePath(ParamSTR(0))+'Config.ini');
  try
    cbb_COMPORT.Caption:= ArqINIConfig.ReadString('Geral','COMPORT','COM5');
    tgb_Serial.Checked:= ArqINIConfig.ReadBool('Geral','Estado',FALSE);
    if(tgb_Serial.Checked=TRUE) then cbb_COMPORT.Enabled:=FALSE;
  finally
    FreeAndNil(ArqINIConfig);
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

  Receita[8].Nome     := ArqINI.ReadString('Receita7','Nome',    ' ');
  Receita[8].SetPoint := ArqINI.ReadFloat ('Receita7','SetPoint', 0.0);
  Receita[8].TempoON  := ArqINI.ReadFloat ('Receita7','TempoON',  0.0);
  Receita[8].TempoOFF := ArqINI.ReadFloat ('Receita7','TempoOFF', 0.0);
  Receita[8].Histerese:= ArqINI.ReadFloat ('Receita7','Histerese',0.0);

  For_TEdit_From_Record_Receita();

  finally
    FreeAndNil(ArqINI);
  end;
end;



procedure TForm1.Aguarda_Atualizacao_do_TEdit(objeto : TObject);
var
  maxtime:integer;
begin
  maxtime:=3000;
  TEdit(Objeto).text:='';
  while((TEdit(Objeto).text='')and(maxtime>0)) do
    begin
     sleep(1);
     if(maxtime>0)then dec(maxtime);
     TEdit(Objeto).Invalidate;
     TEdit(Objeto).Update;
     TEdit(Objeto).Repaint;
     Application.ProcessMessages;
     if Application.Terminated then break;
    end;
end;




end.

