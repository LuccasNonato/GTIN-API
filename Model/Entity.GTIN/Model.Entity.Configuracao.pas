unit Model.Entity.Configuracao;

interface

uses
  Model.Entity.GTIN.Interfaces;

Type
  TGTINConf = class(TInterfacedObject, IGTINConf)
    private
     FUsername : string;
     FPassword : string;
     FTokenAccess : string;
     FTokenType : string;
     FTokenExpires : integer;
    public
      constructor Create;
      destructor  Destroy; override;
      class function New : IGTINConf;

      function Username(Value : string) : IGTINConf; overload;
      function Username : string; overload;

      function Password(Value : string) : IGTINConf; overload;
      function Password : string; overload;

      function TokenAccess(const Value: string): IGTINConf; overload;
      function TokenAccess : string; overload;

      function TokenType(const Value: string): IGTINConf; overload;
      function TokenType : string; overload;


      function TokenExpires(const Value: integer) : IGTINConf; overload;
      function TokenExpires : integer; overload;

    end;

implementation

{ TMinhaClasse }

constructor TGTINConf.Create;
begin

end;

destructor TGTINConf.Destroy;
begin

  inherited;
end;

class function TGTINConf.New: IGTINConf;
begin
  Result := Self.Create;
end;

function TGTINConf.Password(Value: string): IGTINConf;
begin
  Result := Self;
  FPassword := Value;
end;

function TGTINConf.Password: string;
begin
 Result := FPassword;
end;

function TGTINConf.TokenAccess: string;
begin
  Result := FTokenAccess;
end;

function TGTINConf.TokenAccess(const Value: string): IGTINConf;
begin
  Result := Self;
  FTokenAccess := Value;
end;

function TGTINConf.TokenExpires(const Value: integer): IGTINConf;
begin
  Result := Self;
  FTokenExpires := Value;
end;

function TGTINConf.TokenExpires: integer;
begin
  Result := FTokenExpires;
end;

function TGTINConf.TokenType: string;
begin
  Result := FTokenType;
end;

function TGTINConf.TokenType(const Value: string): IGTINConf;
begin
  Result := Self;
  FTokenType := Value;
end;

function TGTINConf.Username(Value: string): IGTINConf;
begin
  Result := Self;
  FUsername := Value;
end;

function TGTINConf.Username: string;
begin
  Result := FUsername;
end;

end.
