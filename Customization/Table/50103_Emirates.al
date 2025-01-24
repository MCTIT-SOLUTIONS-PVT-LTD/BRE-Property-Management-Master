table 50103 "Emirate"
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
        field(50101; "Sl No."; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sl No.';
            Editable = false;
        }
        field(50102; "Country Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Country Code';
            TableRelation = Country."Country Code";

            // This will store the ID of the Primary Classification for lookup
        }
        field(50103; "Emirate Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Emirate Name';
        }
    }

    keys
    {
        key(PK; "ID", "Emirate Name", "Country Code")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sl No.", ID, "Emirate Name", "Country Code")
        {

        }
    }

    //-------------Record Delete--------------//
    trigger OnDelete()
    var
        EmirateRec: Record "Emirate";
    begin
        // Find all records where 'Sl No.' is greater than the deleted record's 'Sl No.'
        // Set a filter to retrieve records where "Sl No." is greater than the current record's "Sl No."
        EmirateRec.SetRange("Sl No.", "Sl No." + 1, 2147483647); // Set filter to find records with 'Sl No.' greater than the current record

        // Process each of those records and adjust 'Sl No.'
        if EmirateRec.FindSet() then begin
            repeat
                // Decrease 'Sl No.' by 1 for each record
                EmirateRec."Sl No." := EmirateRec."Sl No." - 1;
                EmirateRec.Modify; // Save the modified record
            until EmirateRec.Next = 0; // Move to the next record
        end;
    end;
    //-------------Record Delete--------------//

    //-------------Record Insert--------------//
    trigger OnInsert()
    var
        EmirateRec: Record "Emirate";
    begin
        // Check if 'Sl No.' is 0 (indicating it's a new record)
        if "Sl No." = 0 then begin
            // If there are existing records, find the last one and increment
            if EmirateRec.FindLast then
                "Sl No." := EmirateRec."Sl No." + 1
            else
                "Sl No." := 1; // Start from 1 if no records exist
        end;
    end;
    //-------------Record Insert--------------//
}
