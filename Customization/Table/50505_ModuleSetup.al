table 50505 "Module Setup"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(50501; "Module Name"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(50502; "Is Active"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50504; "Extension Name"; Code[50])
        {
            Caption = 'Extension Name';
        }

        field(50505; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code';
            TableRelation = "Business Unit".Code;
        }

        // field(50501; "Primary Key"; Code[10])
        // {
        //     Caption = 'Primary Key';

        //     DataClassification = ToBeClassified;
        // }
        // field(50502; "Property Management Active"; Boolean)
        // {
        //     Caption = 'Property Management Active';
        // }
        // field(50503; "Property Sales Active"; Boolean)
        // {
        //     Caption = 'Property Sales Active';
        // }


    }

    keys
    {
        key(Key1; "Module Name")
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