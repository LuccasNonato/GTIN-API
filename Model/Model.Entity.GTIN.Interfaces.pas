unit Model.Entity.GTIN.Interfaces;

interface

  type
       IEntityImplementation = interface;

       IGTINProdutos = interface
         ['{35D70DC7-A7E6-43B3-923F-5A64E16EB689}']
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


       IGTINConf = interface
         ['{1210BEB7-E040-4445-810B-09357E38AC61}']
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


       IEntityImplementation = interface
         ['{6D22C6F5-9C87-4747-84C4-0229F2FC41DF}']
         function Configura : IGTINConf;
         function DadosProdutos : IGTINProdutos;
       end;

implementation

end.
