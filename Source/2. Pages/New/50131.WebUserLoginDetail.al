page 50131 "Web User Login Detail"
{

    Caption = 'Web User Login Detail';
    PageType = Card;
    SourceTable = "Web User Login";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Web User ID"; Rec."Web User ID")
                {
                    ToolTip = 'Specifies the value of the Web User ID field';
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field';
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field';
                    ApplicationArea = All;
                }
                field(Password; Rec.Password)
                {
                    ToolTip = 'Specifies the value of the Password field';
                    ApplicationArea = All;
                }
                field("BC User ID"; Rec."BC User ID")
                {
                    ToolTip = 'Specifies the value of the BC User ID field';
                    ApplicationArea = All;
                }
                field("Secret Question"; Rec."Secret Question")
                {
                    ToolTip = 'Specifies the value of the Secret Question field';
                    ApplicationArea = All;
                }
                field(Answer; Rec.Answer)
                {
                    ToolTip = 'Specifies the value of the Answer field';
                    ApplicationArea = All;
                }
                field("Time Zone"; Rec."Time Zone")
                {
                    ToolTip = 'Specifies the value of the Time Zone field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                }
                field("Last Login"; Rec."Last Login")
                {
                    ToolTip = 'Specifies the value of the Last Login field';
                    ApplicationArea = All;
                }
            }
            group(Communication)
            {
                field(Email; Rec.Email)
                {
                    ToolTip = 'Specifies the value of the Email field';
                    ApplicationArea = All;
                }
                field(Phone; Rec.Phone)
                {
                    ToolTip = 'Specifies the value of the Phone field';
                    ApplicationArea = All;
                }
            }
            group(Personal)
            {
                field("Company "; Rec."Company ")
                {
                    ToolTip = 'Specifies the value of the Company  field';
                    ApplicationArea = All;
                }
                field(Designation; Rec.Designation)
                {
                    ToolTip = 'Specifies the value of the Designation field';
                    ApplicationArea = All;
                }
                field("Address 1"; Rec."Address 1")
                {
                    ToolTip = 'Specifies the value of the Address 1 field';
                    ApplicationArea = All;
                }
                field("Address 2"; Rec."Address 2")
                {
                    ToolTip = 'Specifies the value of the Address 2 field';
                    ApplicationArea = All;
                }
                field(Zip; Rec.Zip)
                {
                    ToolTip = 'Specifies the value of the Zip field';
                    ApplicationArea = All;
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field';
                    ApplicationArea = All;
                }
                field(City; Rec.City)
                {
                    ToolTip = 'Specifies the value of the City field';
                    ApplicationArea = All;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ToolTip = 'Specifies the value of the Entry No. field';
                    ApplicationArea = All;
                }
            }
        }

        area(FactBoxes)
        {
            part("Attached Documents"; DocMgtAttachment_Factbox)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                SubPageLink = "Table ID" = CONST(50130),
                              "No." = FIELD("Web User ID");
                Visible = true;
            }
        }
    }

}
