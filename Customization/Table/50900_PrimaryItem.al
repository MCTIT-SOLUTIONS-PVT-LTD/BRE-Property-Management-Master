table 50900 "Primary Item"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Primary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Item Type';

        }
    }

    keys
    {
        key(PK; "ID", "Primary Item Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Primary Item Type")
        {

        }
    }



}
