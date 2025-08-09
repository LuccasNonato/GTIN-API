unit Controller.API.GTIN;

interface

uses
  System.SysUtils,
  Model.Entity.GTIN.Interfaces,
  Service.Strategy.Interfaces,
  Controller.API.GTIN.Interfaces,
  System.Generics.Collections;

type
  TControllerGTINBuscar = class(TInterfacedObject, IControllerGTINBuscar)
  private
    FConfig: IGTINConf;
    FProduto: IGTINProdutos;
    FStratBusca: TDictionary<string, IGTINBuscarGTIN>;
    FConfiguraAPI: TDictionary<string, TProc>;
    procedure IniciarRegistrarAPI;
  public
    constructor Create(const Config: IGTINConf);
    destructor Destroy; override;

    function Buscar(Value: string; API: string): IControllerGTINBuscar;
    function Produto: IGTINProdutos;

    class function New(const Config: IGTINConf): IControllerGTINBuscar;
  end;

implementation

uses
  Service.Configura.Token.RSC,
  Model.Entity.Impl,
  Service.Busca.GTIN.RSC,
  Service.Busca.GTIN.Cosmos;

{ TControllerGTINBuscar }

constructor TControllerGTINBuscar.Create(const Config: IGTINConf);
var
  Entity: IEntityImplementation;
begin
  inherited Create;

  FConfig := Config; // recebo minhas informacoes de configuracao
  Entity := TEntityImplementation.New; //minha implementation é inicializada
  FProduto := Entity.DadosProdutos; // inicio minha entidade de produtos para obter as informacoes

  {aqui são minhas estrategias uma para configurar e outra para buscar}
  FStratBusca := TDictionary<string, IGTINBuscarGTIN>.Create;
  FConfiguraAPI := TDictionary<string, TProc>.Create;  //metodo anonymo ou no C# conhecido como lambda

  IniciarRegistrarAPI;
end;

destructor TControllerGTINBuscar.Destroy;
begin
  FConfiguraAPI.Free;
  FStratBusca.Free;
  inherited;
end;

procedure TControllerGTINBuscar.IniciarRegistrarAPI;
var
  ConfigToken: TConfiguraTokenRSC;
begin
  {adicionamos RSC e COSMOS no meu dictionary e cada add com seu devido serviço rsc ou cosmos
  apos isso fazemos as validações de config}

  FStratBusca.Add('RSC', TBuscaGTINRSC.New);
  FStratBusca.Add('COSMOS', TBuscaGTINCosmos.New);


  {como eu adicionaria uma nova api?
  FStratBusca.Add('API_NOVA', TBuscaGTINCosmos.New);}

  {FConfiguraAPI.Add('NOVA_API',
    procedure
    begin

      ConfigToken := TConfiguraTokenNOVA_API.New;     <- SE EXISTIR UMA CONFIGURACAO

      try
        if not ConfigToken.Configurar(FConfig.Username, FConfig.Password, FConfig) then  //chamada da minha configuracao do services
          raise Exception.Create('Erro ao configurar autenticação.');
      finally
        ConfigToken.Free;
      end;

    end);}

    {AGORA NO MEU VIEW EM MEU COMBOBOX PASSO O NOVO NOME DA API DENTRO DE MEUS ITEMINDEX}


  FConfiguraAPI.Add('RSC',
    procedure
    begin
      ConfigToken := TConfiguraTokenRSC.New;
      try
        if not ConfigToken.Configurar(FConfig.Username, FConfig.Password, FConfig) then  //chamada da minha configuracao do services
          raise Exception.Create('Erro ao configurar autenticação.');
      finally
        ConfigToken.Free;
      end;
    end);

    {em minha function buscar dei o nome da minha procedure executar  entao é pra ele executar cada coisa de acordo com o valor
    da minha variavel API}

  FConfiguraAPI.Add('COSMOS',
    procedure
    begin
      if FConfig.TokenAccess.IsEmpty then // aqui no cosmos so preciso validar meu access token que é informado no site
        raise Exception.Create('Token de acesso do Cosmos não informado.');
    end);

end;

function TControllerGTINBuscar.Buscar(Value, API: string): IControllerGTINBuscar;
var
  Strategy: IGTINBuscarGTIN;
  Executar: TProc; //procedure anonima herança do meu system.sysutils
begin
  Result := Self;

  if FConfiguraAPI.TryGetValue(UpperCase(API), Executar) then   {aqui passo a usar meu dicionario para pegar a pre config
                                                                e executar meu preauth em API eu ja passei qual vai ser
                                                                e na minha criação ja adicionei cada uma entao quando executo
                                                                meu preauth la em cima eu ja informei o que ele necessita fazer}
    Executar();

  //aqui meu strat ja tem o cosmos e rsc
  FStratBusca.TryGetValue(UpperCase(API), Strategy);


  if not Strategy.Buscar(Value, FConfig, FProduto) then
    raise Exception.Create('Produto não encontrado.');
end;

function TControllerGTINBuscar.Produto: IGTINProdutos;
begin
  Result := FProduto;  //meu result da controller aonde me tras os dados
end;

class function TControllerGTINBuscar.New(const Config: IGTINConf): IControllerGTINBuscar;
begin
  Result := Self.Create(Config);  //meu new já vem com minhas infos de configuração para executar busca de token ou baerer.
end;

end.

