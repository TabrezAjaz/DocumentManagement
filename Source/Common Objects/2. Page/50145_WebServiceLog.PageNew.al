page 50145 "Web Service Log"
{

    Caption = 'Web Service Log';
    ApplicationArea = All;
    UsageCategory = Lists;
    PageType = List;
    SourceTable = WebServiceLog;
    //Editable = false;
    CardPageId = "Web Service Log Details";
    LinksAllowed = false;
    // Sorting at Page Level
    SourceTableView = sorting(EntryNo) order(descending);

    layout
    {
        area(content)
        {
            repeater(General)
            {
                // field(EntryNo; Rec.EntryNo)
                // {
                //     ToolTip = 'Specifies the value of the EntryNo field';
                //     ApplicationArea = All;
                // }
                field(RequestTime; Rec.RequestTime)
                {
                    ToolTip = 'Specifies the value of the RequestTime field';
                    ApplicationArea = All;
                }
                field(RequestedBy; Rec.RequestedBy)
                {
                    ToolTip = 'Specifies the value of the RequestedBy field';
                    ApplicationArea = All;
                }
                field(RequestUrl; Rec.RequestUrl)
                {
                    ToolTip = 'Specifies the value of the RequestUrl field';
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
                // field(Response; ResponseBlobText)
                // {
                //     ApplicationArea = All;
                //     Visible = true;
                //     Width = 1000;
                // }
                field(ServiceType; Rec.ServiceTypeMethod)
                {
                    ToolTip = 'Specifies the value of the ServiceType field';
                    ApplicationArea = All;
                }
                // field(ServicesName; Rec.ServicesName)
                // {
                //     ToolTip = 'Specifies the value of the ServicesName field';
                //     ApplicationArea = All;
                // }
                field("Status Code"; Rec."Status Code")
                {
                    ApplicationArea = All;
                }
                field("Status Description"; Rec."Status Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
