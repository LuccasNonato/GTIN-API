unit Model.Entity.Impl;

interface

uses
  Model.Entity.GTIN.Interfaces,
  Model.Entity.Configuracao,
  Model.Entity.Produtos;


 type
  TEntityImplementation = class(TInterfacedObject, IEntityImplementation)
    private
     FConfiguracao : IGTINConf;
     FProduto : IGTINProdutos;
    public
      constructor Create;
      destructor  Destroy; override;
      class function New : IEntityImplementation;

      function Configura : IGTINConf;
      function DadosProdutos : IGTINProdutos;

    end;

implementation

function TEntityImplementation.Configura: IGTINConf;
begin
  if not Assigned(FConfiguracao) then
  FConfiguracao := TGTINConf.New;

  Result := FConfiguracao;
end;

{ TMinhaClasse }

constructor TEntityImplementation.Create;
begin

end;

function TEntityImplementation.DadosProdutos: IGTINProdutos;
begin
  if not Assigned(FConfiguracao) then
  FConfiguracao := TGTINConf.New;

  if not Assigned(FProduto) then
  FProduto := TGTINProdutos.New;

  Result := FProduto;
end;

destructor TEntityImplementation.Destroy;
begin

  inherited;
end;

class function TEntityImplementation.New: IEntityImplementation;
begin
  Result := Self.Create;
end;

end.
