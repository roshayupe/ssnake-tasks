unit MainClasses;

interface
uses
  System.Generics.Collections, System.SysUtils, JSON;

type
  TAuto = class(TObject)
  private
    FBrand: string;
    FColor: string;
    FID: Integer;
    FModel: string;
    FNumber: string;
  public
    property Brand: string read FBrand write FBrand;
    property Color: string read FColor write FColor;
    property ID: Integer read FID write FID;
    property Model: string read FModel write FModel;
    property Number: string read FNumber write FNumber;
  end;

  TDriver = class(TObject)
  private
    FID: Integer;
    FName: string;
    FPhone: string;
  public
    property ID: Integer read FID write FID;
    property Name: string read FName write FName;
    property Phone: string read FPhone write FPhone;
  end;

  TTrip = class
  private
    FID: Integer;
    FAutoID: Integer;
    FDriverID: Integer;
    FStartTime: TDateTime;
  public
    property ID: Integer read FID write FID;
    property AutoID: Integer read FAutoID write FAutoID;
    property DriverID: Integer read FDriverID write FDriverID;
    property StartTime: TDateTime read FStartTime write FStartTime;
  end;

  TDriverList = class(TObjectList<TDriver>)
  public
    procedure loadFromJSON(fileName: TFileName);
    procedure saveToJSON(fileName: TFileName);
  end;

  TAutoList = class(TObjectList<TAuto>)
    procedure loadFromJSON(fileName: TFileName);
    procedure saveToJSON(fileName: TFileName);
  end;

  TTripList = class(TObjectList<TTrip>)
  public
    procedure loadFromJSON(fileName: TFileName);
    procedure saveToJSON(fileName: TFileName);
  end;

implementation

uses
  System.IOUtils, Windows, DBXJSON, DBXJSONReflect, Classes, StrUtils;

{ TDriverList }

procedure TDriverList.loadFromJSON(fileName: TFileName);
var jsv   : TJsonValue;
    originalObject : TJsonObject;

    jsPair : TJsonPair;
    jsArr : TJsonArray;
    jso  : TJsonObject;
    i : integer;
    driver: TDriver;
begin

  //parse json string
  jsv := TJSONObject.ParseJSONValue(TFile.ReadAllText(fileName));
  try
      //value as object
      originalObject := jsv as TJsonObject;

      //get pair, wich contains Array of objects
      jspair := originalObject.Get('Driver');
      //pair value as array
      jsArr := jsPair.jsonValue as TJsonArray;

      //enumerate objects in array
      for i := 0 to pred(jsArr.Count) do begin
          // i-th object
          jso := jsArr.Items[i].AsType<TJsonObject>;

          driver := TDriver.Create;
          driver.ID := StrToInt(jso.Values['ID'].Value);
          driver.Name := jso.Values['Name'].Value;
          driver.Phone := jso.Values['Phone'].Value;

          Self.Add(driver);

      end;
  finally
      jsv.Free();
  end;

end;

procedure TDriverList.saveToJSON(fileName: TFileName);
var jso, jsNestO: TJSONObject;
    jsArr : TJsonArray;
    I: Integer;
begin
  jso := TJSONObject.Create;

  jsArr := TJSONArray.Create;

  for I := 0 to pred(Self.Count) do
  begin
    jsArr.AddElement(TJSONObject.Create);
    jsNestO := jsArr.Items[pred(jsArr.Count)] as TJSONObject;
    jsNestO.AddPair('ID', IntToStr(Self.Items[I].ID))
           .AddPair('Name', Self.Items[I].Name)
           .AddPair('Phone', Self.Items[I].Phone);
  end;

  jso.AddPair('Driver', jsArr);

  TFile.WriteAllText(fileName, jso.ToJSON);

end;

{ TAutoList }

procedure TAutoList.loadFromJSON(fileName: TFileName);
var jsv   : TJsonValue;
    originalObject : TJsonObject;

    jsPair : TJsonPair;
    jsArr : TJsonArray;
    jso  : TJsonObject;
    i : integer;
    auto: TAuto;
