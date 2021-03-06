unit AlarmClockClass;

interface
  uses  Winapi.Windows, Vcl.ExtCtrls, System.Classes, DateUtils, SysUtils;

Type
TAlarm_Clock = class
private
  AlarmClockName:string;
  AlarmClockDay:string;
  AlarmClockHour:integer;
  AlarmClockMinute:integer;
public
  Timer:TTimer;
  property Alarm_Clock_Name:string read AlarmClockName write AlarmClockName;
  property Alarm_Clock_Day:string read AlarmClockDay write AlarmClockDay;
  property Alarm_Clock_Hour:integer read AlarmClockHour write AlarmClockHour;
  property Alarm_Clock_Minute:integer read AlarmClockMinute write AlarmClockMinute;
  constructor create(newAlarm_Clock_Name, newAlarm_Clock_Day:string; newAlarm_Clock_Hour, newAlarm_Clock_Minute:integer);
  Procedure TimerOnTimer(Sender:TObject);
end;

implementation
uses AddAlarmClock, AlarmClockAndEventsCall;

constructor TAlarm_Clock.create(newAlarm_Clock_Name, newAlarm_Clock_Day: string;
 newAlarm_Clock_Hour, newAlarm_Clock_Minute: integer);
begin
  Timer:= TTimer.Create(Timer);
  Alarm_Clock_Name := newAlarm_Clock_Name;
  Alarm_Clock_Hour := newAlarm_Clock_Hour;
  Alarm_Clock_Minute := newAlarm_Clock_Minute;
  Alarm_Clock_Day := newAlarm_Clock_Day;
  Timer.OnTimer := TimerOnTimer;
  Timer.Interval := 1000;
  Timer.Enabled := True;
end;

procedure TAlarm_Clock.TimerOnTimer(Sender: TObject);
var
AlarmTime:TDateTime;
begin
  AlarmTime := EncodeTime(Alarm_Clock_Hour, Alarm_Clock_Minute, 0, 0);
  if (CompareTime(now, AlarmTime) >= 0) and (Day[DayOfWeek(now)] = Alarm_Clock_Day )then
  begin
    Timer.Enabled:=False;
    with Call do
    begin
      Caption := '���������';
      Ok_Event.Visible := false;
      Content_Memo.Visible := false;
      Shut_off.Visible := true;
      Set_asid.Visible := true;
      sLabel1.Font.Size := 15;
      sLabel2.Font.Size := 20;
      Font.Name := 'Times New Roman';
      sLabel1.Caption := Alarm_Clock_Name;
      if (Alarm_Clock_Minute in [0..9]) or (Alarm_Clock_Hour in [0..9]) then
      begin
        if  (Alarm_Clock_Hour in [0..9]) and not(Alarm_Clock_minute in [0..9] ) then
        begin
          sLabel2.Caption :='0' + IntToStr(Alarm_Clock_Hour)
         + ':' + InttoStr(Alarm_Clock_Minute);
        end;
        if  (Alarm_Clock_Minute in [0..9]) and not(Alarm_Clock_Hour in [0..9]) then
        begin
          sLabel2.Caption :=IntToStr(Alarm_Clock_Hour)
          + ':0' + InttoStr(Alarm_Clock_Minute);
        end;
        if(Alarm_Clock_Hour in [0..9]) and (Alarm_Clock_Minute in [0..9]) then
        begin
          sLabel2.Caption := '0' + IntToStr(Alarm_Clock_Hour)
          + ':' + InttoStr(Alarm_Clock_Minute);
        end;
      end
      else
      begin
        sLabel2.Caption := IntToStr(Alarm_Clock_Hour) + ':' + IntToStr(Alarm_Clock_Minute);
      end;
      if New_Alarm_Clock.Melody1.Checked = true then
        MediaPlayer1.FileName:='Alarm_Clock Musik\�������1.mp3'
      else
      if New_Alarm_Clock.Melody2.Checked = true then
        MediaPlayer1.FileName:='Alarm_Clock Musik\�������2.mp3'
      else
      if New_Alarm_Clock.Melody3.Checked = true then
        MediaPlayer1.FileName:='Alarm_Clock Musik\�������4.mp3'
      else
      MediaPlayer1.FileName:='Alarm_Clock Musik\�������3.mp3';
      MediaPlayer1.Open;
      MediaPlayer1.Play;
      MediaPlayer1.Visible := false;
      Showmodal;
    end;
  end;

end;

{ TAlarm_Clock }
end.
