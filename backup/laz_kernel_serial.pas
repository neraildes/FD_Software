unit Laz_kernel_serial;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SynaSer, Dialogs, StrUtils;

const

   PICEEPROMSIZE = 255;  //Memoria disponível no PIC
   TXBUFFERSIZE  = 255;
   RXBUFFERSIZE  = 255;

   HEADER            = 'AABB';
   ORIGEM            = 'C0';

   COMMAND_PING      =  $00;
   COMMAND_PONG      =  $01;
   COMMAND_POWER_ON  =  $02;
   COMMAND_POWER_OFF =  $03;
   COMMAND_RUN_ON    =  $04;
   COMMAND_RUN_OFF   =  $05;
   COMMAND_UPDATE_ON =  $06;
   COMMAND_UPDATE_OFF=  $07;
   //----- INTERNAL EEPROM-----------
   COMMAND_IEE_W_BYTE=  $08;
   COMMAND_IEE_R_BYTE=  $09;
   COMMAND_IEE_W_INT =  $0A;
   COMMAND_IEE_R_INT =  $0B;
   COMMAND_IEE_W_STR =  $0C;
   COMMAND_IEE_R_STR =  $0D;
   COMMAND_IEE_W_BUF =  $0E;
   COMMAND_IEE_R_BUF =  $0F;
   COMMAND_IEE_FILL_ALL=$10;
   //-------- EXTERNAL EEPROM ---------
   COMMAND_EEE_W_BYTE=  $11;
   COMMAND_EEE_R_BYTE=  $12;
   COMMAND_EEE_W_INT =  $13;
   COMMAND_EEE_R_INT =  $14;
   COMMAND_EEE_W_STR =  $15;
   COMMAND_EEE_R_STR =  $16;
   COMMAND_EEE_W_BUF =  $17;
   COMMAND_EEE_R_BUF =  $18;
   COMMAND_EEE_FILL_ALL=$19;
   //-------- ANALOGIC CHANNEL --------
   COMMAND_READ_ANALOG= $1A;
   COMMAND_SCHD_ANALOG= $1B;
   COMMAND_SCHD_START = $1C;
   COMMAND_SCHD_STOP  = $1D;
   //----------- PROCULUS -------------
   COMMAND_LCD_W_VP_INT    = $20;
   COMMAND_LCD_R_VP_INT    = $21;
   COMMAND_LCD_W_VP_STR    = $22;
   COMMAND_LCD_R_VP_STR    = $23;
   COMMAND_PROCULUS_Buzzer = $24;
   COMMAND_LDC_PAGE        = $25;
   COMMAND_CONTROL_ACTIVE  = $26;
   //...
   COMMAND_CLK_PIC_W       = $2E;
   COMMAND_CLK_PIC_R       = $2F;
   //---------------SLAVE--------------
   COMMAND_RELAY           = $30;
   COMMAND_INPUT_LED       = $31;
   //...
   //----------------------------------
   COMMAND_GLOBAL_HOT      = $40;
   COMMAND_VERSION         = $41;
   //...
   //----------------------------------


//-------------------------------------
   BUFFER_PC               =  $1FFFF;

//-----------OUTRAS CONSTANTES-------------
   READ  = 0;
   WRITE = 1;

//---------------RESULTTYPE----------------
UINT8       = 0;
SINT8       = 1;
UINT16      = 2;
SINT16      = 3;
HEXADECIMAL = 4;
FLUTUANTE   = 5;
TEXTO       = 6;

type
  TFila = Record
           comando    : Ansistring;
           TotalReturn: LongInt;
           RXpayload  : integer;
           result     : string;
           resTypeData: integer;
           ObjDestino : TObject;
           end;


