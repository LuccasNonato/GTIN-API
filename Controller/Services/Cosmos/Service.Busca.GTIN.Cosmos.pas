unit Service.Busca.GTIN.Cosmos;

interface

uses
  System.Net.HttpClient, System.JSON, System.SysUtils,
  Service.Strategy.Interfaces, System.Classes,
  NetEncoding, Model.Entity.GTIN.Interfaces;

type
  TBuscaGTINCosmos = class(TInterfacedObject, IGTINBuscarGTIN)
  private
    FHttp: THttpClient;
  public
    constructor Create;
    destructor Destroy; override;

    function Buscar(const GTIN: string; Config: IGTINConf; Model: IGTINProdutos): Boolean;

    class function New: IGTINBuscarGTIN;
  end;

implementation

constructor TBuscaGTINCosmos.Create;
begin
  inherited;
  FHttp := THttpClient.Create;
end;

destructor TBuscaGTINCosmos.Destroy;
begin
  FHttp.Free;
  inherited;
end;

class function TBuscaGTINCosmos.New: IGTINBuscarGTIN;
begin
  Result := Self.Create;
end;

function TBuscaGTINCosmos.Buscar(const GTIN: string; Config: IGTINConf; Model: IGTINProdutos): Boolean;
var
  Resp: IHTTPResponse;
  Url, LinkImagem: string;
  JsonResp: TJSONObject;
  BrandObj, NCMObj: TJSONObject;
  ImgStream: TMemoryStream;
  ImgBase64: string;
  BrandName, NCMCode: string;
begin
  Result := False;
  Url := Format('https://api.cosmos.bluesoft.com.br/gtins/%s', [GTIN]);

  try
    FHttp.CustomHeaders['X-Cosmos-Token'] := Config.TokenAccess;
    FHttp.UserAgent := 'Cosmos-API-Request';

    Resp := FHttp.Get(Url);

    if Resp.StatusCode = 200 then
    begin
      JsonResp := TJSONObject.ParseJSONValue(Resp.ContentAsString) as TJSONObject;
      try
        if Assigned(JsonResp) then
        begin
          // brand da api cosmos é um grupo {infos  grupo{x} infos}
          BrandName := '';
          BrandObj := JsonResp.GetValue<TJSONObject>('brand');
          if Assigned(BrandObj) then
            BrandName := BrandObj.GetValue<string>('name', '');

          // ncm também é considerado um grupo {infos  grupo{x} infos}
          NCMCode := '';
          NCMObj := JsonResp.GetValue<TJSONObject>('ncm');
          if Assigned(NCMObj) then
            NCMCode := NCMObj.GetValue<string>('code', '');

          {Global Product Classification [GPC] não foi adicionado mas junto ao manual da api pode ser adicionado}

          LinkImagem := JsonResp.GetValue<string>('thumbnail', '');

          Model.EAN(JsonResp.GetValue<string>('gtin', ''))
               .Nome(JsonResp.GetValue<string>('description', ''))
               .Marca(BrandName)
               .NCM(NCMCode)
               .LinkFoto(LinkImagem);

          if LinkImagem <> '' then
          begin
            ImgStream := TMemoryStream.Create;
            try
              FHttp.Get(LinkImagem, ImgStream);
              ImgStream.Position := 0;
              ImgBase64 := TNetEncoding.Base64.EncodeBytesToString(ImgStream.Memory, ImgStream.Size);
              Model.ImagemBase64(ImgBase64);
            finally
              ImgStream.Free;
            end;
          end;

          Result := True;
        end;
      finally
        JsonResp.Free;
      end;
    end
    else
      raise Exception.CreateFmt('Erro ao buscar GTIN (Cosmos): %d - %s', [Resp.StatusCode, Resp.ContentAsString]);
  except
    on E: Exception do
      raise Exception.Create('Erro na requisição de GTIN (Cosmos): ' + E.Message);
  end;
end;


end.

