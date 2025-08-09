unit Service.Strategy.interfaces;

interface

uses
  Model.Entity.GTIN.Interfaces;

type
  IGTINConfiguracao = interface
    ['{5F1EF139-7D42-418C-8809-0FE0E479D321}']
    function Configurar(const username: string; const password: string; Model: IGTINConf) : Boolean;
    {a separa��o do configurar � moldado separado at� para adi��o de novas APIS
    a configura��o da RSC � com token precisamos passar nome de usuario e algumas propriedades
    j� a cosmos posso fazer passando direto o meu token}
  end;

  IGTINBuscarGTIN = interface
    ['{37A60C80-C175-4955-9ED9-47E145CBDD6B}']
     function Buscar(const GTIN: string; Config: IGTINConf; Model: IGTINProdutos): Boolean;
  end;

implementation

end.
