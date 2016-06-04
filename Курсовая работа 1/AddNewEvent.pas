unit AddNewEvent;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, EventsClass, Vcl.StdCtrls, sMemo, sButton,
  sRadioButton, Vcl.ComCtrls, sUpDown, sEdit, sComboBox, sLabel, Vcl.ExtCtrls,
  sPanel, Vcl.Imaging.jpeg, DateUtils, sCheckBox;

type
  TNew_Event = class(TForm)
    sPanel1: TsPanel;
    EventTheme_label: TsLabel;
    Minute_Label: TsLabel;
    Hour_Label: TsLabel;
    Hour: TsEdit;
    UpDownHour: TsUpDown;
    Minute: TsEdit;
    EventName_Edit: TsEdit;
    UpDownMinute: TsUpDown;
    Melody1: TsRadioButton;
    Melody2: TsRadioButton;
    Melody3: TsRadioButton;
    Add_Event: TsButton;
    AlarmClock_close: TsButton;
    Content_memo: TsMemo;
    Reminder: TsCheckBox;
    MonthCalendar1: TMonthCalendar;
    Image1: TImage;
    Delete_Event: TsButton;
    procedure FormCreate(Sender: TObject);
    procedure Add_EventClick(Sender: TObject);
    procedure AlarmClock_closeClick(Sender: TObject);
    procedure Delete_EventClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  New_Event: TNew_Event;
  MyEvents:array of TEvent;
  Month:array[1..12] of string = ('������','�������','����','������','���','����',
  '����','������','��������','�������','������','�������');
  Events_File: TextFile;

  implementation

{$R *.dfm}

uses MainMenu, AlarmClockAndEventsCall;

procedure TNew_Event.Add_EventClick(Sender: TObject);
begin
  if CompareDateTime(Now, EncodeDateTime(YearOf(now),MonthOf(MonthCalendar1.Date), DayOfTheMonth(MonthCalendar1.Date)
  ,StrToInt(Hour.Text), StrToInt(Minute.Text), 0, 0)) <= 0 then
  begin
    if length(Content_memo.Text) < 60 then
    begin
      if length(EventName_Edit.Text)<= 12 then
      begin
        Setlength(MyEvents, length(MyEvents)+1);
        MyEvents[length(MyEvents) - 1] := TEvent.create({@Call,} EventName_Edit.Text, Month[MonthOf(MonthCalendar1.Date)],
        DayOfTheMonth(MonthCalendar1.Date), StrToInt(Hour.Text), StrToInt(Minute.Text),
        Reminder.Checked, Content_Memo.Text);
        Showmessage('������� ������� ���������!');
      end
      else
      Showmessage('���� �������: ����� ������� �������, ��������, ����������, � ������!');
    end
    else
    showmessage('����� �������� ������� �������, ��������, ����������, � ������!');
  end
  else
  begin
    Showmessage('��� ������� ��� ������!');
  end;
end;

procedure TNew_Event.AlarmClock_closeClick(Sender: TObject);
var
i:integer;
begin
    if length(MyEvents)>0 then
  begin
  try
    AssignFile(Events_File,'Files\Events.txt');
    rewrite(Events_File);
    for i := 0 to length(MyEvents)-1 do
      begin
        Writeln(Events_File, MyEvents[i].EventTheme);
        Writeln(Events_File, MyEvents[i].EventMonth);
        Writeln(Events_File, IntToStr(MyEvents[i].EventDate));
        Writeln(Events_File, IntToStr(MyEvents[i].EventHour));
        Writeln(Events_File, IntToStr(MyEvents[i].EventMinute));
        if MyEvents[i].EventReminder = true then
        Writeln(Events_File, 'true')
        else
        Writeln(Events_File, 'false');
        Writeln(Events_File, MyEvents[i].EventContent);
        Writeln(Events_File);
      end;
      CloseFile(Events_File);
  except
     Showmessage('��������� ������ ��� ������� ������ ���������� � ����.');
  end;
  end;
  New_Event.Close;
  Organizer.Show;
end;

procedure TNew_Event.Delete_EventClick(Sender: TObject);
var
i,j:integer;
copyMyEvent: TEvent;
begin
  for i := 0 to length(MyEvents)-1 do
    begin
      if (Month[MonthOf(MonthCalendar1.Date)] = MyEvents[i].EventMonth) and (DayOfTheMonth(MonthCalendar1.Date) = MyEvents[i].EventDate) and (MyEvents[i].EventTheme = EventName_Edit.Text) then
      begin
        for j := i to length(MyEvents)-2 do
        begin
          copyMyEvent := MyEvents[j];
          MyEvents[j] := MyEvents[j+1];
          MyEvents[j+1] := copyMyEvent;
        end;
        MyEvents[length(MyEvents)-1].Timer.Destroy();
        MyEvents[length(MyEvents)-1].Destroy();
        Setlength(MyEvents, length(MyEvents)-1);
        exit;
      end;
    end;
end;

procedure TNew_Event.FormCreate(Sender: TObject);
begin
  EventTheme_label.Font.Name := 'Times New Roman';
  EventTheme_label.Font.Size := 14;
  EventTheme_label.Font.Style := [fsItalic];
  EventTheme_label.Caption := '������� ���� �������: ';
  UpDownHour.Position := HourOf(now);
  UpDownMinute.Position := MinuteOf(now);
end;

end.
