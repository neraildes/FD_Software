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
   BUFFER_PC               =  50;

//-----------OUTRAS CONSTANTES-------------
   READ  = 0;
   WRITE = 1;

type
  TFila = Record
           comando    : Ansistring;
           TotalReturn: LongInt;
           RXpayload  : integer;
           result     : string;
           ObjOrigem  : TObject;
           ObjDestino : TObject;
           end;


type

  TSerial = class(TBlockSerial)
    public
      fila    : array[0..BUFFER_PC] of TFila;
      FilaFim : integer;
      constructor Create(); overload;

      procedure Buzzer(Sender: TObject;
                       tempo : integer);

      function Gravar_EEPROM_Interna(Sender: TObject;
                                     destino: byte;
                                     add    : integer;
                                     value  : byte)
                                            : AnsiString;

      function     Ler_EEPROM_Interna(Sender: TObject;
                                     destino: byte;
                                     add    : integer)
                                            : AnsiString;



      function KernelCommand(comando : byte;
                             destino : byte;
                             tamanho : byte;
                              buffer : array of QWord)
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


procedure TSerial.Buzzer( Sender: TObject;
                          tempo : integer);
var
   buffer : array [0..TXBUFFERSIZE ] of QWord;
begin
//fila[FilaFim].comando:=carga;
//fila[FilaFim].result:='';
  //showmessage(inttostr(filafim));
  fila[FilaFim].RXpayload:=3;
  fila[FilaFim].TotalReturn:=14;
  fila[FilaFim].ObjOrigem:=Sender;
  fila[FilaFim].ObjDestino:=Form1.Edt_buz_return;


  buffer[0]:=(tempo div 256);
  buffer[1]:=(tempo mod 256);

  KernelCommand(COMMAND_PROCULUS_Buzzer, $00, 2, buffer);
end;

//------------------------------------------------------------------------------
function TSerial.Gravar_EEPROM_Interna(Sender: TObject;
                                       destino: byte;
                                       add    : integer;
                                       value  : byte)
                                              : AnsiString;
var
   buffer : array [0..TXBUFFERSIZE ] of QWord;
begin
  if(destino=$00) then //GRAVAR EEPROM INTERNA DA PLACA MAE (3ff)
     begin
     //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
     //fila[FilaFim].result:='';       Zerado no KernelCommand
       fila[FilaFim].RXpayload:=3;
       fila[FilaFim].TotalReturn:=8;
       fila[FilaFim].ObjOrigem:=Sender;
       fila[FilaFim].ObjDestino:=Form1.edt_eeprom_reply;

       buffer[0]:= (add div 256); //______Endereco (0x3FF)
       buffer[1]:= (add mod 256); //
       buffer[2]:= value;         //valor
       KernelCommand(COMMAND_IEE_W_BYTE, destino, 3, buffer);
     end
  else                //GRAVAR EEPROM INTERNA DA PLACA FILHA
     begin
     //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
     //fila[FilaFim].result:='';       Zerado no KernelCommand
       fila[FilaFim].RXpayload:=3;
       fila[FilaFim].TotalReturn:=8;
       fila[FilaFim].ObjOrigem:=Sender;
       fila[FilaFim].ObjDestino:=Form1.edt_eeprom_reply;

       buffer[0]:=destino;       //Placa Destino
       buffer[1]:=(add div 256); //______Endereco (0x3FF)
       //buffer[2]:=(add mod 256); //
       buffer[3]:=value;         //valor
       KernelCommand(COMMAND_IEE_W_BYTE, destino, 3, buffer);
     end;


end;




//------------------------------------------------------------------------------
function TSerial.Ler_EEPROM_Interna(Sender: TObject;
                                   destino: byte;
                                   add    : integer)
                                          : AnsiString;
var
   buffer : array [0..TXBUFFERSIZE ] of QWord;
begin
  if(destino=$00) then //LER EEPROM INTERNA DA PLACA MAE (0x3FF)
     begin
       //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
       //fila[FilaFim].result:='';       Zerado no KernelCommand
       fila[FilaFim].RXpayload:=1;
       fila[FilaFim].TotalReturn:=6;
       fila[FilaFim].ObjOrigem:=Sender;
       fila[FilaFim].ObjDestino:=Form1.edt_eeprom_reply;

       buffer[0]:= (add div 256); //______Endereco (0x3FF)
       buffer[1]:= (add mod 256); //
       KernelCommand(COMMAND_IEE_R_BYTE, destino, 2, buffer);
     end
  else                 //LER EEPROM INTERNA DA PLACA FILHA (0xFF)
     begin
       //fila[FilaFim].comando:=carga;   Carregado no KernelCommand
       //fila[FilaFim].result:='';       Zerado no KernelCommand
       fila[FilaFim].RXpayload:=1;
       fila[FilaFim].TotalReturn:=6;
       fila[FilaFim].ObjOrigem:=Sender;
       fila[FilaFim].ObjDestino:=Form1.edt_eeprom_reply;

       buffer[0]:=destino;       //Placa Destino
       buffer[1]:=(add mod 256); //______Endereco (0xFF)
       //buffer[2]:=(add mod 256); //
       //buffer[3]:=value;         //valor
       KernelCommand(COMMAND_IEE_W_BYTE, destino, 3, buffer);
     end;


end;









//------------------------------------------------------------------------------
function TSerial.KernelCommand(comando : byte;
                               destino : byte;
                               tamanho : byte;
                                buffer : array of QWord)
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
  SizeBufferSend:QWord;
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

