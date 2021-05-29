table 50130 "Web User Login"
{
    Caption = 'Web User Login';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Web User ID"; Code[20])
        {
            Caption = 'Web User ID';
            DataClassification = ToBeClassified;
        }
        field(2; Password; Text[30])
        {
            Caption = 'Password';
            DataClassification = ToBeClassified;
        }
        field(3; "First Name"; Text[30])
        {
            Caption = 'First Name';
            DataClassification = ToBeClassified;
        }
        field(4; "Last Name"; Text[30])
        {
            Caption = 'Last Name';
            DataClassification = ToBeClassified;
        }
        field(5; Email; Text[50])
        {
            Caption = 'Email';
            DataClassification = ToBeClassified;
        }
        field(6; Phone; Text[30])
        {
            Caption = 'Phone';
            DataClassification = ToBeClassified;
        }
        field(7; "Secret Question"; Option)
        {
            Caption = 'Secret Question';
            DataClassification = ToBeClassified;
            OptionMembers = "What's your first pet name?","What's you first car model?","What's your first crush name?";
        }
        field(8; Answer; Text[250])
        {
            Caption = 'Answer';
            DataClassification = ToBeClassified;
        }
        field(9; "Company "; Text[250])
        {
            Caption = 'Company ';
            DataClassification = ToBeClassified;
        }
        field(10; Designation; Text[250])
        {
            Caption = 'Designation';
            DataClassification = ToBeClassified;
        }
        field(11; "Address 1"; Text[250])
        {
            Caption = 'Address 1';
            DataClassification = ToBeClassified;
        }
        field(12; "Address 2"; Text[250])
        {
            Caption = 'Address 2';
            DataClassification = ToBeClassified;
        }
        field(13; Zip; Text[10])
        {
            Caption = 'Zip';
            DataClassification = ToBeClassified;
        }
        field(14; State; Text[50])
        {
            Caption = 'State';
            DataClassification = ToBeClassified;
        }
        field(15; City; Text[50])
        {
            Caption = 'City';
            DataClassification = ToBeClassified;
        }
        field(16; "Time Zone"; Text[250])
        {
            Caption = 'Time Zone';
            DataClassification = ToBeClassified;
        }
        field(17; "BC User ID"; Code[50])
        {
            Caption = 'BC User ID';
            DataClassification = ToBeClassified;
        }
        field(18; Status; Option)
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;
            OptionMembers = " ",New;
        }
        field(19; "Last Login"; DateTime)
        {
            Caption = 'Last Login';
            DataClassification = ToBeClassified;
        }
        field(50; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
    }
    keys
    {
        key(PK; "Web User ID")
        {
            Clustered = true;
        }
        // key(SK; "Entry No.", "Web User ID")
        // {
        //     Clustered = false;
        // }
    }

}
