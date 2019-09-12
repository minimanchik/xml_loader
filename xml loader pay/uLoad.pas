unit uLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls, Oracle, DB,
  OracleData,
  StrUtils, Grids, DBGrids, // ��� ������� PosEx
  FileCtrl, ExtCtrls, DBCtrls, Menus;// ����� ����������

type
  TfLoad = class(TForm)
    XMLDocument1: TXMLDocument;
    qGETFIOADR: TOracleDataSet;
    qGETFIOADRNAME: TStringField;
    qGETFIOADRADDR: TStringField;
    qCheckCLOBL: TOracleDataSet;
    qCheckCLOBLCNT: TFloatField;
    dsGETFIOADR: TDataSource;
    dsCheckCLOBL: TDataSource;
    qEditBD: TOracleDataSet;
    dsEditBD: TDataSource;
    MemoLog: TMemo;
    Panel1: TPanel;
    btnLoad: TButton;
    btnCancel: TButton;
    btnCommit: TButton;
    OracleLogon1: TOracleLogon;
    osLetter: TOracleSession;
    Label1: TLabel;
    procedure btnLoadClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnCommitClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure osLetterBeforeLogOn(Sender: TOracleSession);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }



  public
    { Public declarations }
      function  GetParamPurpose(purpose,param:string;endchar:string): string;
      function OnlyNumber(text:string; point:integer):string;
      function TestPenya(text:string; point:integer):string;
      function  MyExcept(code:string): integer;
      procedure AddFilePayments;
  end;


var
  fLoad: TfLoad;


implementation

{$R *.dfm}

function TfLoad.OnlyNumber(text:string;point:integer): string;
 var i:integer;
 ch:integer;
 begin
  //

  ch:=0;

if point=1 then begin // ��� ����� � ������
 for i:=1 to length(text) do
   begin
     if (not (text[ i ] in ['0'..'9']))and (text[ i ] <> '.') then
       begin
          ch:=1; break;
        end;
     end; // for
end else begin // ����� ��� ����� ���� ������ ��������
    for i:=1 to length(text) do
      begin

        if not (text[ i ] in ['0'..'9']) then
          begin
            ch:=1; break;
            end;
        end; // for

end; //if point

    if ch=1 then begin result:='0' end else result:=text; // ������� ���� ���� ������ � ��������

 end;


function TfLoad.TestPenya(text:string;point:integer): string;  // ������� ��������� ���� �� ������� "������" ��������
 var i:integer;
 ch:integer;
 IntutText:string;
 begin

  ch:=0;

if point=1 then begin // ��� ����� � ������ �������
 for i:=1 to length(text) do
   begin
     if (not (text[ i ] in ['0'..'9']))and (text[ i ] <> ',') then
       begin
          ch:=1; break;
        end;
     end; // for
end else begin // ����� ��� ����� ���� ������ ��������
    for i:=1 to length(text) do
      begin

        if not (text[ i ] in ['0'..'9']) then
          begin
            ch:=1; break;
            end;
        end; // for

