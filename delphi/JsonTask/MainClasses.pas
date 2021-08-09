unit MainClasses;

interface
uses
  System.Generics.Collections;


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

  TDriverList = class(TObjectList<TDriver>)
  end;

  TAutoList = class(TObjectList<TAuto>)
  end;

implementation

end.