begin

  //parse json string
  jsv := TJSONObject.ParseJSONValue(TFile.ReadAllText(fileName));
  try
      //value as object
      originalObject := jsv as TJsonObject;

      //get pair, wich contains Array of objects
      jspair := originalObject.Get('Auto');
      //pair value as array
      jsArr := jsPair.jsonValue as TJsonArray;

      //enumerate objects in array
      for i := 0 to pred(jsArr.Count) do begin
          // i-th object
          jso := jsArr.Items[i].AsType<TJsonObject>;

          auto := TAuto.Create;
          auto.ID := StrToInt(jso.Values['ID'].Value);

          //enumerate object fields
          for jsPair in jso do begin
              case IndexStr(jsPair.JsonString.Value, ['ID','Brand','Model','Color','Number']) of
                0 : ;
                1 : auto.Brand := jsPair.JsonValue.Value;
                2 : auto.Model := jsPair.JsonValue.Value;
                3 : auto.Color := jsPair.JsonValue.Value;
                4 : auto.Number := jsPair.JsonValue.Value;
                -1: raise Exception.Create('DoSomethingWith: Unexpected value');
              end;

          end;

          Self.Add(auto);

      end;
  finally
      jsv.Free();
  end;

end;

procedure TAutoList.saveToJSON(fileName: TFileName);
var jso, jsNestO: TJSONObject;
    jsArr : TJsonArray;
    I: Integer;
    fldValue: string;
begin
  jso := TJSONObject.Create;

  jsArr := TJSONArray.Create;

  for I := 0 to pred(Self.Count) do
  begin
    jsArr.AddElement(TJSONObject.Create);
    jsNestO := jsArr.Items[pred(jsArr.Count)] as TJSONObject;

    jsNestO.AddPair('ID', IntToStr(Self.Items[I].ID));
    fldValue := Self.Items[I].Brand;
    if not fldValue.IsEmpty then jsNestO.AddPair('Brand', fldValue);
    fldValue := Self.Items[I].Model;
    if not fldValue.IsEmpty then jsNestO.AddPair('Model', fldValue);
    fldValue := Self.Items[I].Color;
    if not fldValue.IsEmpty then jsNestO.AddPair('Color', fldValue);
    fldValue := Self.Items[I].Number;
    if not fldValue.IsEmpty then jsNestO.AddPair('Number', fldValue);
  end;

  jso.AddPair('Auto', jsArr);

  TFile.WriteAllText(fileName, jso.ToJSON);

end;

{ TTripList }

procedure TTripList.loadFromJSON(fileName: TFileName);
var jsv   : TJsonValue;
    originalObject : TJsonObject;

    jsPair : TJsonPair;
    jsArr : TJsonArray;
    jso  : TJsonObject;
    i : integer;
    trip: TTrip;

    FmtStngs: TFormatSettings;

begin

  //parse json string
  jsv := TJSONObject.ParseJSONValue(TFile.ReadAllText(fileName));
  try
      //value as object
      originalObject := jsv as TJsonObject;

      //get pair, wich contains Array of objects
      jspair := originalObject.Get('Trip');
      //pair value as array
      jsArr := jsPair.jsonValue as TJsonArray;

      //enumerate objects in array
      for i := 0 to pred(jsArr.Count) do begin
          // i-th object
          jso := jsArr.Items[i].AsType<TJsonObject>;

          trip := TTrip.Create;
          trip.ID := StrToInt(jso.Values['ID'].Value);
          trip.AutoID := StrToInt(jso.Values['AutoID'].Value);
          trip.DriverID := StrToInt(jso.Values['DriverID'].Value);

          FmtStngs := TFormatSettings.Create('ru-RU');

          trip.StartTime :=
            StrToDateTime(jso.Values['StartTime'].Value, FmtStngs);

          Self.Add(trip);

      end;
  finally
      jsv.Free();
  end;

end;

procedure TTripList.saveToJSON(fileName: TFileName);
var jso, jsNestO: TJSONObject;
    jsArr : TJsonArray;
    I: Integer;

    FmtStngs: TFormatSettings;
begin
  jso := TJSONObject.Create;

  jsArr := TJSONArray.Create;

  for I := 0 to pred(Self.Count) do
  begin
    jsArr.AddElement(TJSONObject.Create);
    jsNestO := jsArr.Items[pred(jsArr.Count)] as TJSONObject;

    FmtStngs := TFormatSettings.Create('ru-RU');

    jsNestO.AddPair('ID', IntToStr(Self.Items[I].ID))
           .AddPair('AutoID', IntToStr(Self.Items[I].AutoID))
           .AddPair('DriverID', IntToStr(Self.Items[I].DriverID))
           .AddPair('StartTime', DateTimeToStr(Self.Items[I].StartTime, FmtStngs));
  end;

  jso.AddPair('Trip', jsArr);

  TFile.WriteAllText(fileName, jso.ToJSON);

end;

end.
