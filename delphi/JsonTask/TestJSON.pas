unit TestJSON;
{

  Delphi DUnit Test Case
  ----------------------
  This unit contains a skeleton test case class generated by the Test Case Wizard.
  Modify the generated code to correctly setup and call the methods from the unit
  being tested.

}

interface

uses
  TestFramework, System.Generics.Collections, MainClasses, System.IOUtils,
  System.SysUtils;

const
  JSON_FILE_NAME: string = 'testdata.json';
  SINTHESIS_JSON_FILE_NAME: string = 'newtestdata.json';

type

  // Test methods for class TDriverList
  TestTDriverList = class(TTestCase)
  strict private
    FDriverList: TDriverList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure testLoadFromJSON;
    procedure testSaveToJSON;
  end;

  // Test methods for class TAutoList
  TestTAutoList = class(TTestCase)
  strict private
    FAutoList: TAutoList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLoadFromJSON;
    procedure testSaveToJSON;
  end;

  // Test methods for class TestTTripList
  TestTTripList = class(TTestCase)
  strict private
    FTripList: TTripList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestLoadFromJSON;
    procedure testSaveToJSON;
  end;

implementation


procedure TestTDriverList.SetUp;
begin
  FDriverList := TDriverList.Create;
end;

procedure TestTDriverList.TearDown;
begin
  FDriverList.Free;
  FDriverList := nil;
end;

procedure TestTDriverList.testLoadFromJSON;
var
  ExePath: string;
  FullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');
  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);

  // implement this method
  FDriverList.loadFromJSON(FullPathName);

  Check(FDriverList.Count = 3);

  Check(FDriverList[0].Name = 'Frank Martin');
  Check(FDriverList[0].Phone = '555-0100');

  Check(FDriverList[1].Name = 'Travis Bickle');
  Check(FDriverList[1].Phone = '555-0123');

  Check(FDriverList[2].Name = 'Daniel Moralex');
  Check(FDriverList[2].Phone = '555-0130');
end;

procedure TestTDriverList.testSaveToJSON;
var
  ExePath: string;
  FullPathName, NewFullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');

  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);
  FDriverList.loadFromJSON(FullPathName);

  if TFile.Exists(TPath.Combine(ExePath, 'app.log')) then
    TFile.Delete(TPath.Combine(ExePath, 'app.log'));

  newFullPathName := TPath.Combine(ExePath, SINTHESIS_JSON_FILE_NAME);
  FDriverList.saveToJSON(newFullPathName);

  Check(TFile.ReadAllText(NewFullPathName)
        = '{"Driver":['
        + '{"ID":"1","Name":"Frank Martin","Phone":"555-0100"}'
        + ',{"ID":"2","Name":"Travis Bickle","Phone":"555-0123"}'
        + ',{"ID":"3","Name":"Daniel Moralex","Phone":"555-0130"}'
        + ']}');
end;

procedure TestTAutoList.SetUp;
begin
  FAutoList := TAutoList.Create;
end;

procedure TestTAutoList.TearDown;
begin
  FAutoList.Free;
  FAutoList := nil;
end;

procedure TestTAutoList.TestLoadFromJSON;
var
  ExePath: string;
  FullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');
  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);

  // implement this method
  FAutoList.loadFromJSON(FullPathName);

  Check(FAutoList.Count = 3);

  Check(FAutoList[0].Brand = 'Peugeot');
  Check(FAutoList[0].Model = '406');
  Check(FAutoList[0].Color = 'White');

  Check(FAutoList[1].Brand = 'BMW');
  Check(FAutoList[1].Model = '735i');
  Check(FAutoList[1].Color = 'Brown');
  Check(FAutoList[1].Number = '930UHV06');

  Check(FAutoList[2].Brand = 'Checker Taxi');
  Check(FAutoList[2].Color = 'Yellow');

end;

procedure TestTAutoList.testSaveToJSON;
var
  ExePath: string;
  FullPathName, NewFullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');

  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);
  FAutoList.loadFromJSON(FullPathName);

  if TFile.Exists(TPath.Combine(ExePath, 'app.log')) then
    TFile.Delete(TPath.Combine(ExePath, 'app.log'));

  newFullPathName := TPath.Combine(ExePath, SINTHESIS_JSON_FILE_NAME);
  FAutoList.saveToJSON(newFullPathName);

  Check(TFile.ReadAllText(NewFullPathName)
        = '{"Auto":['
        + '{"ID":"1","Brand":"Peugeot","Model":"406","Color":"White"}'
        + ',{"ID":"2","Brand":"BMW","Model":"735i","Color":"Brown","Number":"930UHV06"}'
        + ',{"ID":"3","Brand":"Checker Taxi","Color":"Yellow"}'
        + ']}');
end;

{ TestTTripList }

procedure TestTTripList.SetUp;
begin
  FTripList := TTripList.Create;
end;

procedure TestTTripList.TearDown;
begin
  FTripList.Free;
  FTripList := nil;
end;

procedure TestTTripList.TestLoadFromJSON;
var
  ExePath: string;
  FullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');
  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);

  // implement this method
  FTripList.loadFromJSON(FullPathName);

  Check(FTripList.Count = 3);

  Check(FTripList[0].ID = 1);
  Check(FTripList[0].AutoID = 3);
  Check(FTripList[0].DriverID = 2);
  Check(FTripList[0].StartTime = StrToDateTime('05.08.21 15:00:00'));

  Check(FTripList[1].ID = 2);
  Check(FTripList[1].AutoID = 2);
  Check(FTripList[1].DriverID = 2);
  Check(FTripList[1].StartTime = StrToDateTime('05.10.21 20:00:00'));

  Check(FTripList[2].ID = 3);
  Check(FTripList[2].AutoID = 1);
  Check(FTripList[2].DriverID = 3);
  Check(FTripList[2].StartTime = StrToDateTime('08.12.21 20:00:00'));
end;

procedure TestTTripList.testSaveToJSON;
var
  ExePath: string;
  FullPathName, NewFullPathName: TFileName;
begin
  ExePath := ExpandFileName(GetCurrentDir + '\..\..\');

  FullPathName := TPath.Combine(ExePath, JSON_FILE_NAME);
  FTripList.loadFromJSON(FullPathName);

  if TFile.Exists(TPath.Combine(ExePath, 'app.log')) then
    TFile.Delete(TPath.Combine(ExePath, 'app.log'));

  newFullPathName := TPath.Combine(ExePath, SINTHESIS_JSON_FILE_NAME);
  FTripList.saveToJSON(newFullPathName);

  Check(TFile.ReadAllText(NewFullPathName)
        = '{"Trip":['
        + '{"ID":"1","AutoID":"3","DriverID":"2","StartTime":"05.08.2021 15:00:00"}'
        + ',{"ID":"2","AutoID":"2","DriverID":"2","StartTime":"05.10.2021 20:00:00"}'
        + ',{"ID":"3","AutoID":"1","DriverID":"3","StartTime":"08.12.2021 20:00:00"}'
        + ']}');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTDriverList.Suite);
  RegisterTest(TestTAutoList.Suite);
  RegisterTest(TestTTripList.Suite);
end.