type

  TSerial = class(TBlockSerial)
    public
      fila    : array[0..BUFFER_PC] of TFila;
      FilaFim : integer;
      constructor Create(); overload;

      procedure Buzzer(tempo : integer;
                  resultType : integer;
                  ObjDestino : TObject);


      //------------------------------------------------------------------------
      {
      GE08M
      GE16M
      GE08F
      GE16F
      }
      procedure Gravar_EEPROM_8bits_Interna_Mae(add    : integer;
                                                data   : integer;
                                            resultType : integer;
                                            ObjDestino : TObject);

      procedure Gravar_EEPROM_16bits_Interna_Mae(add    : integer;
                                                 data   : integer;
                                             resultType : integer;
                                             ObjDestino : TObject);

      procedure Gravar_EEPROM_8bits_Interna_Filha(destino : integer;
                                                   add    : integer;
                                                   data   : integer;
                                               resultType : integer;
                                               ObjDestino : TObject);


      procedure Gravar_EEPROM_16bits_Interna_Filha(destino : integer;
                                                    add    : integer;
                                                    data   : integer;
                                                resultType : integer;
                                                ObjDestino : TObject);


      //------------------------------------------------------------------------
      {
      LE08M
      LE16M
      LE08F
      LE16F
      }
      procedure Ler_EEPROM_8bits_Interna_Mae(add    : integer;
                                         resultType : integer;
                                         ObjDestino : TObject);

      procedure Ler_EEPROM_16bits_Interna_Mae(add    : integer;
                                          resultType : integer;
                                          ObjDestino : TObject);

      procedure Ler_EEPROM_8bits_Interna_Filha(destino : integer;
                                                add    : integer;
                                            resultType : integer;
                                            ObjDestino : TObject);

      procedure Ler_EEPROM_16bits_Interna_Filha(destino : integer;
                                                 add    : integer;
                                             resultType : integer;
                                             ObjDestino : TObject);



      //------------------------------------------------------------------------
      {
      G208M
      G216M
      G208F
      G216F
      }
      procedure Gravar_EEPROM_8bits_24C1025_Mae(chip : integer;
                                                add  : longint;
                                                data : integer;
                                          resultType : integer;
                                          ObjDestino : TObject);


      procedure Gravar_EEPROM_16bits_24C1025_Mae(chip : integer;
                                                 add  : longint;
                                                 data : integer;
                                           resultType : integer;
                                           ObjDestino : TObject);

      procedure Gravar_EEPROM_8bits_24C1025_Filha(destino : integer;
                                                     chip : integer;
                                                     add  : longint;
                                                     data : integer;
                                               resultType : integer;
                                               ObjDestino : TObject);



      procedure Gravar_EEPROM_16bits_24C1025_Filha(destino : integer;
                                                     chip : integer;
                                                     add  : longint;
                                                     data : integer;
                                               resultType : integer;
                                               ObjDestino : TObject);

      //------------------------------------------------------------------------
      {
      L208M
      L216M
      L208F
      L216F
      }

      procedure Ler_EEPROM_8bits_24C1025_Mae(chip : integer;
                                             add  : longint;
                                       resultType : integer;
                                       ObjDestino : TObject);




      procedure Ler_EEPROM_16bits_24C1025_Mae(chip : integer;
                                              add  : longint;
                                        resultType : integer;
                                        ObjDestino : TObject);




      procedure Ler_EEPROM_8bits_24C1025_Filha(destino : integer;
                                                  chip : integer;
                                                  add  : longint;
                                            resultType : integer;
                                            ObjDestino : TObject);


      procedure Ler_EEPROM_16bits_24C1025_Filha(destino : integer;
                                                   chip : integer;
                                                   add  : longint;
                                             resultType : integer;
                                             ObjDestino : TObject);

      //------------------------------------------------------------------------
      procedure EEPROM_24C1025_Fill_All(resultType : integer;
                                       destino : integer;
                                          chip : integer;
                                        value  : integer);


      //------------------------------------------------------------------------
      procedure PROCULUS_Write_VP_Int(vp: integer;
                                   value: integer;
                             resultType : integer;
                             ObjDestino : TObject);

      procedure PROCULUS_Read_VP_Int(vp: integer;
                            resultType : integer;
                            ObjDestino : TObject);



      procedure PROCULUS_Write_VP_String(vp : integer;
                                      value : string;
                                 resultType : integer;
                                 ObjDestino : TObject);

      //*AQUI*
      procedure PROCULUS_Read_VP_String(vp : integer;
                                resultType : integer;
                                ObjDestino : TObject);

      //------------------------------------------------------------------------


      procedure PROCULUS_Goto_Page(page : integer;
                            resultType : integer;
                            ObjDestino : TObject);

      procedure PROCULUS_Control_Active(resultType : integer;
                         Software_Control_Code: byte);




      function KernelCommand(comando : byte;
                             destino : byte;
                             tamanho : byte;
                              buffer : array of byte)
                                     : Ansistring;

      function kernelSerial(comando : Ansistring) : Ansistring;
      function HexToInt(Hexadecimal : AnsiString) : integer;
      function HexToText(Hexadecimal: AnsiString) : AnsiString;

    private
    protected
  end;


