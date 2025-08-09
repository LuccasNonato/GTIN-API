unit Controller.API.GTIN.Interfaces;

interface

uses
  Model.Entity.GTIN.Interfaces;

 type
   IControllerGTINBuscar = interface
     ['{D34CBD6D-03F1-49C4-8DA8-B8BCC8444B68}']
     function Buscar(Value : string; API : string) : IControllerGTINBuscar; overload;
     function Produto: IGTINProdutos;
   end;

implementation

end.
