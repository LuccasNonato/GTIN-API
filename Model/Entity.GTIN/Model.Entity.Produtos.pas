unit Model.Entity.Produtos;

interface

uses
  Model.Entity.GTIN.Interfaces;

Type
  TGTINProdutos = class(TInterfacedObject, IGTINProdutos)
    private
     FEAN : string;
     FEANTipo : string;
     FCEST : string;
     FNCM : string;
     FNome : string;
     FNome_Acento : string;
     FUnit_Abreviado : string;
     FMarca : string;
     FPais : String;
     FCategoria : string;
     FDataHoraAlteracao : string;
     FLinkFoto : string;
     FImagem64 : string;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New : IGTINProdutos;

      function EAN(Value : string) : IGTINProdutos; overload;
      function EAN : string; overload;

      function EAN_Tipo(Value : String) : IGTINProdutos; overload;
      function EAN_Tipo : string; overload;

      function CEST(Value : string) : IGTINProdutos; overload;
      function CEST : string; overload;

      function NCM(Value : string) : IGTINProdutos; overload;
      function NCM : string; overload;

      function Nome(Value : string) : IGTINProdutos; overload;
      function Nome : string; overload;

      function Nome_Acento(Value : string) : IGTINProdutos; overload;
      function Nome_Acento : string; overload;

      function Unid_Abreviado(Value : string) : IGTINProdutos; overload; //CX / UN / KG / ML
      function Unid_Abreviado : string; overload;

      function Marca(Value : string) : IGTINProdutos; overload;
      function Marca : string; overload;

      function Pais(Value : String) : IGTINProdutos; overload;
      function Pais : string; overload;

      function Categoria(Value : String) : IGTINProdutos; overload;
      function Categoria : string; overload;

      function DataHoraAlteracao(Value : string) : IGTINProdutos; overload;
      function DataHoraAlteracao : string; overload;

      function LinkFoto(Value : string) : IGTINProdutos; overload;
      function LinkFoto : string; overload;

      function ImagemBase64(Value: string): IGTINProdutos; overload;
      function ImagemBase64: string; overload;

    end;
implementation

function TGTINProdutos.Categoria: string;
begin
  Result := FCategoria;
end;

function TGTINProdutos.Categoria(Value: String): IGTINProdutos;
begin
  Result := Self;
  FCategoria := Value;
end;

function TGTINProdutos.CEST(Value: string): IGTINProdutos;
begin
  Result := Self;
  FCEST := Value;
end;

function TGTINProdutos.CEST: string;
begin
  Result := FCEST;
end;

{ TMinhaClasse }

constructor TGTINProdutos.Create;
begin

end;

function TGTINProdutos.DataHoraAlteracao(Value: string): IGTINProdutos;
begin
  Result := Self;
  FDataHoraAlteracao := Value;
end;

function TGTINProdutos.DataHoraAlteracao: string;
begin
  Result := FDataHoraAlteracao;
end;

destructor TGTINProdutos.Destroy;
begin

  inherited;
end;

function TGTINProdutos.EAN(Value: string): IGTINProdutos;
begin
  Result := Self;
  FEAN := Value;
end;

function TGTINProdutos.EAN: string;
begin
  Result := FEAN;
end;

function TGTINProdutos.EAN_Tipo: string;
begin
  Result := FEANTipo;
end;

function TGTINProdutos.ImagemBase64: string;
begin
  Result := FImagem64;
end;

function TGTINProdutos.ImagemBase64(Value: string): IGTINProdutos;
begin
  Result := Self;
  FImagem64 := Value;
end;

function TGTINProdutos.EAN_Tipo(Value: String): IGTINProdutos;
begin
  Result := Self;
  FEANTipo := Value;
end;

function TGTINProdutos.LinkFoto: string;
begin
  Result := FLinkFoto;
end;

function TGTINProdutos.LinkFoto(Value: string): IGTINProdutos;
begin
  Result := Self;
  FLinkFoto := Value;
end;

function TGTINProdutos.Marca: string;
begin
  Result := FMarca;
end;

function TGTINProdutos.Marca(Value: string): IGTINProdutos;
begin
  Result := Self;
  FMarca := Value;
end;

function TGTINProdutos.NCM: string;
begin
  Result := FNCM;
end;

function TGTINProdutos.NCM(Value: string): IGTINProdutos;
begin
  Result := Self;
  FNCM := Value;
end;

class function TGTINProdutos.New: IGTINProdutos;
begin
  Result := Self.Create;
end;

function TGTINProdutos.Nome(Value: string): IGTINProdutos;
begin
  Result := Self;
  FNome := Value;
end;

function TGTINProdutos.Nome: string;
begin
  Result := FNome;
end;

function TGTINProdutos.Nome_Acento: string;
begin
  Result := FNome_Acento;
end;

function TGTINProdutos.Nome_Acento(Value: string): IGTINProdutos;
begin
  Result := Self;
  FNome_Acento := Value;
end;

function TGTINProdutos.Pais: string;
begin
  Result := FPais;
end;

function TGTINProdutos.Pais(Value: String): IGTINProdutos;
begin
  Result := Self;
  FPais := Value;
end;

function TGTINProdutos.Unid_Abreviado: string;
begin
  Result := FUnit_Abreviado;
end;

function TGTINProdutos.Unid_Abreviado(Value: string): IGTINProdutos;
begin
  Result := Self;
  FUnit_Abreviado := Value;
end;

end.

