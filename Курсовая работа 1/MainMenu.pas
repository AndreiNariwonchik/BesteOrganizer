unit MainMenu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.jpeg, Vcl.ExtCtrls, mmSystem,
  Vcl.StdCtrls,DateUtils, sLabel, Vcl.Mask, sMaskEdit, sCustomComboEdit, sCurrEdit, Vcl.Grids,
  Vcl.Samples.Calendar, Vcl.ComCtrls, ContactChanche, EventsClass, sButton, sEdit, sSpinEdit, sPanel,
  Vcl.Menus, GreetingForm;
type
  TOrganizer = class(TForm)
    Image1: TImage;
    alarm_clock_image: TImage;
    Alarm_Clock_label: TsLabel;
    Phone_image: TImage;
    Contacts_label: TsLabel;
    Events_label: TsLabel;
    Image2: TImage;
    Bild_Contacts: TsButton;
    Bild_Events: TsButton;
    StringGridEvents: TStringGrid;
    sCalcEdit1: TsCalcEdit;
    DateTimePicker1: TDateTimePicker;
    Calculator_label: TsLabel;
    DateTimePicker_label: TsLabel;
    DisplayDateEvents: TsButton;
    MenuPanel: TsPanel;
    Time_Label: TsLabel;
    Timer1: TTimer;
    PanelForTime: TsPanel;
    Exit: TsButton;
    procedure alarm_clock_imageClick(Sender: TObject);
    procedure Phone_imageClick(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Bild_ContactsClick(Sender: TObject);
    procedure DisplayDateEventsClick(Sender: TObject);
    procedure Bild_EventsClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Organizer: TOrganizer;

implementation

{$R *.dfm}

uses AddAlarmClock, AlarmClockAndEventsCall, WorkingWithContacts, AddNewEvent;

procedure TOrganizer.alarm_clock_imageClick(Sender: TObject);
begin
  New_Alarm_clock.Show;
end;

procedure TOrganizer.DisplayDateEventsClick(Sender: TObject);
var
  i,n,j: integer;
  Dat:TDate;
  MyDate:TDate;
  myYear, myMonth, myDay:word;
begin
  myDate := DateTimePicker1.Date;
  DecodeDate(myDate, myYear, myMonth, myDay);
  with StringGridEvents do
  begin
    RowCount := 1;
    Cells[0,0] := '           ���� / ����';
    Cells[1,0] := '             �������';
    for i := 0 to length(MyEvents)-1 do
    begin
      if (myYear = YearOf(now)) and (Month[myMonth] = MyEvents[i].EventMonth) and (myDay = MyEvents[i].EventDate) then
      begin
        for j := 1 to 12 do
        begin
           if Month[j] = MyEvents[i].EventMonth then
           n:= j;
        end;
        Dat := EncodeDate(YearOf(now), n, MyEvents[i].EventDate);
        RowCount := RowCount + 1;
        Cells[0 ,RowCount - 1] := MyEvents[i].EventTheme + ' --- ' + FormatDatetime('dddddd', Dat) ;
        Cells[1, RowCount -1] := MyEvents[i].EventContent;
      end;
    end;
  end;
end;

procedure TOrganizer.ExitClick(Sender: TObject);
begin
  Organizer.Close;
end;

procedure TOrganizer.Bild_ContactsClick(Sender: TObject);
var
i:integer;
begin
  with ViewAndEditContacts do
  begin
    Close_Redact_Items.Visible := true;
    Height := 400;
    Items_Name.Caption := '��� ��������';
    All_Items.Cells[0,0] := '���';
    All_Items.Cells[1,0] := '�����';
    All_Items.RowCount := length(MyContacts)+1;
    for i := 0 to length(MyContacts)-1 do
    begin
      All_Items.Cells[0 ,i+1] := MyContacts[i].Contact_Name;
      All_Items.Cells[1, i+1] := MyContacts[i].Contact_Number;
    end;
  end;
  ViewAndEditContacts.Show;
  end;

procedure TOrganizer.Bild_EventsClick(Sender: TObject);
var
  i,n,j: integer;
  Dat:TDate;
begin
  with StringGridEvents do
  begin
    Cells[0,0] := '           ���� / ����';
    Cells[1,0] := '             �������';
    RowCount := length(MyEvents)+1;
    for i := 0 to length(MyEvents)-1 do
    begin
      for j := 1 to 12 do
      begin
         if Month[j] = MyEvents[i].EventMonth then
         n:= j;
      end;
      Dat := EncodeDate(YearOf(now), n, MyEvents[i].EventDate);
      Cells[0 ,i+1] := MyEvents[i].EventTheme + ' --- ' + FormatDatetime('dddddd', Dat) ;
      Cells[1, i+1] := MyEvents[i].EventContent;
    end;
  end;
end;

procedure TOrganizer.FormCreate(Sender: TObject);
var
Theme, Monat, content:string;
Date, Hour, Minute, i, n:integer;
Reminder:boolean;
Temp:string;
Events_File: TextFile;
AlarmTime:TDateTime;
begin
  StringGridEvents.Cells[0,0] := '           ���� / �����';
  StringGridEvents.Cells[1,0] := '             �������';
  try
  begin
    AssignFile(Events_File,'Files\Events.txt');
    Reset(Events_File);
    SetLength(MyEvents, 0);
    while not EOF(Events_File) do
    begin
      readln(Events_File, Theme);
      read(Events_File, Monat);
      readln(Events_File, Date);
      readln(Events_File, Hour);
      readln(Events_File, Minute);
      readln(Events_File, Temp);
      if temp = 'true' then
       Reminder := true
      else
       Reminder := false;
      readln(Events_File, Content);
      readln(Events_File);
      n := 1;
      for i := 1 to 12 do
      begin
        if Month[i] = Monat then
        begin
          n := i;
        end;
      end;
       if CompareDateTime(Now, EncodeDateTime(YearOf(now), n, Date, Hour, Minute, 0, 0)) <= 0 then
      begin
        Setlength(MyEvents, length(MyEvents)+1);
        MyEvents[length(MyEvents)-1] := TEvent.create(Theme, Monat, Date, Hour, Minute, Reminder, Content);
      end;
    end;
    CloseFile(Events_File);
  end;
  except
    Showmessage('��������� ������ �������� �����. �� �������� � ���������!');
    sleep(3000);
    AssignFile(Events_File,'Files\Events.txt');
    Rewrite(Events_File);
    closeFile(Events_File);
    Showmessage('������ ������� ����������!');
  end;
end;

procedure TOrganizer.Image2Click(Sender: TObject);
begin
  New_Event.Show;
  Organizer.Hide;
end;

procedure TOrganizer.Phone_imageClick(Sender: TObject);
begin
  New_Contact.Show;
end;

procedure TOrganizer.Timer1Timer(Sender: TObject);
begin
  Time_Label.Caption := FormatDateTime('tt', now);
end;

end.



