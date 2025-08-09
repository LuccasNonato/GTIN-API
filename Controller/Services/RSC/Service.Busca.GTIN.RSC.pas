unit Service.Busca.GTIN.RSC;

interface

uses
  System.Net.HttpClient, System.JSON, System.SysUtils,
  Service.Strategy.Interfaces, System.Classes,
  NetEncoding, Model.Entity.GTIN.Interfaces;

type
  TBuscaGTINRSC = class(TInterfacedObject, IGTINBuscarGTIN)
  private
    FHttp: THttpClient;
  public
    constructor Create;
    destructor Destroy; override;

    function Buscar(const GTIN: string; Config: IGTINConf; Model: IGTINProdutos): Boolean;

    class function New: IGTINBuscarGTIN;
  end;

implementation

{ TBuscaGTIN }

constructor TBuscaGTINRSC.Create;
begin
  inherited;
  FHttp := THttpClient.Create;
end;

destructor TBuscaGTINRSC.Destroy;
begin
  FHttp.Free;
  inherited;
end;

class function TBuscaGTINRSC.New: IGTINBuscarGTIN;
begin
  Result := Self.Create;
end;

function TBuscaGTINRSC.Buscar(const GTIN: string; Config: IGTINConf; Model: IGTINProdutos): Boolean;
var
  Resp: IHTTPResponse;
  Url, LinkImagem: string;
  JsonResp: TJSONObject;
  ImgStream: TMemoryStream;
  ImgBase64: string;
begin
  Result := False;
  Url := Format('https://gtin.rscsistemas.com.br/api/gtin/infor/%s', [GTIN]);

  try
    FHttp.CustomHeaders['Authorization'] := Config.TokenType + ' ' + Config.TokenAccess;
    Resp := FHttp.Get(Url);

    if Resp.StatusCode = 200 then
    begin
      JsonResp := TJSONObject.ParseJSONValue(Resp.ContentAsString) as TJSONObject;
      try
        if Assigned(JsonResp) then
        begin
          LinkImagem := JsonResp.GetValue<string>('link_foto', '');

          Model.EAN(JsonResp.GetValue<string>('ean', ''))
               .Nome(JsonResp.GetValue<string>('nome', ''))
               .Marca(JsonResp.GetValue<string>('marca', ''))
               .Categoria(JsonResp.GetValue<string>('categoria', ''))
               .CEST(JsonResp.GetValue<string>('cest', ''))
               .NCM(JsonResp.GetValue<string>('ncm', ''))
               .Nome_Acento(JsonResp.GetValue<string>('nome_acento', ''))
               .Unid_Abreviado(JsonResp.GetValue<string>('unid_abr', ''))
               .Pais(JsonResp.GetValue<string>('pais', ''))
               .DataHoraAlteracao(JsonResp.GetValue<string>('dh_update', ''))
               .LinkFoto(LinkImagem);

          if not LinkImagem.IsEmpty then
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
      raise Exception.CreateFmt('Erro ao buscar GTIN: %d - %s', [Resp.StatusCode, Resp.ContentAsString]);
  except
    on E: Exception do
      raise Exception.Create('Erro na requisição de GTIN: ' + E.Message);
  end;
end;


end.

