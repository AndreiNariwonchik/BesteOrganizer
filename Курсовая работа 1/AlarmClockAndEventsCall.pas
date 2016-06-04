unit AlarmClockAndEventsCall;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls,
  Vcl.StdCtrls, sButton, sLabel, Vcl.MPlayer, sMemo;

type
  TCall = class(TForm)
    Image1: TImage;
    Shut_off: TsButton;
    Set_asid: TsButton;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    MediaPlayer1: TMediaPlayer;
    Ok_Event: TsButton;
    Content_Memo: TsMemo;
    procedure Set_asidClick(Sender: TObject);
    procedure Shut_offClick(Sender: TObject);
    procedure Ok_EventClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
end;

const
SLP = 5;

var
  Call: TCall;

implementation

{$R *.dfm}

uses AddAlarmClock, AlarmClockClass;

procedure TCall.Ok_EventClick(Sender: TObject);
begin
  Call.MediaPlayer1.Stop;
  Call.Close;
end;

procedure TCall.Set_asidClick(Sender: TObject);
var
i:integer;
begin
  for i := 0 to length(Alarm_Clock)-1 do
  begin
    if Alarm_Clock[i].Alarm_Clock_Name = sLabel1.caption then
    begin
      Alarm_Clock[i].Alarm_Clock_Minute := Alarm_Clock[i].Alarm_Clock_Minute + SLP;
      Alarm_Clock[i].Timer.Enabled := true;
      CAll.MediaPlayer1.Stop;
      Call.Close;
    end;
  end;
end;

procedure TCall.Shut_offClick(Sender: TObject);
var
i:integer;
AlarmClk:TAlarm_Clock;
begin
for i := 0 to length(Alarm_Clock)-1 do
  begin
    if Alarm_Clock[i].Alarm_Clock_Name = sLabel1.caption then
    begin
      Alarm_Clock[i].Timer.Enabled := false;
      Alarm_Clock[i].Timer.Destroy;
    end;
  end;
  for i := 0 to length(Alarm_Clock)-2 do
  begin
    if Alarm_Clock[i].Alarm_Clock_Name = sLabel1.caption then
    begin
       AlarmClk := Alarm_Clock[i];
       Alarm_Clock[i] := Alarm_Clock[i+1];
       Alarm_Clock[i+1] := AlarmClk;
    end;
  end;
  Alarm_Clock[length(Alarm_Clock)-1].Destroy;
  Setlength(Alarm_Clock, length(Alarm_Clock)-1);
  Call.MediaPlayer1.Stop;
  Call.Close;
end;

end.
