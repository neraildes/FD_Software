unit TabelaAlocacao8;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DateUtils, Dialogs;

type
    TTempo = record
     data  : TDateTime;
     hora  : TDateTime;
    end;

    tFat8 = class
      process_number : integer;
      inicio : TTempo;
      fim    : TTempo;
      amostra: byte;
      add_start : cardinal;
      add_end   : cardinal;
      minutes   : integer;
    public
      constructor Create(); overload;
      function getInicioDate():string;
      function getInicioTime():string;
      function getFimDate():string;
      function getFimTime():string;

      procedure setInicioDate(idate:string);
      procedure setInicioTime(itime:string);
      procedure setFimDate(idate:string);
      procedure setFimTime(itime:string);

      procedure SomaSegundos(segundos : integer);

    private
    end;

{variaveis}
var
  settings:TFormatSettings;


implementation


constructor TFat8.Create();
begin
  inherited Create();
  settings := DefaultFormatSettings; //to do not damage defaults
  Settings.DateSeparator := '/';
  Settings.TimeSeparator := ':';
  Settings.ShortTimeFormat := 'hh:nn:ss';
  Settings.ShortDateFormat := 'dd/mm/yy';
end;



procedure tFat8.SomaSegundos(segundos : integer);
var
  oldTime: TDateTime;
begin
    oldTime:=inicio.hora;
    Inicio.hora:=IncSecond(inicio.hora,segundos);
    if(TimeToStr(Inicio.Hora)<TimeToStr(oldTime)) then
       Inicio.data:=IncDay(Inicio.data);
end;



function tFat8.getInicioDate():string;
   begin
     result := DateToStr(inicio.data);
   end;

function tFat8.getInicioTime():string;
   begin
     result := TimeToStr(inicio.hora);
   end;

function tFat8.getFimDate():string;
   begin
     result := DateToStr(fim.data);
   end;

function tFat8.getFimTime():string;
   begin
     result := TimeToStr(fim.hora);
   end;





procedure tFat8.setInicioDate(idate:string);
   begin
     inicio.data:=StrToDate(idate);
   end;

procedure tFat8.setInicioTime(itime:string);
   begin
     inicio.hora:=StrTotime(itime);
   end;

procedure tFat8.setFimDate(idate:string);
   begin
     fim.data:=StrToDate(idate);
   end;

procedure tFat8.setFimTime(itime:string);
   begin
     fim.hora:=StrToTime(itime);
   end;


end.