end; //if point

    if ch=1 then begin

    IntutText:=InputBox('������ ����','������� ���������� �������� ����'+ #13+'������� ������ �������',text);
    result:=TestPenya(IntutText,1); // ������� �������� (��������� ��� ���)- ���� ���� ����� �� ���������

    end else begin
    result:=text; // ������� ���� ���� ������ � ��������
    end;


 end;




function TfLoad.GetParamPurpose(purpose,param:string;endchar:string): string;
begin
{�������� ������� � ������ purpose ������� � ����� param. ����������� ����� ����������� ';'}

if pos(param,purpose)>0 then begin
   result:=copy(purpose,pos(param,purpose)+length(param), posEx(endchar,purpose,pos(param,purpose))-pos(param,purpose)-length(param));
end else begin
   result:='0'; //��� ����� ������ - �� ����� �������� ��������...
end;

end;

function TfLoad.MyExcept(code:string):integer;
begin
{������� ����������}
  fLoad.MemoLog.Lines.Add(ExtractFileName(XMLDocument1.FileName)+' �� �������� - ������ '+code);
   fLoad.qEditBD.Delete;
  Raise Exception.Create('���� �� ��������. ������ ������� xml '+code+#13+XMLDocument1.FileName); // ��������� ������� - ������� ��� ����� ��������

end;



procedure TfLoad.AddFilePayments;
var
k,i:integer;
sum,cl_id, ob_id, purpose,cname_pay, nom_line: string;
RegPP_count:integer;  // ���������� ��������
RegPP_index:integer;   // ������ ������� � ������ xml
RegPP_last: integer; // ������ ���������� �������

ch_brek_file:integer;

tsr: tsearchrec;
chosenDirectory: string;

DataPP_count:integer; //���������� ������� ������ � ������� // ��� ��������! ������� �������
d_i:integer; //������� ��� ����� �������� �� ������ ������ 

begin

//��������� ������ � xml

if SelectDirectory('�������� ����� � xml','', chosenDirectory) then begin; // ���� ������� ����� � �������
 if FindFirst(chosenDirectory+'\'+ '*.xml',faAnyFile,tsr)=0 then begin  // �������� ������ ���� ���� �� ������ ��� 0 =)
  repeat

// ���������� xml
//showmessage(form1.OD1.Files.Text);
fLoad.XMLDocument1.LoadFromFile(chosenDirectory+'\'+tsr.Name);
fLoad.XMLDocument1.Active:=true;

k:=1;  // ��� ����� DataArea

  fLoad.MemoLog.Lines.Add(' ');
  fLoad.MemoLog.Lines.Add('������ �����: '+ExtractFileName(XMLDocument1.FileName));

// �������� �� ���������� <RegPp>
                                                      //DataArea           //Headr              //Report
if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.count >= 19
then begin

  RegPP_count:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.count-18 ; // ��� �� ������������� ����������� �������� ��� ������ ���� ������ ���� ����� 1
  // ����� ��������� ���� ������ ����� //RegPp

  RegPP_index:=18 ;  // ������ <RegPp> ������ ���� �� 15 �������, ��������� ���������� � 0  // �� 18 ������� � 11.09.2017 (�������� ������)

  //������� ���� ��������
   i:=0;

   while i<RegPP_count do
   begin

      if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[i+RegPP_index].NodeName<>'RegPP'
          then break else i:=i+1;
   end;

    if i=RegPP_count then begin // ���� ��� break � ����� ������ �.�. ������


 try

// �������� ������ ���������� RegPP
  RegPP_last:=RegPP_index+RegPP_count-1;

 while RegPP_index<=RegPP_last do

  begin
    qEditBD.Open;
    qEditBD.Insert;


   if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[9].NodeName='KBK' then begin
	   //���                                                                           //DataArea           //Headr              //Report            //KBK
	   qEditBD.FieldByName('KBK').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[6].text;
	   //���_1                                                                           //DataArea           //Headr              //Report            //KBK
	   qEditBD.FieldByName('KBK_1').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[6].text;
   end else begin
		fLoad.MyExcept('0003');
   end;
   
   //KOl =-1
   qEditBD.FieldByName('KOL').Value:=-1;
   //GUID_OTCH
   qEditBD.FieldByName('GUID_OTCH').Value:=ExtractFileName(chosenDirectory+'\'+tsr.Name);

   // �������� ���-�� �������� � ������� RegPP
   DataPP_count:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.count;

   //������, 20 �������� - ���������� ��������� � int
   //��������� ���� �����������
   d_i:=0;   // ��������� �������

  {��������� ������ � ������� ��������� ������� ������� - ��� ��� ����� ������ ������� }
   while d_i<DataPP_count do
      begin

        if  fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].NodeName='NOM_LS_PLAT' then begin
          //BS_PAY                                                                             //DataArea           //Headr              //Report              //RegPp               //Nom_LS_Plat
          qEditBD.FieldByName('BS_PAY').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].text;
          break;
        end else begin
          if d_i=DataPP_count-1 then fLoad.MyExcept('0004');
          d_i:=d_i+1;
      end;
   end; //while

   //�������� �������� � ������� id ������� � id �������������
   d_i:=0;   // ��������� �������
   while d_i<DataPP_count do
      begin
        if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].NodeName='PURPOSE' then begin
          //purpose                                                    //DataArea           //Headr              //Report                       //RegPp         //PURPOSE
          purpose:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].text ;
          break;
        end else begin
          if d_i=DataPP_count-1 then fLoad.MyExcept('0005');
        d_i:=d_i+1;
      end ;
   end; //while

  // ��� ��� ������ ��������� ��������� ���������� ������ ��� ��������
  // �������� id �������
    cl_id:=GetParamPurpose(purpose,'QUITTID:',';');
    
	if cl_id='0' then begin
		cl_id:=GetParamPurpose(purpose,'CID:',',');
    end;
	
	cl_id:=fLoad.OnlyNumber(cl_id,0); // ��������� �� ������������
    
	// �������� id ���������
    ob_id:=GetParamPurpose(purpose,'PERSACC:',';');

    if ob_id='0'then begin

    // ������ ����� �������� ; (OID:0000000,; )
    ob_id:=GetParamPurpose(purpose,'OID:',';'); //������� oid:
    ob_id:=fLoad.OnlyNumber(ob_id,0);  // ���� ����� ������ ������� �� ������ ����� '0'
	
	if ob_id='0' then begin
		ob_id:=GetParamPurpose(purpose,'OID:',','); //
	end;

    end;

    ob_id:=fLoad.OnlyNumber(ob_id,0); // ��������� �� ������������

    // �L_ID

    qEditBD.SetFields([nil,nil,ob_id,nil,nil,nil,nil,nil,nil,       //05.09.2016 ��������� ��������� ���������� � ����
                        nil,nil,nil,nil,nil,nil,nil,cl_id]);           // �� ����� ���������� � ������ ���
    //�������� id ������� cl_id

    //����� ������ ������� �� �������
    qGETFIOADR.Close;
    //qGETFIOADR.SetVariable('CL_ID',inttostr(strtoint(cl_id)));
    qGETFIOADR.SetVariable('CL_ID',cl_id);
    qGETFIOADR.Open;

   //cname_pay
   cname_pay:=trim(qGETFIOADR.FieldByName('NAME').asstring)+' / '+trim( qGETFIOADR.FieldByName('ADDR').asstring );

   qCheckCLOBL.Close;
   qCheckCLOBL.SetVariable('CL_ID',cl_id);  //05.09.16
   qCheckCLOBL.SetVariable('O_ID',ob_id);  //05.09.16
   qCheckCLOBL.Open;

   if( qCheckCLOBL.FieldByName('CNT').Value ) =0 then
   begin
	  //CNAME_PAY
	  cname_pay:='��������, ������ ���������: '+GetParamPurpose(purpose,'���_�����������:',';')+'/ '+GetParamPurpose(purpose,'�����:',';')+'/ '+GetParamPurpose(purpose,'����������:',';');
	  fLoad.MemoLog.Lines.Add(cname_pay);
   end;
   
   qEditBD.FieldByName('CNAME_PAY').Value:=cname_pay;
   qEditBD.FieldByName('PURPOSE').Value:='������' ; // �� ����� ���� ������� - ������
	   
   // nom_line
   d_i:=0;   // ��������� �������
   while d_i<DataPP_count do
     begin

     if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].NodeName='NOM_LINE' then begin

        //NOM_LINE ����� ������ � ���� 21.03.2018
                                                            //DataArea           //Headr              //Report             //RegPp                  //NOM_LINE
         nom_line:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].text;
         qEditBD.FieldByName('NOM_LINE').Value:=nom_line;
         break;
     end else begin

      if d_i=DataPP_count-1 then fLoad.MyExcept('1001');
        d_i:=d_i+1;

     end;
  end; //while

  // c���� (�����+����)
   d_i:=0;   // ��������� �������
  while d_i<DataPP_count do
    begin

     if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].NodeName='SUM_REESTR_PP' then begin

       //SUM_PP   ���� �������--  SUM + SUM_OST_PO  ����� ���� �� purpose
                                                            //DataArea           //Headr              //Report             //RegPp                  //SUM_REESTR_PP
       sum:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].text;
     if length(sum)=1 then sum:='0'+sum; //

       insert(',',sum,length(sum)-1);
       qEditBD.FieldByName('SUM_PP').Value:=sum;
       break;
  end else begin

       if d_i=DataPP_count-1 then fLoad.MyExcept('0008');
      d_i:=d_i+1;

  end;
  end; // while

   //�������� � ������� sum_pp � ����� ���� 0 ������-��  - ������� ����� ����� �����

  //SUM  - ����� ��� ����
   qEditBD.FieldByName('SUM').Value:=StrToFloat(StringReplace(GetParamPurpose(purpose,'ADDAMOUNT1:',';'),'.',',',[rfReplaceAll])); //���������� ������ �������  GetParamPurpose
   if  qEditBD.FieldByName('SUM').Value ='0' then begin  // ���� ����� ����� 0 �� ����� � �� �����
       //���� ����� ����� 0  �� �� �� ����� ADDAMOUNT1:
       //c 02.05.2017 ���� ����:

       if GetParamPurpose(purpose,'����:',';')='' 
	   then begin 
			qEditBD.FieldByName('SUM_OST_PO').Value:=0;
       end else begin
		   // ��������� ���� �� ���������� � ������ � ����
		   qEditBD.FieldByName('SUM_OST_PO').Value:= StrToFloat(fLoad.TestPenya(GetParamPurpose(purpose,'����:',';'),1))
       end;

   if  qEditBD.FieldByName('SUM_OST_PO').Value='0' // ���� ����: = 0 �.�. �� �����
       then begin
          // �������� �� ������ �����
          qEditBD.FieldByName('SUM').Value:=qEditBD.FieldByName('SUM_PP').Value;
          qEditBD.FieldByName('SUM_OST_PO').Value:=0 // ���� ������������ � 0
       end else begin
          //�������� �� ����� ���� �������� ���� = ����� - ����
        qEditBD.FieldByName('SUM').Value:= qEditBD.FieldByName('SUM_PP').AsFloat - qEditBD.FieldByName('SUM_OST_PO').AsFloat ;
       end;

   end else begin

  //SUM_OST_PO --���� ���� ����� �� purpose
    qEditBD.FieldByName('SUM_OST_PO').Value:=StrToFloat(StringReplace(GetParamPurpose(purpose,'ADDAMOUNT2:',';'),'.',',',[rfReplaceAll])); //���������� ������ �������  GetParamPurpose
  end;

  //����� ���������� ��������� (������ ������� �����������)   // �������� �� 4 11.09.2017
  if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[4].NodeName='NOM_PP' then begin
  //NUM_PP                                                                               //DataArea           //Headr              //Report           //NOM_PP
   qEditBD.FieldByName('NUM_PP').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[1].text;
  end else begin
    fLoad.MyExcept('0009');
  end;


