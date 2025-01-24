table 50104 "Community"
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
        field(50102; "Emirate Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = '"Emirate Name"';
            TableRelation = Emirate."Emirate Name";

            // This will store the ID of the Primary Classification for lookup
        }
        field(50103; "Community Code"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community Code';
        }
        field(50104; "Community Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Community Name';
            NotBlank = true;
        }
    }

    keys
    {
        key(PK; "ID", "Community Name")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Sl No.", ID, "Community Name", "Emirate Name", "Community Code")
        {

        }
    }

    //-------------Record Delete--------------//
    trigger OnDelete()
    var
        CommunityRec: Record "Community";
    begin
        // Find all records where 'Sl No.' is greater than the deleted record's 'Sl No.'
        // Set a filter to retrieve records where "Sl No." is greater than the current record's "Sl No."
        CommunityRec.SetRange("Sl No.", "Sl No." + 1, 2147483647); // Set filter to find records with 'Sl No.' greater than the current record

        // Process each of those records and adjust 'Sl No.'
        if CommunityRec.FindSet() then begin
            repeat
                // Decrease 'Sl No.' by 1 for each record
                CommunityRec."Sl No." := CommunityRec."Sl No." - 1;
                CommunityRec.Modify; // Save the modified record
            until CommunityRec.Next = 0; // Move to the next record
        end;
    end;

    //-------------Record Delete--------------//

    //-------------Record Insert--------------//

    trigger OnInsert()
    var
        CommunityRec: Record "Community";
    begin
        // Check if 'Sl No.' is 0 (indicating it's a new record)
        if "Sl No." = 0 then begin
            // If there are existing records, find the last one and increment
            if CommunityRec.FindLast then
                "Sl No." := CommunityRec."Sl No." + 1
            else
                "Sl No." := 1; // Start from 1 if no records exist
        end;
    end;
    //-------------Record Insert--------------//

}
