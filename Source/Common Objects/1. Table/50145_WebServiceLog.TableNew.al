table 50145 WebServiceLog
{
    DataClassification = ToBeClassified;
    Caption = 'Web Service Log';

    fields
    {
        field(1; EntryNo; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Entry No.';
            AutoIncrement = true;
        }
        field(2; ServiceName; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Name';
        }
        field(3; ServiceTypeMethod; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type Method';
        }
        field(4; RequestTime; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Requested On';
        }
        field(5; RequestUrl; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Request URL';
        }
        field(6; RequestedBy; CODE[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Requested By';
        }
        field(7; ResponseTime; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Response Time';
        }
        field(8; ResponseStatus; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(9; Request; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Request';
        }
        field(10; Response; Blob)
        {
            DataClassification = ToBeClassified;
        }
        field(11; "Store Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            //TableRelation = MagentoStore;
        }
        field(12; "Status Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Status Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }

    }

    keys
    {
        key(PK; EntryNo)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;


    procedure SetResponse(value: Text)
    var
        outStr: OutStream;
    begin
        Response.CreateOutStream(outStr);
        outStr.WriteText(value);
    end;

    procedure GetResponse(var value: Text)
    var
        inStr: InStream;
    begin
        CalcFields(Response);

        if Response.HasValue() then begin
            Response.CreateInStream(inStr);
            inStr.ReadText(value);
        end
        else
            value := 'No value on the BLOB field';
    end;

    procedure SetRequest(value: Text)
    var
        outStr: OutStream;
    begin
        Response.CreateOutStream(outStr);
        outStr.WriteText(value);
    end;

    procedure GetRequest(var value: Text)
    var
        inStr: InStream;
    begin
        CalcFields(Request);

        if Request.HasValue() then begin
            Request.CreateInStream(inStr);
            inStr.ReadText(value);
        end
        else
            value := 'No value on the BLOB field';
    end;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}


