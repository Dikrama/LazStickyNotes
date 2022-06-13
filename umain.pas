unit uMain;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  Buttons, DBCtrls, ZConnection, ZDataset, Grids, Menus;

type

  { TFMain }

  TFMain = class(TForm)
    BitBtn1: TBitBtn;
    Con: TZConnection;
    DS: TDataSource;
    Grid: TDBGrid;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image5: TImage;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem5: TMenuItem;
    Panel1: TPanel;
    Q: TZQuery;
    procedure BitBtn1Click(Sender: TObject);
    procedure ConAfterConnect(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridPrepareCanvas(sender: TObject; DataCol: Integer;
      Column: TColumn; AState: TGridDrawState);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure QAfterOpen(DataSet: TDataSet);
    procedure QBeforePost(DataSet: TDataSet);
  private

  public
   var b:boolean;
  end;

var
  FMain: TFMain;

implementation

{$R *.lfm}

{ TFMain }

procedure TFMain.ConAfterConnect(Sender: TObject);
begin

end;

procedure TFMain.BitBtn1Click(Sender: TObject);
begin
  self.WindowState:=wsMinimized;
end;

procedure TFMain.FormShow(Sender: TObject);
begin
  con.Connect;
  Q.SQL.Text:='select * from data where status<>"Close"';
  Q.Open;
  b:=false;

end;

procedure TFMain.GridPrepareCanvas(sender: TObject; DataCol: Integer;
  Column: TColumn; AState: TGridDrawState);
begin
  if Q.FieldByName('status').AsString='Close' then Grid.Canvas.Brush.Color:=clRed;
end;

procedure TFMain.Image1Click(Sender: TObject);
begin
  Q.Append;
end;

procedure TFMain.Image2Click(Sender: TObject);
begin
  Q.SQL.Text:='update data set status="Close" where id="'+Q.Fields[0].AsString+'"';
  Q.ExecSQL;
  Q.SQL.Text:='select * from data where status<>"Close"';
  Q.Open;
end;

procedure TFMain.Image3Click(Sender: TObject);

begin
  if b then begin
  Q.SQL.Text:='select * from data where status<>"Close"';
  Q.Open;
  b := false;
  image3.Picture.LoadFromFile(extractfilepath(application.ExeName)+'\icons8-hide-30.png');

  end else begin
  Q.SQL.Text:='select * from data order by id desc';
  Q.Open;
  b := true;
  image3.Picture.LoadFromFile(extractfilepath(application.ExeName)+'\icons8-eye-30.png');
  end;
end;

procedure TFMain.Image4Click(Sender: TObject);
begin

end;

procedure TFMain.Image5Click(Sender: TObject);
begin
  Q.SQL.Text:='update data set status="Open" where id="'+Q.Fields[0].AsString+'"';
  Q.ExecSQL;
  Q.SQL.Text:='select * from data where status<>"Close"';
  Q.Open;
end;

procedure TFMain.MenuItem1Click(Sender: TObject);
begin

end;

procedure TFMain.MenuItem3Click(Sender: TObject);
begin
  ShowMessage('GPL Software, Written by Didi Kurniadi');
end;

procedure TFMain.QAfterOpen(DataSet: TDataSet);
begin
  Q.Fields[0].Visible:=false;
  Q.Fields[2].Visible:=false;
  Q.Fields[3].DisplayLabel:='Due Date';
  Q.Refresh;
end;

procedure TFMain.QBeforePost(DataSet: TDataSet);
begin
  Q.FieldByName('Status').Value:='Open';
end;

end.

