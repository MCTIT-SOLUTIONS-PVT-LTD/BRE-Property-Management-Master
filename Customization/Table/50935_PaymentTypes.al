table 50935 "Payment Type"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "Payment ID";

    fields
    {
        field(50100; "Payment ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Payment Method"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Payment Method';

        }
    }

    keys
    {
        key(PK; "Payment ID", "Payment Method")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "Payment ID", "Payment Method")
        {

        }
    }



}
