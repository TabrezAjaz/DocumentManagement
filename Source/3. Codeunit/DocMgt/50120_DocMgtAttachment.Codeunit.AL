codeunit 50130 "AdvAttachmentManegement"
{
    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeSaveAttachment', '', false, false)]
    procedure BeforeSaveAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; FileName: Text; var TempBlob: Codeunit "Temp Blob")
    var
        recWebUserLogin: Record "Web User Login";
    begin
        // Web User Login
        if DocumentAttachment."Table ID" = Database::"Web User Login" then begin
            Clear(RecRef);
            RecRef.Open(Database::"Web User Login");
            if recWebUserLogin.Get(DocumentAttachment."No.") then
                RecRef.GetTable(recWebUserLogin);
        end;

    end;


    [EventSubscriber(ObjectType::Table, Database::"Document Attachment", 'OnBeforeInsertAttachment', '', false, false)]
    procedure BeforeInsertAttachment(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        FieldRef: FieldRef;
        RecNo: Code[20];
    begin
        case RecRef.Number of
            // Web User Login
            Database::"Web User Login":
                begin
                    FieldRef := RecRef.Field(1);
                    RecNo := FieldRef.Value;
                    DocumentAttachment.Validate("No.", RecNo);
                end;

        end;
    end;


}