// ���� ���������� ���������
   d_i:=0;   // ��������� �������
	while d_i<DataPP_count do
	   begin

	  if  fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].NodeName='DATE_PAY_DOC' then begin
		  //DATE_PP                                                                               //DataArea           //Headr              //Report                   //RegPp                //DATE_PAY_DOC
		  qEditBD.FieldByName('DATE_PP').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[RegPP_index].ChildNodes.Nodes[d_i].text;
		  break;
	  end else begin
		   if d_i=DataPP_count-1 then fLoad.MyExcept('0010');
		   d_i:=d_i+1;
	  end;
	end; //while


	// DATE_IN_TOFK  - ��� ���� ������� - �.�. ������ ����� �� ��������
	  d_i:=0;   // ��������� �������
	while d_i<DataPP_count do
	   begin


	  if  fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[d_i].NodeName='DATE_PP' then begin
	   //DATE_IN_TOFK                                                                               //DataArea           //Headr              //Report              // DATE_PP
	   qEditBD.FieldByName('DATE_IN_TOFK').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[d_i].Text;
	   break;
	   end else begin
		if d_i=DataPP_count-1 then fLoad.MyExcept('0011');
		d_i:=d_i+1;
	   end;
	end; //while


  //GUID (������ ������� ����������)
   if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].NodeName='GUID_FK' then begin
  //GUID                                                                                 //DataArea           //Headr              //Report           //GUID_FK
   qEditBD.FieldByName('GUID').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].text+' '+inttostr(RegPP_index-14);
   qEditBD.FieldByName('GUID_OTCH').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].text;
   end else begin
    fLoad.MyExcept('0012');
   end;

     //GUID (������ ������� ����������)
   if fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].NodeName='GUID_FK' then begin
  //GUID                                                                                 //DataArea           //Headr              //Report           //GUID_FK
   qEditBD.FieldByName('GUID').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].text+' '+inttostr(RegPP_index-14);
   qEditBD.FieldByName('GUID_OTCH').Value:=fLoad.XMLDocument1.DocumentElement.ChildNodes.Nodes[k].ChildNodes.Nodes[1].ChildNodes.Nodes[12].ChildNodes.Nodes[0].text;
   end else begin
    fLoad.MyExcept('0012');
   end;

  ch_brek_file:=0; // �� ���������
 try
  qEditBD.Post;
 except begin
   showmessage('������ - ���� ��� �������� �����'+#13+ExtractFileName(XMLDocument1.FileName));
   ch_brek_file:=1; // ���� ���� � ������ ������� ��� ������������
   break;
  end;

 end;

   fLoad.btnCancel.Enabled:=true;
   fLoad.btnCommit.Enabled:=true;
   fLoad.btnLoad.Enabled:=false;

   RegPP_index:=RegPP_index+1  // ������� � ��������� RegPP

end; //while


if ch_brek_file=0 then begin
 fLoad.MemoLog.Lines.Add(ExtractFileName(XMLDocument1.FileName)+' �������� /'+inttostr(RegPP_count)+' �������');

 end else begin
 fLoad.qEditBD.Delete;
 fLoad.MemoLog.Lines.Add(ExtractFileName(XMLDocument1.FileName)+' ������ - ���� ��� �������� �����');

 end;

   Except
  On E : Exception do
   ShowMessage(E.Message);
   end


  end else begin
   ShowMessage('���� �� ��������. ������ ������� xml 0002 - �����:'+inttostr(i+RegPP_index) +'.'+#13+ExtractFileName(XMLDocument1.FileName)); //  ��� ����� �� ������ 'RegPP'
   fLoad.MemoLog.Lines.Add(ExtractFileName(XMLDocument1.FileName)+' �� �������� - ������ 0002');
  end;

 end else begin
 ShowMessage('���� �� ��������. ������ ������� xml 0001'+#13+ExtractFileName(XMLDocument1.FileName));  //����������� �������� ������ 16
    fLoad.MemoLog.Lines.Add(ExtractFileName(XMLDocument1.FileName)+' �� �������� - ������ 0001');
 end;



until FindNext(tsr) <>0; //������ � ����� ������ ���
 findClose(tsr);


     fLoad.MemoLog.Lines.Add('');
     fLoad.MemoLog.Lines.Add('�������� ������ ���������. ���-�� ���������: '+inttostr(fLoad.qEditBD.RecordCount));

end else begin
 ShowMEssage('� ����� '+chosenDirectory+' ��� xml ������');
end;
end; // ���� �� ������� ����� � �������

end;


procedure TfLoad.btnLoadClick(Sender: TObject);
begin
fLoad.AddFilePayments;

end;



procedure TfLoad.btnCancelClick(Sender: TObject);
  var
   buttonSelected : Integer;
begin

buttonSelected := MessageDlg('�������� ��������?',mtConfirmation,
                              [mbYes,mbCancel], 0);

if buttonSelected = mrYes  then begin
 qEditBD.Close;
  osLetter.Rollback;
  fLoad.btnCancel.Enabled:=false;
  fLoad.btnCommit.Enabled:=false;
  fLoad.btnLoad.Enabled:=true;

end;



end;

procedure TfLoad.btnCommitClick(Sender: TObject);
begin

 // qEditBD.Post;
  qEditBD.Session.Commit;

fLoad.btnCancel.Enabled:=false;
fLoad.btnCommit.Enabled:=false;
fLoad.btnLoad.Enabled:=true;
MemoLog.Lines.Add('������ ������� � ����');

MemoLog.Lines.Add('');
MemoLog.Lines.Add('');
end;

procedure TfLoad.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  var
   buttonSelected : Integer;
begin

if fLoad.btnLoad.Enabled=false then begin   // ���� �� ���-�� ���������

buttonSelected := MessageDlg('�� ��������� xml ��������� ����� �������',mtConfirmation,[mbYes,mbCancel], 0);

if buttonSelected = mrCancel  then begin
  qEditBD.Close;
      osLetter.Rollback;
        fLoad.btnCancel.Enabled:=false;
          fLoad.btnCommit.Enabled:=false;
            fLoad.btnLoad.Enabled:=true;
end;

 if buttonSelected = mrYes then begin
      qEditBD.Session.Commit;
        fLoad.btnCancel.Enabled:=false;
          fLoad.btnCommit.Enabled:=false;
            fLoad.btnLoad.Enabled:=true;
 end;

end;
end;

procedure TfLoad.osLetterBeforeLogOn(Sender: TOracleSession);
begin
 // --
end;

procedure TfLoad.FormShow(Sender: TObject);
begin
   fLoad.MemoLog.Lines.Clear;
   OracleLogon1.Execute;
   if fLoad.osLetter.LogonPassword=''
   then fLoad.Close;
end;

end.
