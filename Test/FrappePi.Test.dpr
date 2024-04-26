program FrappePi.Test;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  FrappePi.Client in '..\Source\FrappePi.Client.pas';

procedure Auth;
var
  Cli: TFrpappePiClient;
  LoggedUser: string;
begin
  Cli := TFrpappePiClient.Create('https://dev.itmlt.win/{x}');
  try
    Cli.Authenticate('', '');
    LoggedUser := Cli.get_logged_user;
    Writeln(LoggedUser);
  finally
    Cli.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Auth;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;

end.
