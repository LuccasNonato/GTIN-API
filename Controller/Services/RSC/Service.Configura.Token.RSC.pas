unit Service.Configura.Token.RSC;

interface

uses
  System.SysUtils, System.Classes, System.JSON,
  IdHTTP, IdSSLOpenSSL, IdCoderMIME,
  Model.Entity.GTIN.Interfaces;

type
  TConfiguraTokenRSC = class
  public
    destructor Destroy; override;
    class function New: TConfiguraTokenRSC;
    constructor Create;
    function Configurar(const username, password: string; Model: IGTINConf): Boolean;
  end;

implementation

const
  ENDPOINT_OAUTH_TOKEN = 'https://gtin.rscsistemas.com.br/oauth/token';

{ TConfiguraTokenRSC }

constructor TConfiguraTokenRSC.Create;
begin

end;

destructor TConfiguraTokenRSC.Destroy;
begin

  inherited;
end;

class function TConfiguraTokenRSC.New: TConfiguraTokenRSC;
begin
  Result := Self.Create;
end;

function TConfiguraTokenRSC.Configurar(const username, password: string; Model: IGTINConf): Boolean;
var
  HTTPClient: TIdHTTP;
  SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
  AuthHeader: string;
  Stream: TStringStream;
  Response: string;
  JSONData: TJSONObject;
  TokenValue: string;
begin
  Result := False;
  Stream := TStringStream.Create('', TEncoding.UTF8);
  HTTPClient := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);

  try
    HTTPClient.IOHandler := SSLHandler;
    SSLHandler.SSLOptions.Method := sslvTLSv1_2;
    SSLHandler.SSLOptions.Mode := sslmClient;

    HTTPClient.ConnectTimeout := 10000;
    HTTPClient.Request.Clear;
    HTTPClient.Request.BasicAuthentication := False;

    AuthHeader := 'Basic ' + TIdEncoderMIME.EncodeString(username + ':' + password);
    HTTPClient.Request.CustomHeaders.Clear;
    HTTPClient.Request.CustomHeaders.AddValue('Authorization', AuthHeader);

    HTTPClient.Request.Accept := '*/*';
    HTTPClient.Request.AcceptEncoding := '';
    HTTPClient.Request.UserAgent := 'Delphi HTTPClient';

    try
      Response := HTTPClient.Post(ENDPOINT_OAUTH_TOKEN, Stream);

      if HTTPClient.ResponseCode = 200 then
      begin
        JSONData := TJSONObject.ParseJSONValue(Response) as TJSONObject;
        try
          if Assigned(JSONData) and JSONData.TryGetValue<string>('token', TokenValue) then
          begin
            Model.TokenAccess(TokenValue);
            Model.TokenType('Bearer');
            Model.TokenExpires(0);

            Result := True;
          end
          else
            raise Exception.Create('Token não encontrado na resposta.');
        finally
          JSONData.Free;
        end;
      end
      else
        raise Exception.CreateFmt('Erro na autenticação RSC: %d - %s', [HTTPClient.ResponseCode, Response]);
    except
      on E: Exception do
      begin
        raise;
      end;
    end;
  finally
    Stream.Free;
    HTTPClient.Free;
    SSLHandler.Free;
  end;
end;

end.


