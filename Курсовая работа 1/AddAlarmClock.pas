unit AddAlarmClock;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, sUpDown, Vcl.StdCtrls,
  sEdit, sComboBox, Vcl.Imaging.jpeg, Vcl.ExtCtrls, sLabel, sPanel, DateUtils,
  sButton, sMemo, sGroupBox, sRadioButton, AlarmClockClass;

type
  TNew_Alarm_clock = class(TForm)
    UpDownHour: TsUpDown;
    Hour: TsEdit;
    Day_Of_Week: TsComboBox;
    Image1: TImage;
    AlarmClockName_Edit: TsEdit;
    AlarmClockName_label: TsLabel;
    sPanel1: TsPanel;
    Minute: TsEdit;
    UpDownMinute: TsUpDown;
    Minute_Label: TsLabel;
    Hour_Label: TsLabel;
    Add_AlarmClock: TsButton;
    sButton1: TsButton;
    All_Alarms_Button: TsButton;
    AlarmClock_close: TsButton;
    sButton3: TsButton;
    All_Alarms_memo: TsMemo;
    Melody1: TsRadioButton;
    Melody2: TsRadioButton;
    Melody3: TsRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure Add_AlarmClockClick(Sender: TObject);
    procedure AlarmClock_closeClick(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure All_Alarms_ButtonClick(Sender: TObject);
    procedure Melody1Click(Sender: TObject);
    procedure Melody2Click(Sender: TObject);
    procedure Melody3Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  New_Alarm_clock: TNew_Alarm_clock;
  Day: array [1..7] of string = ('�����������', '�����������','�������','�����','�������','�������','�������');
  Alarm_Clock:array of TAlarm_Clock;
implementation

{$R *.dfm}

uses MainMenu;

procedure TNew_Alarm_clock.Add_AlarmClockClick(Sender: TObject);
var
i:integer;
flag:boolean;
begin
  if length(AlarmClockName_Edit.Text) <= 10 then
  begin
    flag := true;
    if (Day_Of_Week.text = Day[1]) xor (Day_Of_Week.text = Day[2]) xor (Day_Of_Week.text = Day[3]) xor (Day_Of_Week.text = Day[4]) xor
    (Day_Of_Week.text = Day[5]) xor (Day_Of_Week.text = Day[6]) xor (Day_Of_Week.text = Day[7]) then
    begin
      try
        if (StrToInt(Hour.Text) >= 0) and (StrToInt(Hour.Text)<24) and (StrToInt(minute.Text)>=0) and (StrToInt(minute.Text)<60) then
        begin
          if (((compareDateTime(now, EncodeDateTime(YearOf(now), MonthOf(now), DayOfTheMonth(now), StrToInt(Hour.Text), StrToInt(Minute.Text), 0, 0)) <1) and(Day_Of_Week.Text = Day[DayOfWeek(now)])) or (Day_Of_Week.Text <> Day[DayOfWeek(now)])) then
          begin
            if (AlarmClockName_edit.Text = '') then
            begin
              Setlength(Alarm_Clock, length(Alarm_Clock) +1);
              AlarmClockName_edit.Text := 'Clock ' + IntToStr(length(Alarm_Clock)-1);
              Alarm_Clock[length(Alarm_Clock)-1] := TAlarm_Clock.create(AlarmClockName_edit.Text, Day_Of_Week.Text, StrToInt(Hour.Text), StrToInt(Minute.Text));
              Showmessage('��������� ������� ��������!');
            end
            else
            begin
              for i := 0 to length( Alarm_Clock)-1 do
              begin
                if AlarmClockName_edit.Text = Alarm_Clock[i].Alarm_Clock_Name then
                begin
                  showmessage('��������� � ����� ������ ��� ����������!');
                  flag := false;
                end;
              end;
              if flag = true then
              begin
                Setlength(Alarm_Clock, length(Alarm_Clock) +1);
                Alarm_Clock[length(Alarm_Clock)-1] := TAlarm_Clock.create(AlarmClockName_edit.Text, Day_Of_Week.Text, StrToInt(Hour.Text), StrToInt(Minute.Text));
                Showmessage('��������� ������� ��������!');
              end;
            end;
          end;
        end
        else
        begin
          Showmessage('������� ���������� �����!');
        end;
      except
        Showmessage('����� ������ ���� ������!');
      end;
    end;
  end
  else
  begin
    Showmessage('��� ������� �������!');
  end;
end;

procedure TNew_Alarm_clock.AlarmClock_closeClick(Sender: TObject);
begin
  New_Alarm_Clock.Close;
end;

procedure TNew_Alarm_clock.FormCreate(Sender: TObject);
var
i:integer;
begin
  Setlength(Alarm_Clock,0);
  AlarmClockName_label.Font.Name := 'Times New Roman';
  AlarmClockName_label.Font.Size := 14;
  AlarmClockName_label.Font.Style := [fsItalic];
  AlarmClockName_label.Caption:='������� ��� ����������: ';
  Day_Of_Week.Text:= Day[DayOfWeek(now)];
  for i:=1 to 7 do
  begin
    Day_Of_Week.Items.Add(Day[i]);
  end;
  UpDownHour.Position := HourOf(now);
  UpDownMinute.Position := MinuteOf(now);
end;


procedure TNew_Alarm_clock.Melody1Click(Sender: TObject);
begin
  Melody1.Checked := true;
  Melody2.Checked := false;
  Melody3.Checked := false;
end;

procedure TNew_Alarm_clock.Melody2Click(Sender: TObject);
begin
  Melody1.Checked := false;
  Melody2.Checked := true;
  Melody3.Checked := false;
end;

procedure TNew_Alarm_clock.Melody3Click(Sender: TObject);
begin
  Melody1.Checked := false;
  Melody2.Checked := false;
  Melody3.Checked := true;
end;

procedure TNew_Alarm_clock.All_Alarms_ButtonClick(Sender: TObject);
var
i:integer;
begin
  All_Alarms_memo.Clear;
  for i := 0 to length(Alarm_Clock)-1 do
  begin
  with  All_Alarms_memo do
    begin
      Color:=clBlue;
      Lines.Add(Alarm_Clock[i].Alarm_Clock_Name);
      if Alarm_Clock[i].Alarm_Clock_Minute in [1..9] then
      begin
        Lines.Add( Alarm_Clock[i].Alarm_Clock_Day+ ' ' + IntToStr(Alarm_Clock[i].Alarm_Clock_Hour)
        + ':0' + InttoStr(Alarm_Clock[i].Alarm_Clock_Minute));
      end
      else
      begin
        Lines.Add( Alarm_Clock[i].Alarm_Clock_Day+ ' ' + IntToStr(Alarm_Clock[i].Alarm_Clock_Hour)
        + ':' + InttoStr(Alarm_Clock[i].Alarm_Clock_Minute));
      end;
      Lines.Add('***********************');
    end;
  end;
end;

procedure TNew_Alarm_clock.sButton1Click(Sender: TObject);
var
i:integer;
begin
  if length(Alarm_Clock) = 0 then
  Showmessage('����������� ���, ���������� �������� �����!')
  else
  for i := 0 to length(Alarm_Clock) -1 do
    begin
      if Alarm_Clock[i].Alarm_Clock_Name = AlarmClockName_edit.Text then
      begin
        Alarm_Clock[i].Timer.Enabled := false;
        if (Day_Of_Week.text = '�����������') xor (Day_Of_Week.text = '�����������') xor
        (Day_Of_Week.text = '�������') xor (Day_Of_Week.text = '�����') xor
        (Day_Of_Week.text = '�������') xor (Day_Of_Week.text = '�������') xor (Day_Of_Week.text = '�������') then
        begin
          if (StrToInt(Hour.Text) >= 0) and (StrToInt(Hour.Text)<24) and (StrToInt(minute.Text)>=0) and (StrToInt(minute.Text)<60) then
          begin
            if (((compareDateTime(now, EncodeDateTime(YearOf(now), MonthOf(now), DayOfTheMonth(now), StrToInt(Hour.Text), StrToInt(Minute.Text), 0, 0)) <1) and(Day_Of_Week.Text = Day[DayOfWeek(now)])) or (Day_Of_Week.Text <> Day[DayOfWeek(now)])) then
            begin
              Alarm_Clock[i].Alarm_Clock_Day := Day_Of_Week.Text;
              Alarm_Clock[i].Alarm_Clock_Hour := StrToInt(Hour.Text);
              Alarm_Clock[i].Alarm_Clock_Minute := StrToInt(Minute.Text);
              Alarm_Clock[i].Timer.Enabled := true;
            end;
          end;
        end
      else
      Showmessage('����������, ������� �� ������ �������� �� ����������!');
      end;
    end;
end;

procedure TNew_Alarm_clock.sButton3Click(Sender: TObject);
var
i:integer;
AlarmClk:TAlarm_Clock;
flag:boolean;
begin
  flag:=false;
  for i := 0 to length(Alarm_Clock)-2 do
   begin
     Showmessage(IntToStr(length(Alarm_Clock)));
     if Alarm_Clock[i].Alarm_Clock_Name = AlarmClockName_Edit.Text then
     begin
        AlarmClk := Alarm_Clock[i];
        Alarm_Clock[i] := Alarm_Clock[i+1];
        Alarm_Clock[i+1] :=AlarmClk;
     end;
     flag:=true;
   end;
   if flag = true then
   begin
     Alarm_Clock[length(Alarm_Clock)-1].Timer.Enabled := false;
     Alarm_Clock[length(Alarm_Clock)-1].Timer.Destroy;
     Alarm_Clock[length(Alarm_Clock)-1].Destroy;
     Setlength(Alarm_Clock, length(Alarm_Clock)-1)
   end
   else
   Showmessage('������ ���������� ���!');
end;

end.
