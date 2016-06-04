program BesteOrganizer;

uses
  Vcl.Forms,
  GreetingForm in 'GreetingForm.pas' {Greeting},
  MainMenu in 'MainMenu.pas' {Organizer},
  AlarmClockClass in 'AlarmClockClass.pas',
  AddAlarmClock in 'AddAlarmClock.pas' {New_Alarm_clock},
  AlarmClockAndEventsCall in 'AlarmClockAndEventsCall.pas' {Call},
  ContactChanche in 'ContactChanche.pas' {New_Contact},
  WorkingWithContacts in 'WorkingWithContacts.pas' {ViewAndEditContacts},
  EventsClass in 'EventsClass.pas',
  AddNewEvent in 'AddNewEvent.pas' {New_Event};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TGreeting, Greeting);
  Application.CreateForm(TOrganizer, Organizer);
  Application.CreateForm(TNew_Alarm_clock, New_Alarm_clock);
  Application.CreateForm(TCall, Call);
  Application.CreateForm(TNew_Contact, New_Contact);
  Application.CreateForm(TViewAndEditContacts, ViewAndEditContacts);
  Application.CreateForm(TNew_Event, New_Event);
  Application.Run;
end.
