program XML_Loader;

uses
  Forms,
  uLoad in 'uLoad.pas' {fLoad};

{$R *.res}

begin

  Application.Initialize;
  Application.Title := 'XML Loader pay';
  Application.CreateForm(TfLoad, fLoad);
  Application.Run;

end.
