page 50133 "DocMgtAttachment_Factbox"
{
    Caption = 'Documents Attached';
    PageType = CardPart;
    SourceTable = "Document Attachment";

    layout
    {
        area(content)
        {
            group(Control2)
            {
                ShowCaption = false;
                field(Documents; NumberOfRecords)
                {
                    ApplicationArea = All;
                    Caption = 'Documents';
                    StyleExpr = TRUE;
                    ToolTip = 'Specifies the number of attachments.';

                    trigger OnDrillDown()
                    var
                        recWUL: Record "Web User Login";
                        DocumentAttachmentDetails: Page "Document Attachment Details";
                        RecRef: RecordRef;

                    begin
                        case Rec."Table ID" of
                            0:
                                exit;
                            DATABASE::"Web User Login":
                                begin
                                    RecRef.Open(DATABASE::"Web User Login");
                                    if recWUL.Get(Rec."No.") then
                                        RecRef.GetTable(recWUL);
                                end;
                            else
                                OnBeforeDrillDown(Rec, RecRef);
                        end;
                        DocumentAttachmentDetails.OpenForRecRef2(RecRef);
                        DocumentAttachmentDetails.RunModal;
                    end;
                }
            }
        }
    }

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    begin
    end;

    trigger OnAfterGetCurrRecord()
    var
        currentFilterGroup: Integer;
    begin
        currentFilterGroup := Rec.FilterGroup;
        Rec.FilterGroup := 4;

        NumberOfRecords := 0;
        if Rec.GetFilters() <> '' then
            NumberOfRecords := Rec.Count;
        Rec.FilterGroup := currentFilterGroup;
    end;

    var
        NumberOfRecords: Integer;
}

