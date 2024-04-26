unit FrappePi.Client;

interface

uses
  CloudApi.Client,
  CloudApi.Parameter;

type
  TFrpappePiClient = class
  private
    FCloudApi: TCloudApiClient;
  public
    constructor Create(const AURL: string);
    destructor Destroy; override;
    procedure Authenticate(const ApiKey, ApiSecret: string);
    function get_logged_user: string;
  end;

implementation

uses
  CloudApi.Request,
  System.SysUtils, CloudApi.Types;

{ TFrpappePiClient }

procedure TFrpappePiClient.Authenticate(const ApiKey, ApiSecret: string);
var
  LAuthParam: TcaParameter;
begin
  FCloudApi.HttpClient.CustomHeaders['Authorization'] :=
    Format('token %s:%s', [ApiKey, ApiSecret]);
  FCloudApi.DefaultParams.Add(LAuthParam);
end;

constructor TFrpappePiClient.Create(const AURL: string);
begin
  FCloudApi := TCloudApiClient.Create(AURL);
  FCloudApi.HttpClient.Accept := 'application/json';
  FCloudApi.HttpClient.ContentType := 'application/json';
end;

destructor TFrpappePiClient.Destroy;
begin
  FCloudApi.Free;
  inherited;
end;

function TFrpappePiClient.get_logged_user: string;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequest.Create;
  LReq.AddUrlSegment('x', '/api/method/frappe.auth.get_logged_user');
  Result := FCloudApi.Execute(LReq).AsJson.GetValue<string>('message');
end;

end.
