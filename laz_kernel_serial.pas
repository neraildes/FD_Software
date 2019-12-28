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
   //----------- OUTROS ---------------
   COMMAND_CLK_PIC_W  = $1E;
   COMMAND_CLK_PIC_R  = $1F;
   COMMAND_LDC_PAGE   = $20;
   COMMAND_PROCULUS_Buzzer = $21;
   COMMAND_LCD_W_VP_INT    = $22;
   COMMAND_LCD_R_VP_INT    = $23;
   COMMAND_LCD_W_VP_STR    = $24;
   COMMAND_LCD_R_VP_STR    = $25;
   //---------------SLAVE--------------
   COMMAND_RELAY           = $26;
   COMMAND_INPUT_LED       = $27;
   //----------------------------------
   COMMAND_READ_GRAUS      = $28;
   COMMAND_READ_GRAUS_REAL = $29;
   //----------------------------------
   COMMAND_GLOBAL_HOT      = $2A;
   COMMAND_PERGUNTA        = $2B;
//-------------------------------------

type
  TFila = Record
           comando   : array[0..50]of Ansistring;
           fim       : integer;
           result    : string;
           ObjOrigem : TObject;
           ObjDestino: TObject;
           end;


type

  TSerial = class(TBlockSerial)
    public
      fila : TFila;
      constructor Create(); overload;

      procedure Buzzer(Sender: TObject;
                       tempo : integer);

      function Gravar_EEPROM_Interna(destino: byte;
                                     add    : integer;
                                     value  : byte)
                                            : AnsiString;

      function KernelCommand(comando : byte;
                             destino : byte;
                             tamanho : byte;
                              buffer : array of QWord;
                           totalsend : LongInt;
                         totalreturn : integer)
                                     : Ansistring;

      function kernelSerial(comando : Ansistring; TotalReturn:LongInt; RXpayload:integer):Ansistring;
      function HexToInt(Hexadecimal : AnsiString) : integer;
      function HexToText(Hexadecimal: AnsiString):AnsiString;

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
  fila.fim:=0;
end;


procedure TSerial.Buzzer( Sender: TObject;
                          tempo : integer);
var
   buffer : array [0..TXBUFFERSIZE ] of QWord;
begin
   fila.ObjOrigem:=Sender;
   fila.ObjDestino:=Form1.Edt_buz_return;
   buffer[0]:=(tempo div 256);
   buffer[1]:=(tempo mod 256);

   KernelCommand(COMMAND_PROCULUS_Buzzer, $00, 2, buffer, 15,3);
end;

//------------------------------------------------------------------------------
function TSerial.Gravar_EEPROM_Interna(destino: byte;
                                       add    : integer;
                                       value  : byte)
                                              : AnsiString;
var
   payload : array [0..TXBUFFERSIZE ] of QWord;
begin
  {
  payload[0]:=destino;
  payload[1]:=chip;
  payload[2]:=(add div 256);
  payload[3]:=(add mod 256);
  }
  payload[0]:=destino;
  payload[1]:=(add div 256);
  payload[2]:=(add mod 256);
  payload[3]:=value;
  result    :=KernelCommand(COMMAND_IEE_W_BYTE, destino, 4, payload, 15,3);
end;



//------------------------------------------------------------------------------
function TSerial.KernelCommand(comando : byte;
                               destino : byte;
                               tamanho : byte;
                                buffer : array of QWord;
                             totalsend : LongInt;
                           totalreturn : integer)
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

  Form1.Memo1.Lines.Clear;
  for i:=0 to 50 do Form1.Memo2.Lines.add(fila.comando[i]);
  fila.comando[fila.fim]:=carga;
  inc(fila.fim);

  showmessage(fila.comando[0]);

  //result:= 'Foi Agendado, favor pegar o resultado na Thread';//kernelSerial(carga, TotalReturn);
end;



//------------------------------------------------------------------------------
function TSerial.kernelSerial(comando : Ansistring; TotalReturn:LongInt; RXpayload:integer):Ansistring;
var
  Buffer_In  : array[0..TXBUFFERSIZE] of byte;
  Buffer_Out : array[0..TXBUFFERSIZE] of byte;
  pnt : ^byte;

  i:byte;
  SizeBufferSend:QWord;
  recebido : AnsiString;
  NumRcv : LongInt;
  strtmp : string;
  retorno: AnsiString;
  decimal: integer;
begin
  Form1.Memo1.Lines.Add('----KERNEL----');

  Form1.Memo1.Lines.Add(comando);

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
           //Form1.Memo1.Lines.Add('Pacote Env : '+comando);
           SendBuffer(pnt,SizeBufferSend);

           pnt:=@Buffer_In;

           NumRcv:=RecvBuffer(pnt,TotalReturn);
           strtmp:='';
           for i:=0 to TotalReturn-1 do
               strtmp:=strtmp+IntToHex(Word(Buffer_In[i]),2);
           retorno:=(copy(strtmp,1,TotalReturn*2));
           Aparelho.fila.result:=retorno;

           //Form1.Memo4.Lines.Add('Pacote Rec : '+strtmp);
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
  Result := 0;//StrToInt('$' + Hexadecimal);
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
          if (tmp=char(0)) then
             texto:=texto+chr(7)
          else
             texto:=texto+tmp;
          cnt:=cnt+2;
        end;
  result := texto;
end;






end.

