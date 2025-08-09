program BuscaGTIN;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmBuscaGTIN},
  Service.Configura.Token.RSC in 'Controller\Services\RSC\Service.Configura.Token.RSC.pas',
  Service.Strategy.interfaces in 'Controller\Services\Service.Strategy.interfaces.pas',
  Service.Busca.GTIN.RSC in 'Controller\Services\RSC\Service.Busca.GTIN.RSC.pas',
  Controller.API.GTIN in 'Controller\Controller.API.GTIN.pas',
  Controller.API.GTIN.Interfaces in 'Controller\Controller.API.GTIN.Interfaces.pas',
  Model.Entity.Configuracao in 'Model\Entity.GTIN\Model.Entity.Configuracao.pas',
  Model.Entity.Impl in 'Model\Entity.GTIN\Model.Entity.Impl.pas',
  Model.Entity.Produtos in 'Model\Entity.GTIN\Model.Entity.Produtos.pas',
  Service.Busca.GTIN.Cosmos in 'Controller\Services\Cosmos\Service.Busca.GTIN.Cosmos.pas',
  Model.Entity.GTIN.Interfaces in 'Model\Model.Entity.GTIN.Interfaces.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmBuscaGTIN, FrmBuscaGTIN);
  Application.Run;
end.
