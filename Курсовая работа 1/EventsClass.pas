unit EventsClass;

interface

uses Winapi.Windows, Vcl.ExtCtrls,System.Classes, DateUtils, SysUtils, Vcl.Forms, Vcl.MPlayer;

//Type
//TEventsOnTimer = procedure(sender:TObject);

Type
TEvent = class
private
  Event_Theme:string;
  Event_Month:string;
  Event_Date:integer;
  Event_Hour:integer;
  Event_Minute:integer;
  Event_Reminder:boolean;
  Event_Content:String;
public
  Timer:TTimer;
  constructor create(newEventTheme, newEventMonth:string; newEventDate, newEventHour, newEventMinute:integer; newEventReminder:boolean; newEventContent:String);
  property EventTheme: string read Event_Theme write Event_Theme;
  property EventMonth:string read Event_Month write Event_Month;
  Property EventDate:integer read Event_Date write Event_Date;
  property EventHour:integer read Event_Hour write Event_Hour;
  property EventMinute:integer read Event_Minute write Event_Minute;
  property EventReminder:boolean read Event_Reminder write Event_Reminder;
  property EventContent:String read Event_Content write Event_Content;
  Procedure TimerOnTimer(Sender:TObject);
end;

implementation

{ TNote }
uses AlarmClockAndEventsCall, AddNewEvent;

constructor TEvent.create(newEventTheme, newEventMonth: string; newEventDate, newEventHour,
  newEventMinute: integer; newEventReminder:boolean; newEventContent:String);
begin
  Timer:= TTimer.Create(Timer);
  EventTheme := newEventTheme;
  EventMonth := newEventMonth;
  EventDate := newEventDate;
  EventHour := newEventHour;
  EventMinute := newEventMinute;
  EventReminder := newEventReminder;
  EventContent := newEventContent;
  Timer.OnTimer := TimerOnTimer;
  Timer.Interval := 1000;
  if newEventReminder = true then
  Timer.Enabled := True
  else
  Timer.Enabled := false;
end;

procedure TEvent.TimerOnTimer(Sender: TObject);
var
AlarmTime:TDateTime;
begin
  AlarmTime := EncodeTime(EventHour, EventMinute, 0, 0);
  if (CompareTime(now, AlarmTime) >= 0) and (Month[MonthOf(now)] = EventMonth) and (DayOfTheMonth(now) = EventDate)  then
  begin
    Timer.Enabled:=False;
    if  EventReminder = true then
    begin
      Call.Caption := '�����������';
      Call.sLabel1.Font.Size := 15;
      Call.sLabel2.Font.Size := 20;
      Call.Shut_off.Visible := false;
      Call.Set_asid.Visible := false;
      Call.Ok_Event.Visible := true;
      Call.content_memo.Visible := true;
      Call.Height := 212;
      Call.Font.Name := 'Times New Roman';
      Call.sLabel1.Caption := EventTheme;
      Call.Content_Memo.Lines.Add(EventContent);
      if (EventMinute in [0..9]) or (Event_Hour in [0..9]) then
        begin
          if (EventMinute in [0..9]) and not(EventHour in [0..9]) then
          begin
            Call.sLabel2.Caption := IntToStr(EventHour)+ ':0' + InttoStr(EventMinute);
          end;
          if (EventHour in [0..9]) and not (EventMinute in [0..9])then
          begin
            Call.sLabel2.Caption :='0' + IntToStr(EventHour)+ ':' + InttoStr(EventMinute);
          end;
          if (EventMinute in [0..9]) and (Event_Hour in [0..9]) then
          begin
            Call.sLabel2.Caption := IntToStr(EventHour)+ '0:0' + InttoStr(EventMinute);
          end;
        end
        else
        begin
          Call.sLabel2.Caption := IntToStr(EventHour) + ':' + IntToStr(EventMinute);
        end;

      if New_Event.Melody1.Checked = true then
      Call.MediaPlayer1.FileName:='Events_Music\�������3.mp3'
      else
      if New_Event.Melody2.Checked = true then
      Call.MediaPlayer1.FileName:='Events_Music\�������2.mp3'
      else
      if New_Event.Melody3.Checked = true then
      Call.MediaPlayer1.FileName:='Events_Music\�������4.mp3'
      else
      Call.MediaPlayer1.FileName:='Events_Music\�������1.mp3';
      Call.MediaPlayer1.Open;
      Call.MediaPlayer1.Play;
    end;
    Call.MediaPlayer1.Visible := false;
    Call.Showmodal;
  end;
end;

end.
