unit tempo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

  type

    TTempo = class
      dateinfo : TDateTime;
      timeinfo : TDateTime;

      function showdate():string;
      function showtime():string;
      procedure inputdate(idate:string);
      procedure inputtime(itime:string);
    private
    end;

implementation

function TTempo.showdate():string;
   begin
     result := DateToStr(dateinfo);
   end;

function TTempo.showtime():string;
   begin
     result := DateToStr(timeinfo);
   end;

procedure inputdate(idate:string);
   begin
     dateinfo:=StrToDate(idate);
   end;

procedure inputtime(idate:string);
   begin
     dateinfo:=StrTotime(itime);
   end;

end.

