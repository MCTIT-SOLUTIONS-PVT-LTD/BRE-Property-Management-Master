table 50508 "Cheque Table"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50501; "ChequeID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque ID';
        }
        field(50502; "LeaseID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Lease ID';
        }
        field(50503; "ChequeDate"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Date';
        }
        field(50504; "ChequeAmount"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Amount';
        }
        field(50505; "ChequeStatus"; Enum "PDC Status Type Enum")
        {
            DataClassification = CustomerContent;
            Caption = 'Cheque Status';
        }
    }

    keys
    {
        key(PK; "ChequeID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

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