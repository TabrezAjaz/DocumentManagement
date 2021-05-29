pageextension 50132 "DocAttachtment_Detail" extends "Document Attachment Details"
{
    var
        FromRecRef: RecordRef;
        TabId: Integer;

    procedure OpenForRecRef2(RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
        DocType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        LineNo: Integer;
    begin
        Rec.Reset;
        FromRecRef := RecRef;
        Rec.SetRange("Table ID", RecRef.Number);
        case RecRef.Number of
            DATABASE::"Web User Login":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    Rec.SetRange("No.", RecNo);
                end;
        end;
    end;
}