implementation

uses
  Main;

//-------------------------------- CONSTRUTOR ----------------------------------
constructor Tserial.Create();
begin
  inherited Create();
  FilaFim:=0;
end;


procedure TSerial.Buzzer(tempo : integer;
                    resultType : integer;
                    ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
//fila[FilaFim].comando:=carga;
//fila[FilaFim].result:='';
  //showmessage(inttostr(filafim));
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=14;
  //fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].ObjDestino:=ObjDestino;
  fila[FilaFim].resTypeData:=resultType;



  buffer[0]:=(tempo div 256);
  buffer[1]:=(tempo mod 256);

  KernelCommand(COMMAND_PROCULUS_Buzzer, $00, 2, buffer);
end;



{-------------------------------------------------------------------------------
             M A N I P U L A D O R E S    D E    M E M O R I A
-------------------------------------------------------------------------------}


//------------------------------------------------------------------------
{
GE08M
GE16M
GE08F
GE16F
}



procedure TSerial.Gravar_EEPROM_8bits_Interna_Mae(add    : integer;
                                                  data   : integer;
                                              resultType : integer;
                                              ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=8;
  fila[FilaFim].resTypeData:=TEXTO;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= (add div 256); //______Endereco (0x3FF)
  buffer[1]:= (add mod 256); //
  buffer[2]:= (data mod 256); //valor
  KernelCommand(COMMAND_IEE_W_BYTE,0 , 3, buffer);
end;


procedure TSerial.Gravar_EEPROM_16bits_Interna_Mae(add  : integer;
                                                 data   : integer;
                                             resultType : integer;
                                             ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=8;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= (add div 256); //______Endereco (0x3FF)
  buffer[1]:= (add mod 256); //
  buffer[2]:= (data div 256); //______Dados (0xFFFF)
  buffer[3]:= (data mod 256); //
  KernelCommand(COMMAND_IEE_W_INT,0 , 4, buffer);
end;



procedure TSerial.Gravar_EEPROM_8bits_Interna_Filha(destino : integer;
                                                     add    : integer;
                                                     data   : integer;
                                                 resultType : integer;
                                                 ObjDestino : TObject);

var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
    fila[FilaFim].RXpayload:=3;
    fila[FilaFim].TotalReturn:=16;
    fila[FilaFim].resTypeData:=resultType;
    fila[FilaFim].ObjDestino:=ObjDestino;

    buffer[0]:=(add mod 256); //endereco 8 bits
    buffer[1]:= data;         //dados 8 bits
    KernelCommand(COMMAND_IEE_W_BYTE, destino, 2, buffer);
end;



procedure TSerial.Gravar_EEPROM_16bits_Interna_Filha(destino : integer;
                                                      add    : integer;
                                                      data   : integer;
                                                  resultType : integer;
                                                  ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
    //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
    //fila[FilaFim].result:='';       Zerado no KernelCommand
      fila[FilaFim].RXpayload:=3;
      fila[FilaFim].TotalReturn:=20;
      fila[FilaFim].resTypeData:=resultType;
      fila[FilaFim].ObjDestino:=ObjDestino;


      buffer[0]:=(add  mod 256);
      buffer[1]:=(data div 256);
      buffer[2]:=(data mod 256);
      KernelCommand(COMMAND_IEE_W_INT, destino, 3, buffer);
end;









//------------------------------------------------------------------------
{
LE08M
LE16M
LE08F
LE16F
}
procedure TSerial.Ler_EEPROM_8bits_Interna_Mae(add    : integer;
                                           resultType : integer;
                                           ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  //fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].RXpayload:=1;
  fila[FilaFim].TotalReturn:=6;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= (add div 256); //______Endereco (0x3FF)
  buffer[1]:= (add mod 256); //
  KernelCommand(COMMAND_IEE_R_BYTE, 0, 2, buffer);
end;



procedure TSerial.Ler_EEPROM_16bits_Interna_Mae(add    : integer;
                                            resultType : integer;
                                            ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  //fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].RXpayload:=2;
  fila[FilaFim].TotalReturn:=7;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;


  buffer[0]:= (add div 256); //______Endereco (0x3FF)
  buffer[1]:= (add mod 256); //
  KernelCommand(COMMAND_IEE_R_INT,0, 2, buffer);
end;





procedure TSerial.Ler_EEPROM_8bits_Interna_Filha(destino : integer;
                                                  add    : integer;
                                              resultType : integer;
                                              ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=1;
  fila[FilaFim].TotalReturn:=13;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:=(add mod 256);
  KernelCommand(COMMAND_IEE_R_BYTE, destino, 1, buffer);
end;


procedure TSerial.Ler_EEPROM_16bits_Interna_Filha(destino : integer;
                                                   add    : integer;
                                               resultType : integer;
                                               ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=2;
  fila[FilaFim].TotalReturn:=14;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:=(add mod 256);
  KernelCommand(COMMAND_IEE_R_INT, destino, 1, buffer);
end;







//------------------------------------------------------------------------
{
G208M
G216M
G208F
G216F
}


procedure TSerial.Gravar_EEPROM_8bits_24C1025_Mae(chip : integer;
                                                  add  : longint;
                                                  data : integer;
                                            resultType : integer;
                                            ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=8;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  buffer[5]:= data;
  KernelCommand(COMMAND_EEE_W_BYTE,0 , 6, buffer);
end;




procedure TSerial.Gravar_EEPROM_16bits_24C1025_Mae(chip : integer;
                                                   add  : longint;
                                                   data : integer;
                                             resultType : integer;
                                             ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=8;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  buffer[5]:= (data>>8) and $FF;
  buffer[6]:= (data>>0) and $FF;
  KernelCommand(COMMAND_EEE_W_INT,0 , 7, buffer);
end;







procedure TSerial.Gravar_EEPROM_8bits_24C1025_Filha(destino : integer;
                                                       chip : integer;
                                                       add  : longint;
                                                       data : integer;
                                                 resultType : integer;
                                                 ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=20;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  buffer[5]:= data;
  KernelCommand(COMMAND_EEE_W_BYTE,destino , 6, buffer);
end;





procedure TSerial.Gravar_EEPROM_16bits_24C1025_Filha(destino : integer;
                                                        chip : integer;
                                                        add  : longint;
                                                        data : integer;
                                                  resultType : integer;
                                                  ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=21;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  buffer[5]:= (data>>8) and $FF;
  buffer[6]:= (data>>0) and $FF;
  KernelCommand(COMMAND_EEE_W_INT,destino , 7, buffer);
end;



//----------------------------------------------------------------------------
{
L208M
L216M
L208F *
L216F *
}




procedure TSerial.Ler_EEPROM_8bits_24C1025_Mae(chip : integer;
                                               add  : longint;
                                         resultType : integer;
                                         ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=1;
  fila[FilaFim].TotalReturn:=6;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  KernelCommand(COMMAND_EEE_R_BYTE,0 , 5, buffer);
end;




procedure TSerial.Ler_EEPROM_16bits_24C1025_Mae(chip : integer;
                                                add  : longint;
                                          resultType : integer;
                                          ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=2;
  fila[FilaFim].TotalReturn:=7;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  KernelCommand(COMMAND_EEE_R_INT,0 , 5, buffer);
end;




procedure TSerial.Ler_EEPROM_8bits_24C1025_Filha(destino : integer;
                                                    chip : integer;
                                                    add  : longint;
                                              resultType : integer;
                                              ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=1;
  fila[FilaFim].TotalReturn:=17;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  KernelCommand(COMMAND_EEE_R_BYTE,destino , 5, buffer);
end;




procedure TSerial.Ler_EEPROM_16bits_24C1025_Filha(destino : integer;
                                                     chip : integer;
                                                     add  : longint;
                                               resultType : integer;
                                               ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=2;
  fila[FilaFim].TotalReturn:=18;
  fila[FilaFim].resTypeData:=resultType;
  fila[FilaFim].ObjDestino:=ObjDestino;

  buffer[0]:= chip ;
  buffer[1]:= (add>>24) and $FF;
  buffer[2]:= (add>>16) and $FF;
  buffer[3]:= (add>>8 ) and $FF;
  buffer[4]:= (add>>0 ) and $FF;
  KernelCommand(COMMAND_EEE_R_INT,destino , 5, buffer);
end;



{-------------------------------------------------------------------------------
           C O M A N D O S     D O     L C D     P R O C U L U S
-------------------------------------------------------------------------------}
procedure TSerial.PROCULUS_Write_VP_Int(vp: integer;
                                     value: integer;
                               resultType : integer;
                               ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=17;
  fila[FilaFim].ObjDestino:=ObjDestino;
  fila[FilaFim].resTypeData:=resultType;

  buffer[0]:= (vp>>8) and $FF;
  buffer[1]:= (vp>>0) and $FF;
  buffer[2]:= (value>>8) and $FF;
  buffer[3]:= (value>>0) and $FF;
  KernelCommand(COMMAND_LCD_W_VP_INT, 0, 4, buffer);
end;



procedure TSerial.PROCULUS_Read_VP_Int(vp: integer;
                              resultType : integer;
                              ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=2;
  fila[FilaFim].TotalReturn:=14;
  fila[FilaFim].ObjDestino:=Form1.edt_vp_value_int_reply;
  fila[FilaFim].resTypeData:=resultType;

  buffer[0]:= (vp>>8) and $FF;
  buffer[1]:= (vp>>0) and $FF;
  KernelCommand(COMMAND_LCD_R_VP_INT, 0, 2, buffer);
end;



procedure TSerial.PROCULUS_Write_VP_String(vp : integer;
                                        value : string;
                                   resultType : integer;
                                   ObjDestino : TObject);
var
   i : integer;
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=24;
  fila[FilaFim].ObjDestino:=ObjDestino;
  fila[FilaFim].resTypeData:=resultType;

  buffer[0]:= (vp>>8) and $FF;
  buffer[1]:= (vp>>0) and $FF;

  for i:=0 to length(value) do
      begin
        buffer[i+2]:= byte(value[i+1]);
      end;
  KernelCommand(COMMAND_LCD_W_VP_STR, 0, length(value)+3, buffer);
end;



//*AQUI*
procedure TSerial.PROCULUS_Read_VP_String(vp : integer;
                                  resultType : integer;
                                  ObjDestino : TObject);
var
   i : integer;
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=28;
  fila[FilaFim].TotalReturn:=40;
  fila[FilaFim].ObjDestino:=ObjDestino;
  fila[FilaFim].resTypeData:=resultType;

  buffer[0]:= (vp>>8) and $FF;
  buffer[1]:= (vp>>0) and $FF;
  KernelCommand(COMMAND_LCD_R_VP_STR, 0, 2, buffer);
end;






procedure TSerial.PROCULUS_Goto_Page(page : integer;
                              resultType : integer;
                              ObjDestino : TObject);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=15;
  fila[FilaFim].ObjDestino:=ObjDestino;
  fila[FilaFim].resTypeData:=resultType;

  buffer[0]:= (page>>8) and $FF;
  buffer[1]:= (page>>0) and $FF;
  KernelCommand(COMMAND_LDC_PAGE, 0, 2, buffer);
end;



procedure TSerial.PROCULUS_Control_Active(resultType : integer;
                           Software_Control_Code: byte);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=14;
  //fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].ObjDestino:=Form1.edt_control_active_reply;

  buffer[0]:= Software_Control_Code;
  KernelCommand(COMMAND_CONTROL_ACTIVE, 0, 1, buffer);
end;








{------------------------------------------------------------------------------
                        C O M A N D O S   A V U L S O S
-------------------------------------------------------------------------------}
procedure TSerial.EEPROM_24C1025_Fill_All(resultType : integer;
                                         destino : integer;
                                            chip : integer;
                                          value  : integer);
var
   buffer : array [0..TXBUFFERSIZE ] of byte;
begin
  //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
  //fila[FilaFim].result:='';       Zerado no KernelCommand
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=8;
  //fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].ObjDestino:=Form1.edt_fill_reply;

  buffer[0]:= chip ;
  buffer[1]:= (value>>8) and $FF;
  buffer[2]:= (value>>0) and $FF;
  KernelCommand(COMMAND_EEE_FILL_ALL,destino , 3, buffer);
end;








{-------------------------------------------------------------------------------
                   N Ú C L E O    D E    C O M U N I C A Ç Ã O
-------------------------------------------------------------------------------}

//------------------------------------------------------------------------------
function TSerial.KernelCommand(comando : byte;
                               destino : byte;
                               tamanho : byte;
                                buffer : array of byte)
                                       : Ansistring;
var
  carga: AnsiString;
  texto: AnsiString;
  cnt  : byte;
  i    : byte;
begin
  carga:=
  HEADER+              //Cabeçalho da comunicação serial
  ORIGEM+              //Endereço de origem do pacote
  IntToHex(destino,2)+ //Endereço de destino do pacote
  IntToHex(comando,2)+ //Comando a ser executado
  IntToHex(tamanho,2); //tamanho do payload

  Texto:='';
  for cnt:=0 to tamanho-1 do texto:=texto+inttohex(buffer[cnt],2);
  carga:=carga+Texto;


  fila[FilaFim].comando:=carga;
  fila[FilaFim].result:='';
//fila[FilaFim].RXpayload:=0;
//fila[FilaFim].TotalReturn:=0;
//fila[FilaFim].ObjOrigem:=nil;
//fila[FilaFim].ObjDestino:=nil;
  inc(FilaFim);



  //result:= 'Foi Agendado, favor pegar o resultado na Thread';//kernelSerial(carga, TotalReturn);
end;



//------------------------------------------------------------------------------
function TSerial.kernelSerial(comando : Ansistring):Ansistring;
var
  Buffer_In  : array[0..TXBUFFERSIZE] of byte;
  Buffer_Out : array[0..TXBUFFERSIZE] of byte;
  pnt : ^byte;

  i:byte;
  SizeBufferSend:byte;
  recebido : AnsiString;
  NumRcv : LongInt;
  strtmp : string;
  retorno: AnsiString;
  decimal: integer;
begin

  Form1.Memo2.Lines.Add('E: '+comando);   //ENVIADO

  try
      if(length(comando)>2) then
         begin
           SizeBufferSend:=(length(comando) div 2);
           for i:=0 to  SizeBufferSend-1 do
               begin
                 decimal := Hex2Dec('$'+copy(comando,(i*2)+1,2));
                 Buffer_Out[i] := decimal;
               end;
           pnt:=@Buffer_Out;


           Purge;

           SendBuffer(pnt,SizeBufferSend);

           pnt:=@Buffer_In;

           NumRcv:=RecvBuffer(pnt,Fila[0].TotalReturn+1);
           strtmp:='';
           for i:=0 to Fila[0].TotalReturn do
               strtmp:=strtmp+IntToHex(Word(Buffer_In[i]),2);
           Fila[0].result:=Copy(strtmp,length(strtmp)-(Fila[0].RXpayload*2)+1,Fila[0].RXpayload*2+1);


           Form1.Memo2.Lines.Add('F: '+strtmp);
           Form1.Memo2.Lines.Add('R: '+Fila[0].result);   //RECEBIDO
         end;


  finally
      //free;
  end;

  result := retorno;
end;



//------------------------------------------------------------------------------
function Tserial.HexToInt(Hexadecimal : AnsiString) : integer;
begin
  //showmessage(Hexadecimal);
  Result := StrToInt('$' + Hexadecimal);
end;





//------------------------------------------------------------------------------
function Tserial.HexToText(Hexadecimal: AnsiString):AnsiString;
var
cnt:integer;
texto:string;
tmp :char;
begin
  texto:='';
  cnt:=1;
  while cnt<length(Hexadecimal) do
        begin
          tmp:=chr(HextoInt(copy(hexadecimal,cnt,2)));
          texto:=texto+tmp;
          cnt:=cnt+2;
        end;
  result := texto;
end;






end.

