unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Model.Entity.GTIN.Interfaces,
  Model.Entity.Impl,
  Controller.API.GTIN.Interfaces,
  Controller.API.GTIN,
  Service.Strategy.interfaces,
  system.NetEncoding;

type
  TFrmBuscaGTIN = class(TForm)
    CxInfosProdutos: TMemo;
    CxCodBarras: TEdit;
    LblCodBarras: TLabel;
    GroupBox1: TGroupBox;
    cxUsername: TEdit;
    LblUsername: TLabel;
    cxPassword: TEdit;
    LblPassword: TLabel;
    ImgProduto: TImage;
    Label1: TLabel;
    CbSelecionaAPI: TComboBox;
    Label2: TLabel;
    CxTokenAPI: TEdit;
    procedure CxCodBarrasExit(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarImagemBase64(const Base64Str: string; Image: TImage);
  public
    { Public declarations }
  end;

var
  FrmBuscaGTIN: TFrmBuscaGTIN;

implementation

{$R *.dfm}


procedure TFrmBuscaGTIN.CarregarImagemBase64(const Base64Str: string; Image: TImage);
var
  Bytes: TBytes;
  Stream: TMemoryStream;
begin
  if Base64Str = '' then
  begin
    Image.Picture := nil;
    Exit;
  end;

  Bytes := TNetEncoding.Base64.DecodeStringToBytes(Base64Str);
  Stream := TMemoryStream.Create;
  try
    Stream.WriteBuffer(Bytes[0], Length(Bytes));
    Stream.Position := 0;
    Image.Picture.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TFrmBuscaGTIN.CxCodBarrasExit(Sender: TObject);
var
  Entity: IEntityImplementation;
  Controller: IControllerGTINBuscar;
  Produto: IGTINProdutos;
  Config: IGTINConf;
  GTIN: string;
begin

  GTIN := Trim(CxCodBarras.Text);

  if GTIN = '' then
  Exit;

  try
    Entity := TEntityImplementation.New;

    case CbSelecionaAPI.ItemIndex of
      0: Config := Entity.Configura
                  .Username(cxUsername.Text)
                  .Password(cxPassword.Text);

      1: Config := Entity.Configura
                  .TokenAccess(CxTokenAPI.Text);
    end;


    Controller := TControllerGTINBuscar.New(Config);

    Controller.Buscar(GTIN, CbSelecionaAPI.Text);

    Produto := Controller.Produto;

    cxInfosProdutos.Lines.Clear;
    cxInfosProdutos.Lines.Add('Nome: ' + Produto.Nome);
    cxInfosProdutos.Lines.Add('Marca: ' + Produto.Marca);
    cxInfosProdutos.Lines.Add('Categoria: ' + Produto.Categoria);
    cxInfosProdutos.Lines.Add('CEST: ' + Produto.CEST);
    cxInfosProdutos.Lines.Add('NCM: ' + Produto.NCM);
    cxInfosProdutos.Lines.Add('Nome com Acento: ' + Produto.Nome_Acento);
    cxInfosProdutos.Lines.Add('Unidade Abreviada: ' + Produto.Unid_Abreviado);
    cxInfosProdutos.Lines.Add('País: ' + Produto.Pais);
    cxInfosProdutos.Lines.Add('Data Hora Alteração: ' + Produto.DataHoraAlteracao);
    cxInfosProdutos.Lines.Add('Link Foto: ' + Produto.LinkFoto);

    CarregarImagemBase64(Produto.ImagemBase64, ImgProduto);

  except
    on E: Exception do
      ShowMessage('Erro ao buscar produto: ' + E.Message);
  end;
end;


end.
