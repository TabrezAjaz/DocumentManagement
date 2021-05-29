page 50146 "Web Service Log Details"
{

    Caption = 'Web Service Log Details';
    PageType = Card;
    SourceTable = WebServiceLog;
    LinksAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field(EntryNo; Rec.EntryNo)
                {
                    ToolTip = 'Specifies the value of the EntryNo field';
                    ApplicationArea = All;
                }
                field(RequestTime; Rec.RequestTime)
                {
                    ToolTip = 'Specifies the value of the RequestTime field';
                    ApplicationArea = All;
                }
                field(RequestUrl; Rec.RequestUrl)
                {
                    ToolTip = 'Specifies the value of the RequestUrl field';
                    ApplicationArea = All;
                }
                field(RequestedBy; Rec.RequestedBy)
                {
                    ToolTip = 'Specifies the value of the RequestedBy field';
                    ApplicationArea = All;
                }
                field(ResponseStatus; Rec.ResponseStatus)
                {
                    ToolTip = 'Specifies the value of the ResponseStatus field';
                    ApplicationArea = All;
                }
                field(ResponseTime; Rec.ResponseTime)
                {
                    ToolTip = 'Specifies the value of the ResponseTime field';
                    ApplicationArea = All;
                }
                field(ServiceType; Rec.ServiceTypeMethod)
                {
                    ToolTip = 'Specifies the value of the ServiceType field';
                    ApplicationArea = All;
                }
                field(ServiceName; Rec.ServiceName)
                {
                    ToolTip = 'Specifies the value of the ServicesName field';
                    ApplicationArea = All;
                }
                field("Store Code"; Rec."Store Code")
                {
                    ToolTip = 'Specifies the value of the Magento Store Code field';
                    ApplicationArea = All;
                }
            }
            group(Data)
            {
                field(Request; RequestBlobText)
                {
                    ApplicationArea = All;
                    Visible = true;
                    //Width = 1000;
                    MultiLine = true;
                    trigger OnValidate()
                    var
                        outStr: OutStream;
                    begin
                        Rec.Request.CreateOutStream(outStr);
                        outStr.WriteText(RequestBlobText);
                    end;
                }
                // field(Response; Rec.Response)
                // {
                //     ToolTip = 'Specifies the value of the Response field';
                //     ApplicationArea = All;
                // }
                field(Response; ResponseBlobText)
                {
                    ApplicationArea = All;
                    Visible = true;
                    Width = 1000;
                    ColumnSpan = 4;
                    MultiLine = true;
                    trigger OnValidate()
                    var
                        outStr: OutStream;
                    begin
                        Rec.Response.CreateOutStream(outStr);
                        outStr.WriteText(ResponseBlobText);
                    end;

                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ResponseBlobText := '';
        RequestBlobText := '';
    end;

    trigger OnAfterGetRecord()
    var
        res: Text;
        req: Text;
    begin
        Rec.GetResponse(res);
        Rec.GetRequest(req);
        ResponseBlobText := res;
        RequestBlobText := req;
    end;

    var
        ResponseBlobText: Text;
        RequestBlobText: Text;
}
