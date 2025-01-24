table 50906 "Secondary Item"
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
            Caption = 'Primary Item';
            TableRelation = "Primary Item"."Primary Item Type";

        }
        field(50102; "Category Types"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Category';
            TableRelation = "Category Type"."Category Types";


        }

        field(50103; "Secondary Item Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Secondary Item';

        }

        field(50104; "VAT Type"; Option)
        {
            Caption = 'VAT Type';
            OptionMembers = "Zero-0%","Standard-5%"; // Update this based on the data's classification

            // trigger OnValidate()
            // begin
            //     case "VAT Type" of
            //         0:
            //             "VAT %" := 0; // Zero-0%
            //         5:
            //             "VAT %" := 5; // Standard-1%
            //         // 2:
            //         //     "VAT %" := 2; // Standard-2%
            //         // 3:
            //         //     "VAT %" := 3; // Standard-3%
            //         // 4:
            //         //     "VAT %" := 4; // Standard-4%
            //         // 5:
            //         //     "VAT %" := 5; // Standard-5%
            //         else
            //             "VAT %" := 0; // Default to Zero-0% if no match
            //     end;
            // end;

            trigger OnValidate()
            begin
                case "VAT Type" of
                    0:
                        "VAT %" := 0; // Zero-0%
                    1:
                        "VAT %" := 1; // Standard-5%
                    else
                        "VAT %" := 0; // Default to Zero-0% if no match
                end;
            end;
        }


        field(50105; "VAT %"; Option)
        {
            OptionMembers = "0","5";
            Caption = 'VAT %';
            Editable = false;


            // trigger OnValidate()
            // begin
            //     if "VAT Type" = "VAT Type"::"Standard-5%" then begin
            //         // Automatically set VAT % to 5% if VAT Type is Standard-5%
            //         if "VAT %" <> "VAT %"::"5%" then
            //             Validate("VAT %", "VAT %"::"5%");
            //     end else begin
            //         // Reset VAT % to empty if VAT Type is changed to anything else
            //         if "VAT %" <> "VAT %"::" " then
            //             Validate("VAT %", "VAT %"::" ");
            //     end;
            // end;



        }

        // field(50106; "Payment System"; Option)
        // {
        //     OptionMembers = "","One Time Payment","Installment";
        //     Caption = 'Payment System';

        // }
    }

    keys
    {
        key(PK; "ID", "Primary Item Type", "VAT Type", "VAT %", "Category Types", "Secondary Item Type")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Secondary Item Type", "VAT %", "VAT Type", "Category Types", "Primary Item Type", ID)
        {

        }
    }
}
